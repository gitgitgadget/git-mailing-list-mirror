From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What are branches?
Date: Sat, 25 Apr 2009 14:11:58 +0300
Message-ID: <94a0d4530904250411k7cb074baidcc5c7d9710115ec@mail.gmail.com>
References: <alpine.DEB.1.00.0904191709220.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 25 13:14:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxfpE-0001yI-Cd
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 13:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbZDYLMG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Apr 2009 07:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752386AbZDYLME
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 07:12:04 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:38597 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297AbZDYLMB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Apr 2009 07:12:01 -0400
Received: by fxm2 with SMTP id 2so1492921fxm.37
        for <git@vger.kernel.org>; Sat, 25 Apr 2009 04:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GFPVjZofvgxQYDVXc8Nrul4TbAWnrWcGjF1t5uOKDDw=;
        b=YL1SDIEcO4lYgCbagI+33GZ+SFVhobHjQKbDI6P7K5Kvn7O2RgwPA6eds+SmMREWiD
         EgJKVmLpcUm3r7iDzmm2b3asUp06C+J7lhDeNRXFkhwLzn9sQY+/wGyeHnyyhL2klJ5P
         tx1AREe2fMXUyLWcvA/t6AfdnVAnlJSvOW2sI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eVIJHPPfan/0F8yzYNz1AaVY07Z+NL3vquT0vFbHThzH/PlArPyQQLOFaTR6ktIdyh
         G6E88NIgwHvh7RSwbA3/sdoNxGul1XhBTpk+pGhlA6fQx5qnKUIREimyCVj9x7P0wkE7
         sH0OeUHbnTTRM1fwC65ON9hYgLMkJdmUp2ZSY=
Received: by 10.86.95.8 with SMTP id s8mr1559057fgb.23.1240657918219; Sat, 25 
	Apr 2009 04:11:58 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904191709220.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117547>

On Sun, Apr 19, 2009 at 6:17 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> if you're like me, you used Git for _way_ too long to really understa=
nd
> how anybody can say that Git is hard to learn. =C2=A0The concepts und=
erlying
> Git have sunk so deep that I do not question them anymore.
>
> But it is important to keep in mind that our concept of branches is n=
ot
> intuitive:
>
> http://longair.net/blog/2009/04/16/git-fetch-and-merge/
>
> In particular, we have some pretty confusing nomenclature when it com=
es to
> branches, and we might want to think how to improve the situation.
>
> Food for thought on a lazy Sunday afternoon.

Completely agree. The problem is that git doesn't really have branches.

In my mind a true branch has a divergence start-point from another
branch, so if you rebase a branch, it must be from the start-point.

What git has been referring to "branches" are actually mere
references. That's why 'git rebase' needs either a start-point
specified manually, or it will need to travel the acyclic graph
finding commits that are not already in the graph of the new
start-point.

AFAIK TopGit makes true branches possible in git.

--=20
=46elipe Contreras
