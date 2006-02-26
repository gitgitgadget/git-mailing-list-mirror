From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 4/4] Read author names and emails from a file
Date: Sun, 26 Feb 2006 12:49:40 +0100
Message-ID: <440195D4.7080905@op5.se>
References: <20060226050335.24860.95155.stgit@backpacker.hemma.treskal.com> <20060226051131.24860.15804.stgit@backpacker.hemma.treskal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 26 12:49:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDKPJ-0003jz-7m
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 12:49:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWBZLtm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 26 Feb 2006 06:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWBZLtm
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 06:49:42 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:58276 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750851AbWBZLtm
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2006 06:49:42 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id D7FD46BCFE; Sun, 26 Feb 2006 12:49:40 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: =?ISO-8859-15?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
In-Reply-To: <20060226051131.24860.15804.stgit@backpacker.hemma.treskal.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16781>

Karl Hasselstr=F6m wrote:
> Read a file with lines on the form
>=20
>   username User's Full Name <email@addres.org>
>=20
> and use "User's Full Name <email@addres.org>" as the GIT author and
> committer for Subversion commits made by "username". If encountering =
a
> commit made by a user not in the list, abort.
>=20

This is a good thing, but wouldn't it be better to use the same format=20
as that of cvsimport's -A flag? Also, I imagine one would like to save=20
those files within the .git directory for incremental importing, also=20
like cvsimport does.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
