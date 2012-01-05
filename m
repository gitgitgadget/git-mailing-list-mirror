From: =?UTF-8?B?UmVuw6kgRG/Dnw==?= <doss@gmx.de>
Subject: RE: Re: checkout on an empty directory fails
Date: Thu, 05 Jan 2012 13:38:56 +0100
Message-ID: <4F0599E0.7090902@gmx.de>
References: <4F0576D9.4030207@gmx.de> <CACsJy8A42n4t+WqGaTx7vDQ3jP_YkD1bB0WL9amrrg1B4eOx7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 05 13:39:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rimbs-0006Zp-1L
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 13:39:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756671Ab2AEMjw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jan 2012 07:39:52 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:41486 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756541Ab2AEMjv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jan 2012 07:39:51 -0500
Received: (qmail invoked by alias); 05 Jan 2012 12:39:49 -0000
Received: from 178-25-229-224-dynip.superkabel.de (EHLO linux-nrd1.site) [178.25.229.224]
  by mail.gmx.net (mp027) with SMTP; 05 Jan 2012 13:39:49 +0100
X-Authenticated: #231387
X-Provags-ID: V01U2FsdGVkX19iizw5uIRiX+hR4qs7kegXNomUy1Tm/0Kpzmo+Qc
	KP9CldmU4eBAJT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <CACsJy8A42n4t+WqGaTx7vDQ3jP_YkD1bB0WL9amrrg1B4eOx7w@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187974>

  Thank you for your help. I can not understand what is the mistake? =20
qgit displays me the tree correct.
git status says not special informations.
Only git  checkout .    works.

What means the point in checkout?



Ren=C3=A9


red@linux-nrd1:~/iso/a> git status
# On branch master
# Changed but not updated:
#   (use "git add/rm <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working=20
directory)
#
#       deleted:    SP601_RevC_annotated_master_ucf_8-28-09.ucf
#       deleted:    rtl/ether_speed.vhd
#       deleted:    rtl/ether_top.vhd
#       deleted:    rtl/ether_tx.vhd
#       deleted:    rtl/takt.vhd
#       deleted:    sim/makefile
#       deleted:    sim/tb_ether_top.vhd
#
no changes added to commit (use "git add" and/or "git commit -a")

ed@linux-nrd1:~/iso/a> ls
red@linux-nrd1:~/iso/a> git reset --hard
HEAD is now at efb7b86 Simulation ergaenzt
red@linux-nrd1:~/iso/a> git checkout master
Already on 'master'
red@linux-nrd1:~/iso/a> git checkout .
red@linux-nrd1:~/iso/a> ls
rtl  sim  SP601_RevC_annotated_master_ucf_8-28-09.ucf <--here are the=20
files back!!!!
red@linux-nrd1:~/iso/a>
