From: Wayne Davison <wayne@opencoder.net>
Subject: Re: [PATCH] git-stash: Display help message if git-stash is run
	with wrong sub-commands
Date: Sun, 2 Dec 2007 22:16:17 -0800
Message-ID: <20071203061617.GB1976@blorf.net>
References: <e66701d40712021834h64bf8d0y14f0e222d0f9a617@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>
To: Kevin Leung <kevinlsk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 07:16:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz4bh-0007Vo-Hw
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 07:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbXLCGQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 01:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751999AbXLCGQT
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 01:16:19 -0500
Received: from dsl-74-220-69-132.cruzio.com ([74.220.69.132]:36400 "EHLO
	dot.blorf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751987AbXLCGQS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 01:16:18 -0500
Received: by dot.blorf.net (Postfix, from userid 1000)
	id 5A3076B0A; Sun,  2 Dec 2007 22:16:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <e66701d40712021834h64bf8d0y14f0e222d0f9a617@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66872>

On Mon, Dec 03, 2007 at 10:34:05AM +0800, Kevin Leung wrote:
> +USAGE='[  | save | list | show | apply | clear ]'

It seems strange to me that git stash is using sub-sub-command words
instead of options.  Would it make more sense to be more like git branch
and have a list be indicated by -l, etc.?

..wayne..
