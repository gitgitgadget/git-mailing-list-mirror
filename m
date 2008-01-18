From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] git-commit: add a prepare-commit-msg hook
Date: Fri, 18 Jan 2008 20:05:09 +0100
Message-ID: <20080118190509.GA3411@steel.home>
References: <4790BCED.4050207@gnu.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 20:06:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFwXK-00013z-1G
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 20:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757491AbYARTFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 14:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755399AbYARTFN
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 14:05:13 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:58995 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753756AbYARTFL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 14:05:11 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2hcN05LQ==
Received: from tigra.home (Fa934.f.strato-dslnet.de [195.4.169.52])
	by post.webmailer.de (fruni mo44) (RZmta 15.4)
	with ESMTP id j04032k0IGAr4Y ; Fri, 18 Jan 2008 20:05:09 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 8E50C277AE;
	Fri, 18 Jan 2008 20:05:09 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 4541656D22; Fri, 18 Jan 2008 20:05:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4790BCED.4050207@gnu.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71051>

Paolo Bonzini, Fri, Jan 18, 2008 15:51:25 +0100:
> +		if (!edit_message) {
> +			run_hook(index_file, "prepare-commit-msg", git_path(commit_editmsg));
> +		}
>  		launch_editor(git_path(commit_editmsg), NULL, env);

"preedit-new-commit-msg", perhaps. A "prepare-" suggests it is called
every time, even if no editor is specified, which it is not.

And it really does look like a template...
