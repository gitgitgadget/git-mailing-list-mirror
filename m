From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] git push --track
Date: Thu, 14 Jan 2010 10:35:14 +0900
Message-ID: <87eilt5uzx.fsf@catnip.gol.com>
References: <op.u6g8jnixg402ra@nb-04>
	<be6fef0d1001131727r128c7727td2b948018d308719@mail.gmail.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rudolf Polzer <divVerent@alientrap.org>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 02:35:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVEcc-000231-DI
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 02:35:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755088Ab0ANBf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 20:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754901Ab0ANBf0
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 20:35:26 -0500
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:46330 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755162Ab0ANBfW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 20:35:22 -0500
Received: from 218.231.177.74.eo.eaccess.ne.jp ([218.231.177.74] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	id 1NVEcF-0002YJ-JO; Thu, 14 Jan 2010 10:35:15 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 928E0DF73; Thu, 14 Jan 2010 10:35:14 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <be6fef0d1001131727r128c7727td2b948018d308719@mail.gmail.com>
	(Tay Ray Chuan's message of "Thu, 14 Jan 2010 09:27:26 +0800")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136920>

Tay Ray Chuan <rctay89@gmail.com> writes:
> before I put up my comments on the patch, I wonder if git-push is the
> best place to add this feature, as git-push usually deals with
> "pushing" data to another repo.
>
> I think git-branch would be a better place to do this.

No.  I think push is absolutely the right place to do it.

I very often create local branches and only later decide that I'd also
like to push them to a remote -- but just as often, or more often, I
never do so.  It would be extremely annoying if I had to make that
decision at branch-time.

-Miles

-- 
Pray, v. To ask that the laws of the universe be annulled in behalf of a
single petitioner confessedly unworthy.
