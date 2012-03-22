From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Strange effect merging empty file
Date: Thu, 22 Mar 2012 05:17:13 -0700
Message-ID: <86iphwomnq.fsf@red.stonehenge.com>
References: <4F69AD3C.4070203@ericsson.com> <4F69B375.5050205@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Nyren <ralf.nyren@ericsson.com>, git@vger.kernel.org
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Thu Mar 22 13:17:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAgxa-0000hL-3X
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 13:17:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788Ab2CVMRh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Mar 2012 08:17:37 -0400
Received: from lax-gw06.mailroute.net ([199.89.0.106]:35113 "EHLO
	mail.mroute.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932152Ab2CVMRg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Mar 2012 08:17:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by lax-gw06.mroute.net (Postfix) with ESMTP id 61ACECC1B;
	Thu, 22 Mar 2012 12:17:19 +0000 (GMT)
X-Virus-Scanned: by MailRoute
Received: from red.stonehenge.com (red.stonehenge.com [208.79.95.2])
	by lax-gw06.mroute.net (Postfix) with ESMTP id 4BEC4CC25;
	Thu, 22 Mar 2012 12:17:13 +0000 (GMT)
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id 2AC761F61; Thu, 22 Mar 2012 05:17:13 -0700 (PDT)
x-mayan-date: Long count = 12.19.19.4.6; tzolkin = 3 Cimi; haab = 14 Cumku
In-Reply-To: <4F69B375.5050205@in.waw.pl> ("Zbigniew =?utf-8?Q?J=C4=99drze?=
 =?utf-8?Q?jewski-Szmek=22's?=
	message of "Wed, 21 Mar 2012 11:54:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193647>

>>>>> "Zbigniew" =3D=3D Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.wa=
w.pl> writes:

Zbigniew> touch .gitignore

If you're doing this to make sure git makes an empty directory, always
put the directory name in there as a comment... that makes it (a) not a=
n
empty file (so merge doesn't get confused) and (b) unique, so when you
change it, merge won't try to change other similar empty files.

--=20
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 =
0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.posterous.com/ for Smalltalk discussion
