From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sun, 9 Jun 2013 21:11:44 +0200
Message-ID: <CALKQrgc5K0U2qCHjjzgxw1=70FbmHdokU3H0tfB_=+7gDVNzsA@mail.gmail.com>
References: <20130608164902.GA3109@elie.Belkin>
	<CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
	<20130608173447.GA4381@elie.Belkin>
	<CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
	<20130609014049.GA10375@google.com>
	<CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
	<20130609052624.GB561@sigill.intra.peff.net>
	<CAMP44s3NhNUuCvW37UaMo9KbHHxZqBE8S15h845vtRi89Bu6WA@mail.gmail.com>
	<20130609174049.GA1039@sigill.intra.peff.net>
	<CAMP44s35w_ysvd5c8oANF8YpWvsquY50bUjSfjOxtujdpgBCPQ@mail.gmail.com>
	<20130609181002.GC810@sigill.intra.peff.net>
	<CAMP44s0ky7ad3cGBQs0DNht4Uo4MR08VrNx+PigcNraDP76CLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 21:11:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ull1u-000397-Az
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524Ab3FITLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:11:50 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:49200 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404Ab3FITLt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:11:49 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1Ull1o-0003jz-Az
	for git@vger.kernel.org; Sun, 09 Jun 2013 21:11:48 +0200
Received: from mail-oa0-f50.google.com ([209.85.219.50])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UlkVN-0006Lo-3G
	for git@vger.kernel.org; Sun, 09 Jun 2013 20:38:17 +0200
Received: by mail-oa0-f50.google.com with SMTP id l20so5088970oag.37
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8KLg0C27e8TVLE+5Ci6ooYB7L7PrnwzuGQqj+pCc+vg=;
        b=gmg7XHfibRkZHYSpme3Nx+KY1VTqCRMPxny1QCkF/E5DPxUFUPEFxzFOA3jTzReopy
         Sp3DN64l+bzI3UjVwqrH8Xl9JiBuz91J5THUDDlc03TGg428nyFekyp8BjuI15kfnHvy
         ekIEbd1ltnNMwSn0TJKNYnQx+DKoNbjYnWyNo/4PUExaW4ROIvt+xxAwUmWSxAEU4HmK
         t/kGnA4Lpub/Et8vSkGRzmfaDHKy5KoYMC2hnjGcs+1eYm5JJNOA6wA6oPQc3AWhxIRN
         4bcyW70rGmZkt2p4FSOXw0KtD2g6kfM2ZttleB/xn8HKXnSUZ/SRm8eT3xT3TVIoyau7
         u1pg==
X-Received: by 10.182.16.137 with SMTP id g9mr3780281obd.17.1370805104708;
 Sun, 09 Jun 2013 12:11:44 -0700 (PDT)
Received: by 10.182.102.5 with HTTP; Sun, 9 Jun 2013 12:11:44 -0700 (PDT)
In-Reply-To: <CAMP44s0ky7ad3cGBQs0DNht4Uo4MR08VrNx+PigcNraDP76CLA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227102>

On Sun, Jun 9, 2013 at 8:16 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sun, Jun 9, 2013 at 1:10 PM, Jeff King <peff@peff.net> wrote:
>> Go back to my 261 commits, show me one that is "unmindful of technical details".
>
> And you say this thread is an excellent example of your point that I'm
> unmindful of technical details?
>
> It's not. There are no technical details I was unmindful of in this thread.

Ok, I'll bite (against my better judgment). From a related thread, a
few minutes ago:

On Sun, Jun 9, 2013 at 7:46 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sun, Jun 9, 2013 at 12:32 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
>> So you would deliberately break a bisection on this test file?
> No, this patch series won't be applied.

Thomas points out a technical detail with the patch series, and the
answer given is 100% non-constructive.

FWIW, I'd like to express my support for the opinions expressed by
Jonathan, Jeff and Thomas. They accurately describe my impression of
these discussion threads.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
