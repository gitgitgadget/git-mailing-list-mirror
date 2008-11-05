From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Slow "git rev-list origin/master --not --all" or "git fetch"
 slow when downloading nothing
Date: Wed, 5 Nov 2008 09:37:35 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811050935270.3419@nehalem.linux-foundation.org>
References: <adf1fd3d0811050138j7b8bbed1nd94a999f55e38d61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Wed Nov 05 18:38:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxmLE-000433-Ti
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 18:38:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753062AbYKERhj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Nov 2008 12:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753421AbYKERhj
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 12:37:39 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44792 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753004AbYKERhi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Nov 2008 12:37:38 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA5HbZkj026461
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 5 Nov 2008 09:37:36 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA5HbZLa025835;
	Wed, 5 Nov 2008 09:37:35 -0800
In-Reply-To: <adf1fd3d0811050138j7b8bbed1nd94a999f55e38d61@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.438 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100164>



On Wed, 5 Nov 2008, Santi B=E9jar wrote:
>=20
>   In cold cache "git rev-list origin/master --not --all" is slow
> reading many files:

Hmm. It sounds like you possibly don't have packed refs.=20

Have you done "git gc" on that thing lately? What does "strace" say?

		Linus
