From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: RFC: grafts generalised
Date: Wed, 2 Jul 2008 19:42:55 +0200
Message-ID: <20080702174255.GB16235@cuci.nl>
References: <20080702143519.GA8391@cuci.nl> <m3lk0kfdo1.fsf@localhost.localdomain> <g4gb7a$ket$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Wed Jul 02 19:44:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE6ND-00032a-1G
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 19:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbYGBRm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 13:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbYGBRm5
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 13:42:57 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:51636 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbYGBRm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 13:42:56 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 8DCA65465; Wed,  2 Jul 2008 19:42:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <g4gb7a$ket$1@ger.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87168>

Michael J Gruber wrote:
>Maybe the upcoming git-sequencer could be the appropriate place? It 
>tries to achieve just that: edit history by specifying a list of 
>commands. The currently planned set of commands would need to be 

That's the problem.  Like git filter-branch, git sequencer needs you to
parameterise the changes, which, in my case, is hardly possible, since
the changes are randomlike.
Also, having to run the sequencer to dig 20000 commits into the past,
then change something, then come back up and rewrite all following
history and relations (parents/tags/merges) will take a sizeable amount
of time.  I need something that can be changed at will, then viewed with
gitk a second later.

These edits are numerous and spread over many months, so the typical 
history fixup-sessions involve periods where you make 30 random
historicaledits per hour (which need to be viewed and checked every time
immediately after making the change).  And say once every 4 months, you
run it through git filter-branch to cast everything into stone.  A
typical git filter-branch run takes 15 minutes on a repository this
size.
-- 
Sincerely,
           Stephen R. van den Berg.

You are confused; but this is your normal state.
