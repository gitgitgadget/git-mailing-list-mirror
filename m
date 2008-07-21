From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Bizarre missing changes (git bug?)
Date: Mon, 21 Jul 2008 22:42:43 +0200
Message-ID: <20080721204243.GA4748@blimp.local>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Harper <timcharper@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 22:43:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL2ET-0004yV-5e
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 22:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185AbYGUUmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 16:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752307AbYGUUmp
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 16:42:45 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:39734 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbYGUUmp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 16:42:45 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20hf4EbVSQ==
Received: from tigra.home (Faa8f.f.strato-dslnet.de [195.4.170.143])
	by post.webmailer.de (mrclete mo24) (RZmta 16.47)
	with ESMTP id v06b24k6LHbJHo ; Mon, 21 Jul 2008 22:42:43 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 51D42277BD;
	Mon, 21 Jul 2008 22:42:43 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 3B6E236D17; Mon, 21 Jul 2008 22:42:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89402>

Tim Harper, Mon, Jul 21, 2008 22:26:06 +0200:
> I ran into a strange issue that has left me scratching my head.
>
> I have a commit in my history, that does indeed show up in my branch,  
> named "sprint"
>
...
>
> Any help or clues VERY much apperciated.  Thanks!
>

Try looking at the history graph in gitk

    $ gitk --all -- app/controllers/events_controller.rb spec/fixtures/factors.yml

It usually shows the history in a very understandable way and
it can help to detect when the histories have diverged.
