From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: RFH: Unable to get one big pack
Date: Thu, 18 Jun 2009 17:40:30 +0200
Message-ID: <81b0412b0906180840y62d5c382ha47aebcda3e610f1@mail.gmail.com>
References: <e5bfff550906180755i774576c1o1c540224cea675ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 17:40:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHJjE-0001Y9-Ig
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 17:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752905AbZFRPk3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Jun 2009 11:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbZFRPk3
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 11:40:29 -0400
Received: from mail-fx0-f212.google.com ([209.85.220.212]:49224 "EHLO
	mail-fx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbZFRPk3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jun 2009 11:40:29 -0400
Received: by fxm8 with SMTP id 8so1153051fxm.37
        for <git@vger.kernel.org>; Thu, 18 Jun 2009 08:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aWnEd4Mkdf8rWJ7RaBhFndpw7iDzQSaEPfo3O1LHLc4=;
        b=gV9qUnJmotNrLqLp890vUCiqnY4oXdjkY8ib7OjtQG7W/lWEpos44s2GeCi9DAHWgS
         jjcfpFZDNJgMdWd3SQtFy9RU8KslbgkXHAyyAyQhlH7JXhpXAeMdfGUb40Nwqfjk+rN8
         RTHJfrDnl3d4P6lru/lSq/mkSqTW59nx4cN0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bfjOdIXZozuxmSBUt/UxG4NoBkQGzBVscISsOwhq2GhD1T+IqJyBKSNWE3Nom7pdsD
         7T3zpdawFAxt4W4205VG28TdvBqHsfbOtCsZBTnEplrgDnO26VW4t/17t0UfQNA9nClc
         03vNDqEuGZRpmtgXOchxEAUe/5bHIx4z5qJTY=
Received: by 10.204.64.67 with SMTP id d3mr1470649bki.142.1245339630564; Thu, 
	18 Jun 2009 08:40:30 -0700 (PDT)
In-Reply-To: <e5bfff550906180755i774576c1o1c540224cea675ca@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121850>

2009/6/18 Marco Costalba <mcostalba@gmail.com>:
> Sorry for the silly question, but I have tried anything to get one bi=
g
> pack instead of many objects.
>
> I tried git repack but with no success:
>
> $ git repack -adf
> Counting objects: 3317, done.
> Compressing objects: 100% (3317/3317), done.
> Writing objects: 100% (3317/3317), done.
> Total 3317 (delta 2607), reused 0 (delta 0)
> $ ls -R .git/objects | wc -l
> =C2=A0519
> $

git gc && git prune
