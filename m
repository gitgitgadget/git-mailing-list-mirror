From: Steffen Prohaska <prohaska@zib.de>
Subject: gitk crashes when quitting gitk while it is is reading commits (was Re: gitk crashing on Windows.)
Date: Mon, 28 Jul 2008 21:18:35 +0200
Message-ID: <E7C7B8BA-6050-40DE-917C-200EAE9CA6E8@zib.de>
References: <g6kmqf$q9p$1@ger.gmane.org> <loom.20080728T162025-946@post.gmane.org>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 21:19:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNYFk-00045Z-7t
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 21:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759206AbYG1TSX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2008 15:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759171AbYG1TSW
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 15:18:22 -0400
Received: from mailer.zib.de ([130.73.108.11]:33914 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757722AbYG1TSV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jul 2008 15:18:21 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6SJIDHs024603;
	Mon, 28 Jul 2008 21:18:18 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db83842.pool.einsundeins.de [77.184.56.66])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6SJICP1002387
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 28 Jul 2008 21:18:13 +0200 (MEST)
In-Reply-To: <loom.20080728T162025-946@post.gmane.org>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90489>


On Jul 28, 2008, at 6:29 PM, Eric Raible wrote:

> Jurko Gospodneti=C4=87 <jurko.gospodnetic <at> docte.hr> writes:
>
>>   When you run gitk from a git repository on Windows it starts up an=
d
>> starts updating its 'Row X/Y' output labels. This lasts for a few
>> seconds but if you terminate the application before this updating is
>> complete you get a Windows message stating:
>>
>>   'Wish Application has encountered a problem and needs to close. We
>> are sorry for the inconvenience.'
>>
>>   and the standard 'Send Error Report'/'Don't Send' buttons.
>>
>>   Hope this helps.
>>
>>   Best regards,
>>     Jurko Gospodneti=C4=87
>
> Though I can't find the relevant commit at the moment
> I believe that this is one already fixed in the latest
> from git://repo.or.cz/git/mingw/4msysgit.git.

I don't think so.  The error Jurko reported might be the same error
that was reported earlier and filed as issue 125:

http://code.google.com/p/msysgit/issues/detail?id=3D125

I don't think the problem is Windows-specific.  At least on Mac I am
seeing similar problems.  When I hit CTRL-q while gitk is still reading
the commits, it crashes with as segfault.

	Steffen
