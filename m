From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: Re: git-svn with ignore-paths misses/skips some revisions during fetch
Date: Sat, 10 Nov 2012 08:57:59 +0100 (CET)
Message-ID: <be90fa6b-3927-47cb-9306-6dbb7bac2c04@zcs>
References: <D377A9280DB18546A2471214D5CBB0E9054C25E071@exchdb01>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matt McHenry <mmchenry@carnegielearning.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 08:58:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TX5xI-0007Mp-FT
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 08:58:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717Ab2KJH6B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Nov 2012 02:58:01 -0500
Received: from zcs.vnc.biz ([83.144.240.118]:13676 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751635Ab2KJH6B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2012 02:58:01 -0500
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id 23B9A622260;
	Sat, 10 Nov 2012 08:58:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 69ubZ4X+wD51; Sat, 10 Nov 2012 08:57:59 +0100 (CET)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id 9D20D622259;
	Sat, 10 Nov 2012 08:57:59 +0100 (CET)
In-Reply-To: <D377A9280DB18546A2471214D5CBB0E9054C25E071@exchdb01>
X-Originating-IP: [91.43.209.211]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC20 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209261>


>         The problem is that the 'ignore-paths' approach sometimes
>         misses commits during a fetch, and then at some later time
>         will "realize" it and squash those changes onto some other,
>         unrelated commit.  (I've never seen this happen with the
>         per-subdir 'fetch' approach.)  Here are three commits in
>         SVN:

Could it be that certain files spent parts of their historical lifetime
inside the ignored paths ?


cu
--=20
Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards=20

Enrico Weigelt=20
VNC - Virtual Network Consult GmbH=20
Head Of Development=20

Pariser Platz 4a, D-10117 Berlin
Tel.: +49 (30) 3464615-20
=46ax: +49 (30) 3464615-59

enrico.weigelt@vnc.biz; www.vnc.de=20
