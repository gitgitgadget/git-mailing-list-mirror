From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: finding the commit that deleted a file
Date: Thu, 30 Apr 2009 09:41:46 +0200
Message-ID: <81b0412b0904300041m2ac646cgdaffd4e2dadb9125@mail.gmail.com>
References: <49F953BC.7070303@melosgmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Christoph Duelli <duelli@melosgmbh.de>
X-From: git-owner@vger.kernel.org Thu Apr 30 09:41:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzQu5-0002mS-Cu
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 09:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbZD3Hlt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Apr 2009 03:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbZD3Hls
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 03:41:48 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:38410 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbZD3Hls convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Apr 2009 03:41:48 -0400
Received: by fxm2 with SMTP id 2so1642151fxm.37
        for <git@vger.kernel.org>; Thu, 30 Apr 2009 00:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AKeFzJQZNwV4qOLWZrY+4QhOn/WY5Cs6e+JZsKnDzTE=;
        b=IlQmZTqp14V/m9XzH4nu0yiOwfeAf/DNF9tjlEpZy0xnO2EkUEuYtBXj2x7C6Dm0XI
         ZEQwTfO1A/qRq2Q95vJwXuA/5GNtHKJtynGgGK/h9T6Lqbnu+QeRQ5QVWXmDBDf79Oli
         2tjlp99QHR45++t/KhBjjuSeVVjQWtulNgnaU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WTJpc6pdj/hM9EyQSTnmAAMNOUPKD9wH8aQco53fhp0uQDF17Fv12MKfwvd+bzSz3J
         KrNFCNBWx4kFSmk3qM0mxakI7xn09plT3W4eHuH1HPd0lZ7aFwerwZDxjzF92n8tF8k6
         qOSaO7FrkfpTZEGIRGLqCtA0VHVF5IgQydDHY=
Received: by 10.204.102.76 with SMTP id f12mr1173506bko.137.1241077306707; 
	Thu, 30 Apr 2009 00:41:46 -0700 (PDT)
In-Reply-To: <49F953BC.7070303@melosgmbh.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117996>

2009/4/30 Christoph Duelli <duelli@melosgmbh.de>:
> Following scenario:
> Some file x was deleted (or renamed, but the --follow option does not
> succeed) some 100 commits ago.
> Now, I would like to check the 'lost' contents for some reason.
>
> Is it possible to find out when a given file (path) was deleted?
> (And then, with the obtained SHA1, use gitk or some such tool to insp=
ect
> =C2=A0this file.)

"gitk -- the/name/of/deleted/file" :)
