From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv2 1/8] t2024: Add tests verifying current DWIM behavior of
 'git checkout <branch>'
Date: Sun, 21 Apr 2013 00:53:46 +0200
Message-ID: <CALKQrgcKErD79e_TKJ7yMjvQYE45gD=tT_g_ZqQmeLTPueMsrA@mail.gmail.com>
References: <1366470363-22309-1-git-send-email-johan@herland.net>
	<1366470363-22309-2-git-send-email-johan@herland.net>
	<20130420204449.GC8586@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 00:54:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTgfP-0005nR-3n
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 00:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755845Ab3DTWxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 18:53:53 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:59246 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755833Ab3DTWxx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 18:53:53 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UTgfH-0004hd-Je
	for git@vger.kernel.org; Sun, 21 Apr 2013 00:53:51 +0200
Received: from mail-ob0-f179.google.com ([209.85.214.179])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UTgfH-0001FB-Af
	for git@vger.kernel.org; Sun, 21 Apr 2013 00:53:51 +0200
Received: by mail-ob0-f179.google.com with SMTP id x4so2585454obh.38
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 15:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=LCQHObcSgxkXhiCvgRERk7WEHDr62Bc77rmRY/dQT1c=;
        b=Ad/3RFOwf7NPDM3ep5D4GQBpiqgmPIjVYvrlqJXERUrQaoGlhOll2VCbRX4jRWx2a3
         e41ZSKJW4JjSPcm5ww48oDmoCXCMCZ6bkv0qAtJzq6BmtlcoFaJfZ0Yg+vNegWW7uhkv
         2iPdBi81ffZBnLft9zedvtySMJjPDtKfb6BFIFgDjNtkA8r+tlMUle5evB/fVrL6sOn7
         Z3i7+Niy6NDnKR05O1MFDhv1NMwFH6Qf7DgYq4D0c76DOhenElpuG9t9MUzdHF6UzcKj
         rm3XEuBwvu8JQRj1cQmMzkyvMfDXbYlcLPXMCTgF45F2k2J91GOCoECE/GQdOC6hNKqE
         tllQ==
X-Received: by 10.60.29.37 with SMTP id g5mr7328394oeh.140.1366498426700; Sat,
 20 Apr 2013 15:53:46 -0700 (PDT)
Received: by 10.182.210.233 with HTTP; Sat, 20 Apr 2013 15:53:46 -0700 (PDT)
In-Reply-To: <20130420204449.GC8586@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221881>

On Sat, Apr 20, 2013 at 10:44 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Johan Herland wrote:
>
>> The DWIM mode of checkout allows you to run "git checkout foo" when there is
>> no existing local ref or path called "foo" and there is exactly one remote
>> with a remote-tracking branch called "foo".
>
> Thanks for testing this.  I'm surprised no one suggested a test since
> v1.7.0-rc0~51^2~6 (2009-10-18).
>
> Maybe it would also be worthwhile to also test --no-guess?  (c.f.
> 46148dd7, 2009-10-18)

[...]

> Sane?

Yes. Thanks!

Will incorporate your suggestions into the next iteration.


...Johan

--
Johan Herland, <johan@herland.net>
www.herland.net
