From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/7] gitweb: Make pickaxe search a feature
Date: Wed, 06 Sep 2006 17:37:00 -0700
Message-ID: <7vlkow5x77.fsf@assigned-by-dhcp.cox.net>
References: <200609061504.40725.jnareb@gmail.com>
	<1157548091229-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 02:37:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL7t2-0007XW-Cv
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 02:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161026AbWIGAgx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 20:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161029AbWIGAgx
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 20:36:53 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:32486 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1161026AbWIGAgw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 20:36:52 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060907003651.TMXR6711.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Sep 2006 20:36:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id KCcs1V00B1kojtg0000000
	Wed, 06 Sep 2006 20:36:52 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <1157548091229-git-send-email-jnareb@gmail.com> (Jakub Narebski's
	message of "Wed, 6 Sep 2006 15:08:05 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26577>

Jakub Narebski <jnareb@gmail.com> writes:

> As pickaxe search (selected using undocumented 'pickaxe:' operator in
> search query) is resource consuming, allow to turn it on/off using
> feature meachanism.
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>

I do not have a problem against making it configurable.

> +	'pickaxe' => {
> +		'sub' => \&feature_pickaxe,
> +		'override' => 0,
> +		'default' => [0]},
>  );

The patch suggests that it is turned off by default right now; I
have not checked it myself, but is that the case?
