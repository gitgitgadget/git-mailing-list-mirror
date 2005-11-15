From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] Add support for short help to Cogito commands
Date: Tue, 15 Nov 2005 23:17:56 +0100
Message-ID: <20051115221756.GX30496@pasky.or.cz>
References: <20051115125516.GD13925@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 23:23:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec97p-00049L-SD
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 23:18:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbVKOWR6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 17:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbVKOWR6
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 17:17:58 -0500
Received: from w241.dkm.cz ([62.24.88.241]:10926 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932155AbVKOWR6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 17:17:58 -0500
Received: (qmail 14773 invoked by uid 2001); 15 Nov 2005 23:17:56 +0100
To: Jonas Fonseca <fonseca@diku.dk>
Content-Disposition: inline
In-Reply-To: <20051115125516.GD13925@diku.dk>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11953>

  Hi,

Dear diary, on Tue, Nov 15, 2005 at 01:55:16PM CET, I got a letter
where Jonas Fonseca <fonseca@diku.dk> said that...
> I hope I am not the only one feeling that -h can sometimes be a little
> too verbose when you want to have a quick overview of a Cogito command.
> I'd like to make -h show only a short summary of the available options
> and keep the longer help text for --help. I have attached a patch that
> does something like this. Example:

Good idea. Perhaps even make this default for --help as well and offer
--long-help. cg-help would still default to the long help, unless -s or
something would be passed to it.

>  - Add a special line with the caption. Since we already 'filters' the
>    help text in the script headers this could go after the '::'.
>    Example:
> 
> 	# ...
> 	#
> 	# -r FROM_ID[..TO_ID]:: Specify revisions to diff
> 	#	Specify the revisions to diff using either '-r rev1
> 	#	...
> 
>    So that it will be easy to remove from the --help output and from the
>    generated manpages.
> 
> The last option is less intrusive, but does make the syntax of the
> script headers less clean. Comments?

I prefer the second option and don't think it's much less clean. I think
it would be actually uglier the other way - strange without separating
empty line, too long with the separating line.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
