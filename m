From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 1/4] completion: be nicer with zsh
Date: Thu, 2 Feb 2012 22:45:39 +0200
Message-ID: <CAMP44s1gWNG+jJ6M7OnLS-1VA5YPa07LJfnrvdbsQb0MOJB7PA@mail.gmail.com>
References: <1328145320-14071-1-git-send-email-felipe.contreras@gmail.com>
	<20120202084859.GC3823@burratino>
	<7v8vklvxwh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 21:45:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt3XO-0006T1-8C
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 21:45:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756583Ab2BBUpn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 15:45:43 -0500
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:44764 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756004Ab2BBUpl convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 15:45:41 -0500
Received: by lbom4 with SMTP id m4so439217lbo.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 12:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ItLnzo1s/JA5ks1KJQXagx2uLI1eP/o0OTavhjmObhc=;
        b=Ff5H/Vn4voAW5ccjs+yAB/aK8sKHBUHbjnjvVQ5NYUwznyA5OZ75sqnuSqnuQ/2+OL
         l27v8BfDWDOsRfw2ncDHSBKbfBA7Fb/kMuVJU/Fs1y1lsjeqR4cEatTmr6GPYqSla8oY
         wKrR9p8FFc8APqSL0JsYL6CLj6tPrITgnY/Gg=
Received: by 10.112.99.202 with SMTP id es10mr1123325lbb.89.1328215539716;
 Thu, 02 Feb 2012 12:45:39 -0800 (PST)
Received: by 10.112.40.202 with HTTP; Thu, 2 Feb 2012 12:45:39 -0800 (PST)
In-Reply-To: <7v8vklvxwh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189705>

On Thu, Feb 2, 2012 at 9:27 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> However, clearly I did not say it clearly enough. :) =C2=A0I guess i=
t's
>> better to take a cue from storytellers and show rather than tell.
>
> Very big thanks for this ;-)

Not a single comment regarding what I said? I don't see what's not
sensible about a commit message with this order:

 1) short description of the *purpose* of the patch
 2) Summary of the problem.
 3) Proposed solution
 4) Extra information, useful for future references, etc.

This ensures the most relevant information for most people is at the to=
p.

--=20
=46elipe Contreras
