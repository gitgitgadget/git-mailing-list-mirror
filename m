From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/18] Don't expect verify_pack() callers to set pack_size
Date: Sun, 24 May 2009 13:43:39 -0700
Message-ID: <7vzld2teo4.fsf@alter.siamese.dyndns.org>
References: <20090524221947.c83d6aba.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 24 22:43:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8KXn-0002L3-Tm
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 22:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753595AbZEXUnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 16:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753537AbZEXUnj
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 16:43:39 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:48009 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753566AbZEXUni (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 16:43:38 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090524204339.YOWV20430.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sun, 24 May 2009 16:43:39 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id vYjf1b00J4aMwMQ04YjfGE; Sun, 24 May 2009 16:43:39 -0400
X-Authority-Analysis: v=1.0 c=1 a=Rvgg-sL59QcA:10 a=TIGVpO8f_SwA:10
 a=pGLkceISAAAA:8 a=z23upLkTAAAA:8 a=8rBeSoO9zPSfbr8h2QoA:9
 a=l0r3O-pze__xuKg_7NKHF4UCFDIA:4 a=MSl-tDqOz04A:10 a=Ak6yjH5nytEA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119854>

Tay Ray Chuan <rctay89@gmail.com> writes:

> Since use_pack() will end up populating pack_size if it is not already set,
> we can just adapt the code in verify_packfile() such that it doesn't require
> pack_size to be set beforehand.
>
> This allows callers not to have to set pack_size themselves, and we can thus
> revert changes from 1c23d794 (Don't die in git-http-fetch when fetching packs).
>
> Signed-off-by: Mike Hommey <mh@glandium.org>
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>

When you forward somebody else's patch, please be careful not to lose the
attribution, by having

	From: Mike Hommey <mh@glandium.org>
        Date: <<<the original author date from Mike>>>

and an empty line before you start the commit log message.
