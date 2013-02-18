From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Mon, 18 Feb 2013 23:43:01 +0530
Message-ID: <CALkWK0ne3GX7wA1U0-TnMqU3mTFNe12TQ_s0=2MVJ=BMs8tirA@mail.gmail.com>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch> <87k3q5zfaa.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 18 19:13:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7VDo-00044V-3c
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 19:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601Ab3BRSNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 13:13:23 -0500
Received: from mail-bk0-f54.google.com ([209.85.214.54]:55546 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028Ab3BRSNX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 13:13:23 -0500
Received: by mail-bk0-f54.google.com with SMTP id w5so2676597bku.41
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 10:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=WMOex3i9oYZk7q1HdNCKMkoWT/++iDelQQBgx5n2e+k=;
        b=y4118VEGvjUBk3OXc6G0elS0vG7lvLvTAn8+/laqM5H9Eqtpxqh53xrPITpKKFRwEu
         HrAbo/OvxLETZ82e02K9j0J5lg7HozTwPmjz02O2jd/Yo9160jlK3Cm03JwAiZ/w4UwZ
         DblDAMHNM9v5rmFUy4nSW/isVe7BJrdgJlWg2mkoe4KqW89GZY5xOrOwI5YOAZB8JNEe
         iY6jvddmXWFzhm8wl/qRjDZs+sfsaZGDSSleRrNkUSmbnPNiw/BD3OYzJpvJypFO/XWU
         GM9hQg8AIbWNWNhGJW76cqV9tsFSLNliONzNZXIiz6Z07pGqHQZjG01wT6POVP71NSE5
         GFRQ==
X-Received: by 10.204.157.6 with SMTP id z6mr5066136bkw.73.1361211201701; Mon,
 18 Feb 2013 10:13:21 -0800 (PST)
Received: by 10.205.81.202 with HTTP; Mon, 18 Feb 2013 10:13:01 -0800 (PST)
In-Reply-To: <87k3q5zfaa.fsf@pctrast.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216488>

Thomas Rast wrote:
> 2. Improving the `git add -p` interface
>    ------------------------------------

>     * The terminal/line-based interface becomes a problem if diff hunks
>       are too long to fit in your terminal.

I don't know if it's worth coming up with another interface.  The best
solution for this is editor integration, in my opinion.  I use Magit
mostly for just the graphical staging/ unstaging.  There's also a
Fugitive.vim for vim.

>     * Cannot look at the diff in word-diff mode (and apply it normally).

Yes, this is a major limitation that would be nice to fix.
Also: Having to figure out, heuristically, when to actually turn it on
might be a worthwhile feature, especially for services like GitHub.

>    As the existing code is written in Perl, that is what you will use for
>    this project.

I don't know- is Perl a possible deterrent?
Won't getting a word-diff to apply involve C work though?  (patching
builtin/apply.c?)
