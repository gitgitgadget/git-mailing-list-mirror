From: Mike Gorchak <mike.gorchak.qnx@gmail.com>
Subject: Re: [PATCH 1/1] Add pthread support in QNX. Do not declare NO_ macros
 if they can be autodetected.
Date: Tue, 26 Feb 2013 20:38:19 +0200
Message-ID: <CAHXAxrMBnMzB5zm7AyS9dXD6e5vO6UFgcAg_Q=+8ktxQaXk4Dw@mail.gmail.com>
References: <CAHXAxrPTe6Q4BPtsGjiRnfFjZjUjwY6qXSAtZCzzAthODzA6EA@mail.gmail.com>
	<7vhal0z4a5.fsf@alter.siamese.dyndns.org>
	<CAHXAxrO8c8=d+og7rJexY4MKyKMYrWAzFYLMLRKVqtoaB6DUdQ@mail.gmail.com>
	<7vbob7lzsk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Matt Kraai <kraai@ftbfs.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 19:38:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAPQM-0007tW-DR
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 19:38:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759679Ab3BZSiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 13:38:21 -0500
Received: from mail-qe0-f53.google.com ([209.85.128.53]:40791 "EHLO
	mail-qe0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758236Ab3BZSiU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 13:38:20 -0500
Received: by mail-qe0-f53.google.com with SMTP id 1so2788633qee.40
        for <git@vger.kernel.org>; Tue, 26 Feb 2013 10:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=QGY/tJknbsX2Gd/DQKSQxXCXR8vTIeH2825snr3dND4=;
        b=wJ8TSlFmDxrVXiqq9C4HEkbH5S+OGJ2doG7fFjZj2C2qkxy37RGxtgV9DJW2gdK+0x
         6tNuBzfTZ0+GMtn1HEUxw/dQLk3gvnBTxJLGZL628lk4ipovGT0Pv5h4CcIjN7AjYM5r
         yaO5TEYEcm+KuIUC6nbfBllBCZQ3YC7XuXJy1XBmMewj+O0IF/UN/0UcrfwpkAMPXv3h
         08ca9I/njVNlFwOgXD3Dl39USlBMQgZcMFUyeK03kLAlm3xFnV3xgfX5sNAl/syDzkH6
         NOpcQKHXYyzkhjD7M1M6uzQ4c/+rMh6+qvGJaaKu+5SbDvLgQumEcK1OD3ovJSBMeTaS
         kuWw==
X-Received: by 10.49.127.199 with SMTP id ni7mr21627980qeb.17.1361903899876;
 Tue, 26 Feb 2013 10:38:19 -0800 (PST)
Received: by 10.49.71.68 with HTTP; Tue, 26 Feb 2013 10:38:19 -0800 (PST)
In-Reply-To: <7vbob7lzsk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217157>

> I saw Matt has comment on this patch, so I'll keep the patch out of
> 'next' for now and let you two figure it out.

Anyway in current form this patch is broken. Junio, may I ask you
about the rest patches in a separate posts, have you applied any of
them?

Thanks.
