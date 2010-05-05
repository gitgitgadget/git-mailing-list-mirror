From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: newbie: need concrete examples for how the linux-kernel
 project uses git
Date: Tue, 4 May 2010 20:10:46 -0500
Message-ID: <20100505011045.GA16345@progeny.tock>
References: <m2i408104421005041431l6c8b5845ld57720c2127fbb00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Robert Buck <buck.robert.j@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 05 03:10:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9T8a-0004PE-GR
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 03:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760208Ab0EEBK3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 May 2010 21:10:29 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45453 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760167Ab0EEBK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 21:10:28 -0400
Received: by gyg13 with SMTP id 13so1938303gyg.19
        for <git@vger.kernel.org>; Tue, 04 May 2010 18:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=fH8VxeV7VxvW587qCH6/j2Aqei7i9UMP73yIhw6mrPo=;
        b=X6hnCOiFo4pl4q769S7L91NXwCP9c1uiu3paNeFIIif/mR8KImuRproDtv/kPfaAFt
         8A6OyU43lmumndwEQN0yXoEgFE/M+yB1BoNVOTWlOY+mtJUvhBVqLSQYdluY70dqNMQB
         VgHtdOMZBgeoHc8xeedSGjE/w6FXmuejTGSxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=cmRH+G7Xmpm9dyFYCuEKaQl4MTzlGcr8gmUL3blxzcj9qLp3JH6ngkSF9rOxGA/eph
         PKoZ+qT+dVDIxTT2SLNN4NngUHTTNJhD5G/nTWGZvg7FSf/EHIOQC9rviZzPJuHbvPxb
         xNK2REPraqwMYlvdJMXnQufkrTlwD56HUTst0=
Received: by 10.101.115.1 with SMTP id s1mr4760270anm.165.1273021827228;
        Tue, 04 May 2010 18:10:27 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm781289iwn.0.2010.05.04.18.10.25
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 04 May 2010 18:10:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m2i408104421005041431l6c8b5845ld57720c2127fbb00@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146363>

Hi Robert,

Robert Buck wrote:

> We have multiple teams, lots of developers, and would like to use a
> variant of the dictator-lieutenant scheme discussed in published
> subject matter.
>=20
> However, I find it rather challenging finding any subject matter that
> provides reasonable detail.

Probably you have run into these already.  But for reference...

To be a maintainer:

 - the gitworkflows(7) page[1]

The kernel does not follow all of these practices, but maybe similar
projects could benefit from some. :)

To be a =E2=80=9Cleaf=E2=80=9D contributor (does not require git):

 - the Linux wireless git guide[2]
 - submitting patches to linux-wireless.git[3]
 - guide to tip.git (Linux=E2=80=99s x86 architecture support subsystem=
) [4]

To build a throw-away integration branch:

 - Stephen Rothwell=E2=80=99s linux-next tree[5]

To be, well, anyone:

 - =E2=80=9Ceveryday git in 20 commands or so=E2=80=9D [6]

Patch flow:

 - for Linux wireless [7]
 - for git [8]

Separate =E2=80=9Cinternal use=E2=80=9D and =E2=80=9Cpublic=E2=80=9D tr=
ees:

 - nouveau/linux-2.6 [9]

> What I'd like to find are concrete
> examples, step-by-step, of specifically how to:

If you find these, information for each about

 - where you expected to find it
 - where you actually found it
 - how helpful that information was

would be very useful.  It would be nice to be able to update =E2=80=9Ce=
veryday git=E2=80=9D,
the user manual, the reference manual pages, and other documents to mak=
e
this sort of question easier to answer.

Hope that helps,
Jonathan

[1] http://www.kernel.org/pub/software/scm/git/docs/gitworkflows.html
[2] http://wireless.kernel.org/en/developers/Documentation/git-guide
[3] http://wireless.kernel.org/en/developers/Documentation/SubmittingPa=
tches
[4] http://people.redhat.com/mingo/tip.git/readme.txt
[5] http://git.kernel.org/?p=3Dlinux/kernel/git/next/linux-next.git;a=3D=
tree;f=3DNext
[6] http://www.kernel.org/pub/software/scm/git/docs/everyday.html
[7] http://wireless.kernel.org/en/developers/process
[8] https://git.wiki.kernel.org/index.php/MaintNotes
[9] http://lists.freedesktop.org/archives/nouveau/2009-March/002765.htm=
l
http://cgit.freedesktop.org/nouveau/linux-2.6/
=E2=80=98git rebase=E2=80=99 is the main tool here.
