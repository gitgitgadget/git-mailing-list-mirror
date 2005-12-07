From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] cg-object-id: comment the alternate id shortcut parsing
Date: Wed, 7 Dec 2005 23:05:21 +0100
Message-ID: <20051207220521.GM22159@pasky.or.cz>
References: <20051207213943.GC25890@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 23:05:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ek7Pc-0006Wh-FJ
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 23:05:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbVLGWFH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 17:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbVLGWFG
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 17:05:06 -0500
Received: from w241.dkm.cz ([62.24.88.241]:30345 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751793AbVLGWFF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Dec 2005 17:05:05 -0500
Received: (qmail 22315 invoked by uid 2001); 7 Dec 2005 23:05:21 +0100
To: Jonas Fonseca <fonseca@diku.dk>
Content-Disposition: inline
In-Reply-To: <20051207213943.GC25890@diku.dk>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13348>

Dear diary, on Wed, Dec 07, 2005 at 10:39:43PM CET, I got a letter
where Jonas Fonseca <fonseca@diku.dk> said that...
> -	# Short id's must be lower case and at least 4 digits.
> +	# Short id's must be lower case and at least 4 digits. git-rev-parse(1)
> +	# allows only down to 5 digits and we want to show the list of matched
> +	# ids.

Huh. The code in sha1_name.c speaks differently and it works as well:

	$ git-rev-parse b1fc
	b1fcca45069d4f6b00a9ac7136be4268d09fd6b9

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
