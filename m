From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Is there interest in reading ~/.gitconfig.d/* and 
	/etc/gitconfig.d/*?
Date: Tue, 6 Apr 2010 08:15:35 +0000
Message-ID: <u2i51dd1af81004060115t5f837840z5adcf83622fa8882@mail.gmail.com>
References: <z2s51dd1af81004011420ka5d3a800kf6b3e4591527fc12@mail.gmail.com>
	 <alpine.DEB.2.00.1004040922500.30612@perkele.intern.softwolves.pp.se>
	 <19384.17579.205005.86711@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Tue Apr 06 10:16:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz3x1-00075T-RD
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 10:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035Ab0DFIPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 04:15:40 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:38029 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698Ab0DFIPh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 04:15:37 -0400
Received: by bwz1 with SMTP id 1so3367055bwz.21
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 01:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=j+pNNQJNj+tnto5kRJjX2/EkLh7Bee2GVD21/BQ4eio=;
        b=wFT/SvwUF0/CENVhhCijX1mvlua+7RjoL0pBIHgNAVH90F37bsCFu699qDKJ/G7MOa
         qO5Uc3JCzmZD3aScNmNH8H1UgUmnLDotlY72WmA5TyvUrS3oHDqORCAHC7RUXN9OMbSP
         18keb0HEvl8r6eMZfDjxNyzF0VFUcOtbiRRhk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=s/94AjRjE06YSjKGD2zPljzjeep2fDrMtuE7uGK5tub2EnJrbaQaWOeFAleE9gwpq3
         AymZecvHmk8xgiG8TSQumiemlBxIG38HtLb/6ktCnNYeRMuOjFiVwMu4DdTM0ShK/upz
         1pP/ce7VXu9Sp345p8/SeIWyw0IRCA0/wPjnQ=
Received: by 10.204.121.195 with HTTP; Tue, 6 Apr 2010 01:15:35 -0700 (PDT)
In-Reply-To: <19384.17579.205005.86711@winooski.ccs.neu.edu>
Received: by 10.204.146.135 with SMTP id h7mr7091164bkv.200.1270541735955; 
	Tue, 06 Apr 2010 01:15:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144113>

On Sun, Apr 4, 2010 at 07:50, Eli Barzilay <eli@barzilay.org> wrote:
> Isn't it better to have a way to include files instead?

Probably yes. Programs like Apache HTTPD, rsyslog and others just use
${foo}conf.d by convention by supporting config inclusion.

What would be the ideal config syntax for that? AFAICT git-config
doesn't (yet) support top-level keys so maybe this:

    [INCLUDE]
        path = ~/.gitconfig.d/*

Or if top-level support was added:

    INCLUDE = ~/.gitconfig.d/*
