From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: git tag -u feature request
Date: Wed, 06 May 2015 09:02:53 +0200
Organization: gmx
Message-ID: <8b6abb32537f04b3a310602d3161d559@www.dscho.org>
References: <9fa7de80732928631304708be9504271@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Hans Ginzel <hans@matfyz.cz>
X-From: git-owner@vger.kernel.org Wed May 06 09:03:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YptME-0006my-Fb
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 09:03:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753791AbbEFHC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 03:02:58 -0400
Received: from mout.gmx.net ([212.227.15.19]:49408 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753755AbbEFHC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 03:02:57 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M243n-1Z5UWr0z3T-00u2QV; Wed, 06 May 2015 09:02:54
 +0200
In-Reply-To: <9fa7de80732928631304708be9504271@artax.karlin.mff.cuni.cz>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:lWVLlrmOOLv3vXzXHGQAxH79oxwZc/r72hYrKf+xPildurO7T1N
 HtHUkZZOSHogcimBYj70bEGHicqrf7t3C3fBHd7haQcKvOBc3Q3xHXP9PXD1ZqIa31L1HR8
 zxnfbJhXZQ2uy0++Rkd22HrvxoYL4QchKcos1qSfFNJ3tDO9f+rVAUblGb7gn7bzDlBu0aW
 czYgAJu7ynDaC6oM2NBOQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268454>

Hi Hans,

On 2015-05-06 08:09, Hans Ginzel wrote:

> please, would it be possible to add -u option to git tag for updating tag
> (with message) to a new commit, e.g. after rebase.
> 
> See
> http://stackoverflow.com/questions/8044583/how-can-i-move-a-tag-on-a-git-branch-to-a-different-commit

As the answer http://stackoverflow.com/questions/8044583/how-can-i-move-a-tag-on-a-git-branch-to-a-different-commit/8044605#8044605 says: there is the `-f` flag.

It is appropriate to call the flag `--force` rather than `--update` because the social contract of tags is that they do not change.

Ciao,
Johannes
