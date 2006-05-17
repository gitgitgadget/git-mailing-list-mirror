From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC 3/5] Convert update-ref to use ref_lock API.
Date: Wed, 17 May 2006 03:49:15 -0700
Message-ID: <7vfyj9gc44.fsf@assigned-by-dhcp.cox.net>
References: <20060517095519.GD28529@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 12:49:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgJai-0004cZ-Dj
	for gcvg-git@gmane.org; Wed, 17 May 2006 12:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWEQKtR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 06:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWEQKtR
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 06:49:17 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:7420 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751136AbWEQKtR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 06:49:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060517104916.DDMK15447.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 May 2006 06:49:16 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060517095519.GD28529@spearce.org> (Shawn Pearce's message of
	"Wed, 17 May 2006 05:55:19 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20188>

Shawn Pearce <spearce@spearce.org> writes:

> -'git-update-ref' <ref> <newvalue> [<oldvalue>]
> +'git-update-ref' <ref> <newvalue> [<oldvalue>] [-m <reason>]

Is it just me who feels "cmd [-m <reason>] <ref> <new> [<old>]" would
look more natural?
