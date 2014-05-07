From: David Kastrup <dak@gnu.org>
Subject: Re: Beginner question on "Pull is mostly evil"
Date: Wed, 07 May 2014 18:20:01 +0200
Message-ID: <87iophr26m.fsf@fencepost.gnu.org>
References: <0C723FEB5B4E5642B25B451BA57E2730751C2642@S1P5DAG3C.EXCHPROD.USA.NET>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Jim Garrison <jim.garrison@nwea.org>
X-From: git-owner@vger.kernel.org Wed May 07 18:20:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi4Zz-0005fk-Rh
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 18:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932888AbaEGQUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 12:20:14 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:36971 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755857AbaEGQUL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 12:20:11 -0400
Received: from localhost ([127.0.0.1]:36012 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1Wi4Zm-0003lS-Ej; Wed, 07 May 2014 12:20:10 -0400
Received: by lola (Postfix, from userid 1000)
	id 05505E05E8; Wed,  7 May 2014 18:20:02 +0200 (CEST)
In-Reply-To: <0C723FEB5B4E5642B25B451BA57E2730751C2642@S1P5DAG3C.EXCHPROD.USA.NET>
	(Jim Garrison's message of "Wed, 7 May 2014 15:40:28 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248329>

Jim Garrison <jim.garrison@nwea.org> writes:

> During my initial self-education I came across the maxim "don't pull,
> fetch+merge instead" and have been doing that.  I think I followed
> most of the "pull is (mostly) evil" discussion but one facet still
> puzzles me: the idea that pull will do a merge "in the wrong
> direction" sometimes.
>
> Do I understand correctly that this occurs only in the presence of
> multiple remotes?
> Can someone provide a simple example of a situation where pull would
> do the "wrong" thing?

That's basically unavoidable.  Two opposing directions are actually part
of the same workflow usually handled by "git pull":

"Codeveloper X sends a pull request to Y who maintains the mainline.
Y executes git pull to merge X' sidebranch into the mainline."

"Codeveloper X executes git pull in order to merge the mainline from Y
back into his private sidebranch."

-- 
David Kastrup
