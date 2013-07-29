From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] editor: use canonicalized absolute path
Date: Mon, 29 Jul 2013 23:18:01 +0530
Message-ID: <CALkWK0=ZekB9uVtzM_z4wbfZ0JWawaob_PspM9UHbVJKyFGBfw@mail.gmail.com>
References: <1375030782-13339-1-git-send-email-artagnon@gmail.com>
 <7v8v0p2z45.fsf@alter.siamese.dyndns.org> <CALkWK0=dGmMkgvaNV27E3Pb3+SWSZ2pNMOr-wsEcUR_wgLjMFA@mail.gmail.com>
 <7vwqo91dgw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 29 19:49:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3rZ9-0002lz-N1
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 19:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758457Ab3G2Rsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 13:48:52 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:43008 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758452Ab3G2Rsl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 13:48:41 -0400
Received: by mail-oa0-f42.google.com with SMTP id i18so5388430oag.1
        for <git@vger.kernel.org>; Mon, 29 Jul 2013 10:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=b+bH4PvDtU+L94Dz21uOv0KsuL7l0fiy35EBmbiTCcY=;
        b=0c1b7SLnzLCy1WvO3hFdptGryJS6WRL90vxXJWPDETdC2zXenxIowi/tt2VpHpTivI
         e6dfp5ekqsWniEPAWGbfISj5cdqtf++8Cg+xrlyERn6Rr6o8Srl8VdVGsMxdvpZEm/uy
         rsuHYRu8SLOa7TI42m4nsKtcDcpZMdKsci+u0LCXSqmKITCAIHj7kGNTHpR/wBXU1bUX
         6SaUI8uLz6qF0tPOjG87h3CeR4/LIhUyATiw7T2jX9pfuPMmmL6dOudBYk0ceQ6b14mJ
         8KSe//HogJtH78/qGfYkTM0OgYE+iLd+tZM1FTlpjmHl7jYgrTy3H66BQWMZ7TMRTYLz
         3n2w==
X-Received: by 10.50.6.16 with SMTP id w16mr1153340igw.29.1375120121128; Mon,
 29 Jul 2013 10:48:41 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Mon, 29 Jul 2013 10:48:01 -0700 (PDT)
In-Reply-To: <7vwqo91dgw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231306>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>> Junio C Hamano wrote:
>>> That's a bit strange---the patch text looks like the "how about
>>> this" patch Duy posted earlier.  Shouldn't it be From: Duy with
>>> S-o-b: by two of you instead?
>>
>> Feel free to amend as you see fit, as always.
>
> I was asking what is "correct", without which I cannot "feel free"
> to do anything, and your answer is not helping.

I don't have a strong opinion either way. Fwiw, I posted the original
with me as the author because I discovered it, dug through the emacs
sources for hours to find the exact bug, and contacted emacs-devel
about it. But no, I do not think there is anything "correct" about it.
