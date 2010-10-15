From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Fri, 15 Oct 2010 18:39:09 -0500
Message-ID: <AANLkTim6w54CPhw0GzaDxT9e0t19XQ7-rMEe5aSBevS+@mail.gmail.com>
References: <AANLkTi=PwLmKSb_gF=k+xVSZfM1CDCFZFZdR7pLgh6t6@mail.gmail.com> <2196050.492435.1287154246295.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	David Barr <david.barr@cordelta.com>,
	Tomas Carnecky <tom@dbservice.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Sat Oct 16 01:39:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6tsC-0005Yx-QC
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 01:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262Ab0JOXjc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Oct 2010 19:39:32 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41595 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153Ab0JOXjb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Oct 2010 19:39:31 -0400
Received: by yxm8 with SMTP id 8so619835yxm.19
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 16:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=IfQ2ytLAEnEUtD76aENgjo1zTn45Kos1yIvzU2sGRnM=;
        b=OxVupMqv4YoWPpio6+xUv6ORPkCMbJi/clS8ecI1GRgEiV+Xf/nYaMroKg/YAgzpRG
         2kxqYsfF8cXZ7ANxvnsVz3m+U2YTQ/ObmRNJVDLMKEsqAYlgEl3hCT8iGzXBPUkifFlX
         UQJQ3+BrE4/ZPVle6MC881HaoR5Re4NtKPwiY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=RDP4vvSShpkNWK8g2GdnEe3Ug/w4C4cRmekpP5ewHVb0MtpYjhC36qm1PhZw5CK7Cq
         5OenSzJkv+7dmsKCe/ebY4C9Ypp2yfgZVoycjeSDofsp9I+n2InoFn8ytGSpdrZUdVEw
         A6DFBSWa/bkLjpKUyQAqXYzrRp3YT+urLWDdk=
Received: by 10.151.87.10 with SMTP id p10mr2583509ybl.101.1287185970592; Fri,
 15 Oct 2010 16:39:30 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Fri, 15 Oct 2010 16:39:09 -0700 (PDT)
In-Reply-To: <2196050.492435.1287154246295.JavaMail.root@mail.hq.genarts.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159149>

Heya,

On Fri, Oct 15, 2010 at 09:50, Stephen Bash <bash@genarts.com> wrote:
> The process can certainly be streamlined. =C2=A0As is often the case,=
 this
> process was created via the "just make it work" mentality (and a bare=
ly
> passable knowledge of git).

=46air enough :)

> But I'm also looking at this from a one-time conversion view. =C2=A0I=
 had a
> couple of conversations with Ram that showed me my point of view is
> very narrow compared to the larger git-remote-svn effort...

Yeah, we not only want 'git-remote-svn' to be able to do incremental
imports, but we also want it to be able to push back to svn.

> I think using notes is a better way to associate conversion informati=
on
> with commits, but I would probably still end up mining the notes to c=
reate
> some sort of svn to git mapping... =C2=A0Correct me if I'm wrong, but=
 I don't see
> how notes would help me get from an svn rev to a git sha (a common
> practice for tickets and wiki links in our organization).

Ah, hmm, that is a good point. Couldn't you just tag object
0000000000000000143 for svn revision 143?

> I guess after that I should add that I'm happy to help, I'm just not =
sure
> where my experience maps to the on going effort.

Just general feedback, sanity checking, and if you're interested,
"beta testing" I think would be very useful :).

--=20
Cheers,

Sverre Rabbelier
