From: "Luca Siciliano Viglieri" <Luca.Siciliano@BitTwister.com>
Subject: Unneeded branch history
Date: Wed, 10 Dec 2008 12:13:27 +0100 (CET)
Message-ID: <50628.127.0.0.1.1228907607.squirrel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 10 13:15:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LANya-0006Eh-J0
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 13:15:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbYLJMOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 07:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbYLJMOR
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 07:14:17 -0500
Received: from marconi.bittwister.com ([217.10.9.91]:51822 "EHLO
	marconi.bittwister.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbYLJMOR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 07:14:17 -0500
X-Greylist: delayed 3656 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Dec 2008 07:14:16 EST
Received: from marconi.bittwister.com (localhost.localdomain [127.0.0.1])
	by marconi.bittwister.com (8.14.1/8.13.8) with ESMTP id mBABDG1Z031832
	for <git@vger.kernel.org>; Wed, 10 Dec 2008 12:13:16 +0100
Received: (from uucp@localhost)
	by marconi.bittwister.com (8.14.1/8.14.1/Submit) with UUCP id mBABDGHj031828
	for git@vger.kernel.org; Wed, 10 Dec 2008 12:13:16 +0100
Received: from shannon.bittwister.com (localhost.localdomain [127.0.0.1])
	by shannon.bittwister.com (8.12.11.20060308/8.12.8) with ESMTP id mBABDSD3022921
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 10 Dec 2008 12:13:28 +0100
Received: (from apache@localhost)
	by shannon.bittwister.com (8.12.11.20060308/8.12.11/Submit) id mBABDRQV022919;
	Wed, 10 Dec 2008 12:13:27 +0100
X-Authentication-Warning: shannon.bittwister.com: apache set sender to Luca.Siciliano@BitTwister.com using -f
Received: from 127.0.0.1 (proxying for 141.113.101.31)
        (SquirrelMail authenticated user luca)
        by localhost with HTTP;
        Wed, 10 Dec 2008 12:13:27 +0100 (CET)
User-Agent: SquirrelMail/1.4.6-3.rh9.1.legacy
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102682>

Hi,
i have tried to find a solution to my problem, but i couldn't find
anything on the documentation.
I have created from master branch a development branch. I keep the master
branch regularly uptodate from the server and in the development branch i
commit my code. When i merge the two branches i obtain a commit with two
parents and when i push my master branch to the server, all my development
history it is also saved in the server.
Can i avoid saving my develoment history, at least on the server, so that
the master branch has only one parent commits?
Thanks

Luca Siciliano
