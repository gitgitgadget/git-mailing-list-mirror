From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: notes, was Re: What's cooking in git.git (Mar 2009, #04; Sat, 14)
Date: Tue, 17 Mar 2009 11:31:18 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903171129050.6393@intel-tinevez-2-302>
References: <7vr60z8fkl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 11:33:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjWbj-0001FU-QL
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 11:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760931AbZCQKbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 06:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756166AbZCQKbX
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 06:31:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:54837 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754231AbZCQKbW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 06:31:22 -0400
Received: (qmail invoked by alias); 17 Mar 2009 10:31:19 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp054) with SMTP; 17 Mar 2009 11:31:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18LGnFlgjELcgANPzfhoPP7OMO7SyaYpTS3gT/MxU
	vHoQX1h18UG/zC
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vr60z8fkl.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113453>

Hi,

On Sat, 14 Mar 2009, Junio C Hamano wrote:

> * js/notes (Wed Feb 18 11:17:27 2009 -0800) 14 commits
>  - tests: fix "export var=val"
>  - notes: refuse to edit notes outside refs/notes/
>  - t3301: use test_must_fail instead of !
>  - t3301: fix confusing quoting in test for valid notes ref
>  - notes: use GIT_EDITOR and core.editor over VISUAL/EDITOR
>  - notes: only clean up message file when editing
>  - handle empty notes gracefully
>  - git notes show: test empty notes
>  - git-notes: fix printing of multi-line notes
>  - notes: fix core.notesRef documentation
>  - Add an expensive test for git-notes
>  - Speed up git notes lookup
>  - Add a script to edit/inspect notes
>  - Introduce commit notes
> 
> Rebased and then kicked back to 'pu' to give the author a chance to 
> rearrange if necessary.  Nothing happened yet, but I see Dscho has been 
> busy on msysgit side of the world, so it is understandable.

Actually, I have been busy in the real world, and msysGit was just a 
consequence.

Besides, the 'notes' feature is not as important to me as 'rebase -i -p', 
which I am trying hard to find the time to finish up properly.

The 'notes' changes as I have them in mind will also need some serious 
discussion, as I _think_ we should really have the flexibility of a 
variable fan-out.  To prepare for that discussion, I'll have to do some 
serious thinking, which needs time for this old brain of mine.

So do not hold your breath...

Ciao,
Dscho
