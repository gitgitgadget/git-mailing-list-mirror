From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: Any way to "flatten" a series of changes in git
Date: Fri, 23 Oct 2009 06:40:30 +0100
Message-ID: <26ae428a0910222240w7956e57dn325afcdd15aa2cb@mail.gmail.com>
References: <26ae428a0910221303n493fb7s701269d694110685@mail.gmail.com>
	 <m3hbtrdu1r.fsf@localhost.localdomain>
	 <26ae428a0910221411l73aa7cbak5c060925ccdf4cea@mail.gmail.com>
	 <200910222357.15189.jnareb@gmail.com>
	 <26ae428a0910222236l58bc64b7l12c4cff09b086dac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 07:40:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1CtB-0002hV-1c
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 07:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbZJWFk1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Oct 2009 01:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbZJWFk1
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 01:40:27 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:37159 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbZJWFk0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Oct 2009 01:40:26 -0400
Received: by ewy4 with SMTP id 4so1319473ewy.37
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 22:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=Nfq4nfccveFewb00Ej5rvfF9BG71/ON6vYZvLZjdXKQ=;
        b=NSkz5E3Km1ga5D7sb/Uujn/bVoN+ahvsg1s60BFSYs3x/W4L1lvt48eoNYatFUbOJC
         lQqG49ft9KdhL+LIhx+JAQ1YWWAOvEEDI4TI3pu7TLqgdct0VyXoOoI2xlYTySW+SjQB
         EivKleCIniPBeDUtD7yDcDM+4OzXmRjd24o5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=BnLUimlXGa6ZSvnlBAUn5u2GfCaWQZvi93BfKyU/4pMuFSabDeHBHalnAfcAJ4gasi
         RKmhiN3ZUzyDzbD+EEvX3LiHmBnmMxhjGmY0ZVd7jg9teyHjwQI5944MXuCdkXVsDWoh
         H5A17z6iZje3gptjDw0ctDtKzpacdFb7jPVSQ=
Received: by 10.216.85.68 with SMTP id t46mr861633wee.114.1256276430647; Thu, 
	22 Oct 2009 22:40:30 -0700 (PDT)
In-Reply-To: <26ae428a0910222236l58bc64b7l12c4cff09b086dac@mail.gmail.com>
X-Google-Sender-Auth: e50e1029f75a5b03
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131087>

>
> Hi Jakub,
>
> Yes it helps a lot. What I *don't* care about (or want to do) is
> actually do a merge or a rebase I just want to change history. Well,
> that's what I thought I wanted. What I suppose I really want is the
> full history for *me* and a second branch with the 'reduced' history
> to push to my client. =A0I suppose that's different yet again?
>
> Howard
>

Actually, what I should have said in the first place is that this is
specifically nothing to do with the main trunk. We are doing small
custom developments for clients away from the main project
development. So we specifically don't want to merge or rebase with the
master - that's never going to happen. I want to keep the development
branch in tact for my reference, but when I push (the custom
development branch) to the client I need that sanitized. I think I
finally have it clear in my own head now!

Howard
