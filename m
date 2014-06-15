From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: show staged submodules regardless of ignore config
Date: Sun, 15 Jun 2014 14:57:13 +1000
Message-ID: <20140615045713.GD21978@iris.ozlabs.ibm.com>
References: <xmqqtx7xpwz6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 15 06:58:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ww2WG-0002wx-7Q
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jun 2014 06:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbaFOE57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 00:57:59 -0400
Received: from ozlabs.org ([103.22.144.67]:54741 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbaFOE56 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2014 00:57:58 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id C0BE014009C; Sun, 15 Jun 2014 14:57:55 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <xmqqtx7xpwz6.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251663>

On Fri, Jun 06, 2014 at 02:08:29PM -0700, Junio C Hamano wrote:
> From: Jens Lehmann <Jens.Lehmann@web.de>
> Date: Tue, 8 Apr 2014 21:36:08 +0200
> 
> Currently setting submodule.<name>.ignore and/or diff.ignoreSubmodules to
> "all" suppresses all output of submodule changes for gitk. This is really
> confusing, as even when the user chooses to record a new commit for an
> ignored submodule by adding it manually this change won't show up under
> "Local changes checked in to index but not committed".
> 
> Fix that by using the '--ignore-submodules=dirty' option for both callers
> of "git diff-index --cached" when the underlying git version supports that
> option.
> 
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks, applied.

Paul.
