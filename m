From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv2 04/10] remote: Reject remote names containing '/'
Date: Mon, 13 May 2013 08:32:37 +0200
Message-ID: <CALKQrgeirzRuto4Q==5WY8-idwj+zspcE2OBLO2=0tHMTXuvhg@mail.gmail.com>
References: <1368289280-30337-1-git-send-email-johan@herland.net>
	<1368289280-30337-5-git-send-email-johan@herland.net>
	<CAPig+cR-FkOtGvn+A+JdQ5ia+eUXw6iVzEmOpxCrUgkPttZkVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon May 13 08:32:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbmJS-0002Uo-3B
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 08:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753948Ab3EMGcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 02:32:42 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:54493 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753922Ab3EMGcl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 02:32:41 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UbmJM-0005Tl-VQ
	for git@vger.kernel.org; Mon, 13 May 2013 08:32:40 +0200
Received: from mail-ob0-f177.google.com ([209.85.214.177])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UbkGX-000EtP-GM
	for git@vger.kernel.org; Mon, 13 May 2013 06:21:37 +0200
Received: by mail-ob0-f177.google.com with SMTP id uz6so1243693obc.22
        for <git@vger.kernel.org>; Sun, 12 May 2013 23:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=hLYlry3R5XBwFkZPWxWw2nBd8cuqihCoABIx2y44zjA=;
        b=JHWrQLRBa9wKtOBmC9PF8BMsx+8eOFVWG3a+zc7V37j1fmvlRbX7yhKwHCzPTOhsr3
         kTMjEWHAH2OcHDNfAhvpRNvbHyNNb3HJRGb8ekk4JRAvUdDWXZ88BysDZqqY5s7O/7JQ
         BpPt90bqU2Rp/ICLwN5Lyj+ck0QnJjxU2JD3EZFn6rDQRNfJ2PLhE2bCYOPJzURYeXWO
         bAUDhy0NWt1fLdye6dZBLR3vTpo7r81tVLyMC2YKAZbiSonHkvGLCMHPeGsK7lc7nqKM
         A5cx/W4xTGx6IZA5p/rYaJI5ySmj2z+b0fBixBeyDp6ndwXydibdFNumCEn8mAbvVHzE
         Zytw==
X-Received: by 10.60.58.99 with SMTP id p3mr11995333oeq.23.1368426757315; Sun,
 12 May 2013 23:32:37 -0700 (PDT)
Received: by 10.182.113.66 with HTTP; Sun, 12 May 2013 23:32:37 -0700 (PDT)
In-Reply-To: <CAPig+cR-FkOtGvn+A+JdQ5ia+eUXw6iVzEmOpxCrUgkPttZkVQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224094>

On Mon, May 13, 2013 at 6:48 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, May 11, 2013 at 12:21 PM, Johan Herland <johan@herland.net> wrote:
>> Although we definitely support and encourage use of multi-level branch
>> names, we have never conciously tried to give support for multi-level
>
> s/conciously/consciously/

Thanks, will fix.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
