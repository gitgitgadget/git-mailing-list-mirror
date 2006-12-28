From: Robert Fitzsimons <robfitz@273k.net>
Subject: Re: [RFC/PATCH 6/6] gitweb: Make possible to run under mod_perl without ParseHeaders
Date: Thu, 28 Dec 2006 01:03:11 +0000
Message-ID: <20061228010311.GD6558@localhost>
References: <200612272355.31923.jnareb@gmail.com> <200612280106.24331.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 02:03:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzjgB-00080L-H9
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 02:03:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWL1BDQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 20:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWL1BDQ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 20:03:16 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:33787 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964827AbWL1BDP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 20:03:15 -0500
Received: from 213-202-132-133.bas502.dsl.esat.net ([213.202.132.133] helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1GzjfX-0004Cy-Db; Thu, 28 Dec 2006 01:02:51 +0000
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <200612280106.24331.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=-0.012, required 7,
	autolearn=disabled, RCVD_IN_NERDS_IE -2.00, RCVD_IN_SORBS_DUL 1.99)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35496>

> @@ -1854,7 +1976,8 @@ EOF
>  		      $cgi->hidden(-name => "a") . "\n" .
>  		      $cgi->hidden(-name => "h") . "\n" .
>  		      $cgi->popup_menu(-name => 'st', -default => 'commit',
> -				       -values => ['commit', 'author', 'committer', 'pickaxe']) .
> +		                       -values => ['commit', 'author', 'committer',
> +		                       gitweb_check_feature('pickaxe') ? 'pickaxe' : ()]) .
>  		      $cgi->sup($cgi->a({-href => href(action=>"search_help")}, "?")) .
>  		      " search:\n",
>  		      $cgi->textfield(-name => "s", -value => $searchtext) . "\n" .

This should be a separate patch.

Robert
