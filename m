From: Andreas Ericsson <ae@op5.se>
Subject: Re: Use case: GIT to manage transactions in a CMS?
Date: Wed, 15 Feb 2006 12:45:24 +0100
Message-ID: <43F31454.8060704@op5.se>
References: <43F30602.500@itaapy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 12:45:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9L69-000761-CT
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 12:45:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWBOLp0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 15 Feb 2006 06:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWBOLp0
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 06:45:26 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:47496 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751080AbWBOLpZ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 06:45:25 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id C52DC6BCBE; Wed, 15 Feb 2006 12:45:24 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: =?ISO-8859-15?Q?=22J=2E_David_Ib=E1=F1ez=22?= <jdavid@itaapy.com>
In-Reply-To: <43F30602.500@itaapy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16238>

J. David Ib=E1=F1ez wrote:
> Hello,
>=20
> I am working on a project (a content management system) where the dat=
a
> is stored as files and folders.
>=20
> Currently, for persistance and transactions we use the ZODB [1] objec=
t
> database. But our goal is to move away from the ZODB and use directly
> the file system, as it will allow us to use all the good unix tools.
>=20
> We are using git to manage the source code. And now we are exploring =
git
> to see if it can do the job of transactions, so that each transaction=
 in
> the system will be a git commit.
>=20
> One problem we have found is that we can not commit empty directories=
 (what
> we need to do). Any idea how to solve or work-around this constraint?
>=20

$ touch empty/dir/.placeholder


> Any suggestions and input on this exotic use case for git will be ver=
y
> welcomed.
>=20

Sounds cool. I'll have to give it a whirl when you've got something to =
show.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
