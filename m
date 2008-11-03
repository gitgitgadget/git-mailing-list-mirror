From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: git-cvsimport BUG: some commits are completely out of phase (but
 cvsps sees them all right)
Date: Mon, 03 Nov 2008 20:40:49 +0100
Message-ID: <490F53C1.6080705@alum.mit.edu>
References: <200811022203.41092.fg@one2team.net> <f299b4f30811021421w2ef43792l7514ab3a0506077a@mail.gmail.com> <200811022331.14048.fg@one2team.net> <490F1021.1090002@alum.mit.edu> <490F4B1E.2080707@datacom.ind.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br>
X-From: git-owner@vger.kernel.org Mon Nov 03 20:42:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx5Jf-00032B-Qx
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 20:42:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925AbYKCTlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 14:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbYKCTlF
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 14:41:05 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:51575 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbYKCTlE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 14:41:04 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.129] ([77.21.84.251])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id mA3JenuK010606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 3 Nov 2008 20:40:50 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.17) Gecko/20080925 Thunderbird/2.0.0.17 Mnenhy/0.7.5.666
In-Reply-To: <490F4B1E.2080707@datacom.ind.br>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99985>

Samuel Lucas Vaz de Mello wrote:
> Michael Haggerty wrote:
>> Francis Galiegue wrote:
>>> The plan would be to convert all modules in one go, with no one committing in 
>>> the meantime, so that's not a problem.
>> Then you should definitely try cvs2svn/cvs2git [1].  cvsps-based
>> conversion tools all have known and unavoidable problems due to the
>> limitations of cvsps.
> 
> Does cvs2git plans to support incremental importing?

Nope.  It would be very difficult to get it right, and I've pretty much
run out of hacking time with the birth of my second child.  But I'd be
happy to help any volunteers get started :-)

Michael
