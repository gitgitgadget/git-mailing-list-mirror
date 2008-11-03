From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: git-cvsimport BUG: some commits are completely out of phase (but
 cvsps sees them all right)
Date: Mon, 03 Nov 2008 15:52:17 +0100
Message-ID: <490F1021.1090002@alum.mit.edu>
References: <200811022203.41092.fg@one2team.net> <f299b4f30811021421w2ef43792l7514ab3a0506077a@mail.gmail.com> <200811022331.14048.fg@one2team.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: tomi.pakarinen@iki.fi, git@vger.kernel.org
To: Francis Galiegue <fg@one2team.net>
X-From: git-owner@vger.kernel.org Mon Nov 03 15:54:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx0oc-0003DL-JQ
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 15:54:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755766AbYKCOw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 09:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755160AbYKCOw0
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 09:52:26 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:46213 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756017AbYKCOwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 09:52:25 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id mA3EqHo2017780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 3 Nov 2008 15:52:19 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.17) Gecko/20080925 Thunderbird/2.0.0.17 Mnenhy/0.7.5.666
In-Reply-To: <200811022331.14048.fg@one2team.net>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99949>

Francis Galiegue wrote:
> The plan would be to convert all modules in one go, with no one committing in 
> the meantime, so that's not a problem.

Then you should definitely try cvs2svn/cvs2git [1].  cvsps-based
conversion tools all have known and unavoidable problems due to the
limitations of cvsps.

Michael
(the cvs2svn/cvs2git maintainer)

[1] http://cvs2svn.tigris.org/cvs2git.html
