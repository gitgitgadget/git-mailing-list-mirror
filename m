From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git commit --amen
Date: Thu, 4 Oct 2012 16:57:03 +0200
Message-ID: <CABPQNSYZkAax1iav_qS=0j8=XNDHPsWH_V4BMkpQi63iLb1rtQ@mail.gmail.com>
References: <0d559e3191a392841124d96870a67735@rom1v.com> <CABURp0rbNZSOC_Jtxfjp+j3SQR=+r0pU6vOXvc0Jnth0UU9mDA@mail.gmail.com>
 <ace0aa63d5e822c6cdd5d9a3d20bd675@rom1v.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Phil Hord <phil.hord@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Romain_Vimont_=28=AEom=29?= <rom@rom1v.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:24:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJta0-0001w8-SG
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965408Ab2JDO5p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2012 10:57:45 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:62318 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965200Ab2JDO5o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Oct 2012 10:57:44 -0400
Received: by mail-vc0-f174.google.com with SMTP id fo13so648457vcb.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 07:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=KOJUhhkVyCEoD1THAtBrvFQ2qTC33JC4phdXytVoyC4=;
        b=n0vgLVw+3emaKQGblZCu8d5VLFW0p4YTPrYhkpyvsUr1Xd5yFeJ6NW5cusGq7scaJ4
         YEHmTrrHip+2qUeRpZmcgErD5I49tEGAr/WBLGOCPp+vKklHaKDdIQBRqeofqqCk/5nS
         Wm8G4p28AFYUXFT+4FuMBYjOkaDTHTr/OL8l+bxnGsbRvMnMwQTBJk/HPJ7B0q3G0QdO
         J9bNd1Ma64PwCbA/lH39kiRfUqd6ojQGIuQZMYlcwEmWB6+blyRaAdz2Q+hmHIh1ZsYz
         +h5+DUD3Q8Y6S5e1hgPrntDY28IpB/npW2XbF13gfeRp9fEFHB7IXnU3caxcr/Eo1onC
         fdnQ==
Received: by 10.220.150.14 with SMTP id w14mr3326919vcv.13.1349362663641; Thu,
 04 Oct 2012 07:57:43 -0700 (PDT)
Received: by 10.58.196.232 with HTTP; Thu, 4 Oct 2012 07:57:03 -0700 (PDT)
In-Reply-To: <ace0aa63d5e822c6cdd5d9a3d20bd675@rom1v.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206997>

On Thu, Oct 4, 2012 at 4:38 PM, Romain Vimont (=AEom) <rom@rom1v.com> w=
rote:
> Great !
> Thank you for your answer ;-)
>
> It does not seem to work with git diff:
> git diff --cache     #missing d
> git diff --cumulativ #missing e

This is because git-diff doesn't yet use the parse-options API, but
instead does ad-hoc parsing.
