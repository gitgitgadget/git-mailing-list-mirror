From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Adding a `blame' interface.
Date: Wed, 14 Jun 2006 13:27:21 -0700
Message-ID: <7vr71rcwk6.fsf@assigned-by-dhcp.cox.net>
References: <11500407193506-git-send-email-octo@verplant.org>
	<46a038f90606111502g607be3cfnf83ce81764a5f909@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Florian Forster" <octo@verplant.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 14 22:27:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqbxW-0002LV-1A
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 22:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWFNU1X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 16:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWFNU1X
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 16:27:23 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:10230 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932238AbWFNU1W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jun 2006 16:27:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060614202722.UHDG12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Jun 2006 16:27:22 -0400
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90606111502g607be3cfnf83ce81764a5f909@mail.gmail.com>
	(Martin Langhoff's message of "Mon, 12 Jun 2006 10:02:05 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21859>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> Florian,
>
> Looks good! git-blame/git-annotate are quite expensive to run. Do you
> think it would make sense making it conditional on a git-repo-config
> option (gitweb.blame=1)?
>
> kernel.org is the flagship user for gitweb, so expensive options
> should default to off :-/

Seconded.  Thanks Florian and Martin.
