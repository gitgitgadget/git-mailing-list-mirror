From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: [RFC/PATCH] git-prune: never lose objects reachable from our refs.
Date: Fri, 9 Dec 2005 20:39:22 +0100
Message-ID: <20051209193922.GA31228@ebar091.ebar.dtu.dk>
References: <1134084485547-git-send-email-mailing-lists.git@rawuncut.elitemail.org> <1134084485869-git-send-email-mailing-lists.git@rawuncut.elitemail.org> <7v4q5jb149.fsf@assigned-by-dhcp.cox.net> <7vzmnb9m7w.fsf@assigned-by-dhcp.cox.net> <7voe3r9krf.fsf@assigned-by-dhcp.cox.net> <7vmzja91gp.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Dec 09 21:03:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkoQx-0000R3-1J
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 21:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbVLIUB2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Dec 2005 15:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbVLIUB2
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Dec 2005 15:01:28 -0500
Received: from ebar091.ebar.dtu.dk ([192.38.93.106]:1238 "HELO
	ebar091.ebar.dtu.dk") by vger.kernel.org with SMTP id S932395AbVLIUB1
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 9 Dec 2005 15:01:27 -0500
Received: (qmail 31461 invoked by uid 5842); 9 Dec 2005 19:39:22 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vmzja91gp.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13433>

On Thu, Dec 08, 2005 at 11:25:10PM -0800, Junio C Hamano wrote:
> Explicit <head> arguments to git-prune replaces, instead of
> extends, the list of heads used for reachability analysis by
> fsck-objects.  By giving a subset of heads by mistake, objects
> reachable only from other heads can be removed, resulting in a
> corrupted repository.
> 
> This commit stops replacing the list of heads, and makes the
> command line arguments to add to them instead for safety.

Shouldn't the first sentence be "Explicit <head> arguments to git-prune
extends, instead of replaces,...", that is, interchange the words 
extends and replaces?  Did I miss something?

Peter
