From: =?ISO-8859-1?Q?Ren=E9_Do=DF?= <doss@gmx.de>
Subject: checkout on an empty directory fails
Date: Thu, 05 Jan 2012 11:09:29 +0100
Message-ID: <4F0576D9.4030207@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 05 11:10:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RikHK-0005dD-OB
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 11:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755040Ab2AEKK3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jan 2012 05:10:29 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:39424 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754908Ab2AEKK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jan 2012 05:10:28 -0500
Received: (qmail invoked by alias); 05 Jan 2012 10:10:27 -0000
Received: from 178-25-229-224-dynip.superkabel.de (EHLO linux-nrd1.site) [178.25.229.224]
  by mail.gmx.net (mp019) with SMTP; 05 Jan 2012 11:10:27 +0100
X-Authenticated: #231387
X-Provags-ID: V01U2FsdGVkX1+aBds0TkyaLcNdo1rCNAMX61A2ajj2bKpsfLSrwh
	k0DzNebhrwFqmX
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110624 Thunderbird/5.0
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187968>

I have a clean derectory ang the git database. Now I want check out the=
=20
master.
The master is the last commit. The files name  are displayed but not=20
stored out in directory.

Why can not I  check out?

Ren=E9 Do=DF



red@linux-nrd1:~/iso/a> ls -a
=2E  ..  .git
red@linux-nrd1:~/iso/a> git checkout master
D       SP601_RevC_annotated_master_ucf_8-28-09.ucf
D       rtl/ether_speed.vhd
D       rtl/ether_top.vhd
D       rtl/ether_tx.vhd
D       rtl/takt.vhd
D       sim/makefile
D       sim/tb_ether_top.vhd
Already on 'master'
red@linux-nrd1:~/iso/a> ls
red@linux-nrd1:~/iso/a>
