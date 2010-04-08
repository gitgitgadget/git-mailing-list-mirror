From: Aghiles <aghilesk@gmail.com>
Subject: Re: git pull suggestion
Date: Thu, 8 Apr 2010 15:33:59 -0400
Message-ID: <p2x3abd05a91004081233j77b7177bm5928913a64de0e57@mail.gmail.com>
References: <r2x3abd05a91004071617z9ffd6e02v83d825405bb6ef1@mail.gmail.com> 
	<201004081754.24954.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Apr 08 21:35:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzxVm-0000ZH-Sk
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 21:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933452Ab0DHTeZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Apr 2010 15:34:25 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:41260 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933241Ab0DHTeV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Apr 2010 15:34:21 -0400
Received: by wwi17 with SMTP id 17so448391wwi.19
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 12:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=6pgvTmgRe/hdre/7Qh7LeVSxrfgx8v0nOJZdqdq5WYY=;
        b=OGnly10eocgh7Rem1UC0WeQrqINO9xup1OT7mbVbOD6Wrnfp99sMsXjW0DaMK042ra
         3nvD/lijB8XTLEsvSbkF1aJvVnENwrk4529hWsQ2drrApl4vlHvbtNA9+hGoV8Y6sERx
         STn9W0P+5arZmc1Lz2SIDWmyfNyD9O2oILrUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=hSes6wbiclwyNCYzL7zuc5ylyPBtKjuhLVmLWmkQ0lccx6rA79TeynmJGiN4jML0II
         todye9vYVT/FPXGsPFoVDIlbUg/o+hOXcEh/+P1ps+EalOzyk2no+zzCS5IwU1zORISf
         IAsX8y1Iq8+OC0/2w7CN5Nx5BKeLMTS40KWPs=
Received: by 10.216.170.8 with HTTP; Thu, 8 Apr 2010 12:33:59 -0700 (PDT)
In-Reply-To: <201004081754.24954.trast@student.ethz.ch>
Received: by 10.216.90.135 with SMTP id e7mr298745wef.34.1270755259138; Thu, 
	08 Apr 2010 12:34:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144373>

>>
>> It would be nice to have _all_ the WIP conflicts listed when pulling=
=2E
>> As of now, one has to fix the currently showed conflict to see the n=
ext one.
>
> Are you using 'git pull --rebase' or the equivalent
> branch.<name>.rebase setting?
>
> If so, note that git-rebase (which does all the hard work) can't know
> the later conflicts once it hits the first one: your resolution of th=
e
> first conflict constitutes the base onto which the further patches ar=
e
> applied. =A0So depending on what changes you make during the resoluti=
on,
> there may be more or fewer conflicts in the rest of the rebase.
>
> If not, I can't see how your question makes sense as ordinary 'git
> pull' does a merge, and during a 'git merge' there can only ever be
> one conflict resolution phase.
>

Sorry, my explanation was not clear. I am talking about changes in the
working directory that are not in the index. So my working directory is
"dirty" and I just issue a 'git pull'. Because some files are not "up t=
o date"
git would abort the pull, saying that a certain file is not "up to date=
".
So I was suggesting to list all the "problematic" files in one go inste=
ad.
Not a biggie of course.

  -- aghiles
