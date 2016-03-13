From: Kevin Daudt <me@ikke.info>
Subject: Re: [RFC/GSoC] Introduction
Date: Sun, 13 Mar 2016 22:19:10 +0100
Message-ID: <20160313211910.GA22052@ikke.info>
References: <56E3BE3E.9070105@gmail.com>
 <1924FEBB-46F2-46EE-B190-5289588D4BED@gmail.com>
 <56E5B27D.7010808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sidhant Sharma <tigerkid001@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 13 22:19:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afDQ0-0005Lp-Bg
	for gcvg-git-2@plane.gmane.org; Sun, 13 Mar 2016 22:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbcCMVTO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Mar 2016 17:19:14 -0400
Received: from ikke.info ([178.21.113.177]:53040 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752828AbcCMVTM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Mar 2016 17:19:12 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
	id A69834400B1; Sun, 13 Mar 2016 22:19:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <56E5B27D.7010808@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288760>

On Mon, Mar 14, 2016 at 12:03:33AM +0530, Sidhant Sharma wrote:
> 
> 
> 
> Other than this, I also tried to expand the list of potentially destructive
> commands and updated the list as follows (additions in brackets):
> 
> * git rebase [ git pull --rebase ]
> * git reset --hard
> * git clean -f
> * git gc --prune=now --aggressive
> * git push -f [ git push <remote> :<branch>, git push <remote> +<branch> ]
> * [ git branch -D ]
> 
> Are these additions appropriate? What other commands should be included?
> 
> 

git checkout [ref] <file> is destructive too if it would overwrite an
uncomitted change.
