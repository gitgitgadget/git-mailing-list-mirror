From: Ilya Dogolazky <ilya.dogolazky@nokia.com>
Subject: Re: git-p4: commits are visible in history after 'git p4 clone',
 but not a single file present
Date: Wed, 13 Jun 2012 15:56:00 +0300
Message-ID: <4FD88DE0.4050606@nokia.com>
References: <4FD5C263.9010307@nokia.com> <CAE5ih79Lgc8vF0v=vTGZSwASsGwQWs2Q7h_AkW67RBfi-R=DCA@mail.gmail.com> <4FD6440C.7090900@nokia.com> <4FD67530.1090002@diamand.org> <4FD70DEB.7040506@nokia.com> <20120612222431.GA13427@padd.com> <4FD83A08.6070208@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Jun 13 14:56:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sen7a-0003bE-FR
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 14:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329Ab2FMM4W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jun 2012 08:56:22 -0400
Received: from smtp.nokia.com ([147.243.1.48]:21632 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753147Ab2FMM4V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 08:56:21 -0400
Received: from [172.21.81.167] (esdhcp09nok081167.ntc.nokia.com [172.21.81.167])
	by mgw-sa02.nokia.com (Sentrion-MTA-4.2.2/Sentrion-MTA-4.2.2) with ESMTP id q5DCu0Xm026742;
	Wed, 13 Jun 2012 15:56:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <4FD83A08.6070208@nokia.com>
X-Nokia-AV: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199888>

Hi !

06/13/2012 09:58 AM, Ilya Dogolazky =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=BB:
> $ P4CLIENT=3Dxexe1 git p4 submit
> Error: Cannot locate perforce checkout of //xxx/yyy/ in client view

After some playing around with git-p4 script and adding debugging=20
printing I realized, that the solution is to do

$ P4CLIENT=3Dxexe1 git p4 clone //xxx/yyy/zzz@all ~/xexe1
instead of just
$ P4CLIENT=3Dxexe1 git p4 clone //xxx/yyy@all ~/xexe1

After that "git-p4 submit" started to work.

I still don't understand p4 enough in order to know why it's happening,=
=20
but now at least I can clone+change+rebase+submit files into the=20
perforce repository with git-p4, which is great.

Luke, Pete: thanks a lot for your help and patience!

Cheers,

Ilya
