From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Apr 2010, #05; Wed, 14)
Date: Thu, 15 Apr 2010 09:01:54 +0200
Message-ID: <4BC6B9E2.5080202@viscovery.net>
References: <7vy6gpmwr4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 09:02:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2J5P-0001WW-Sh
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 09:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722Ab0DOHB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 03:01:57 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:25932 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751260Ab0DOHB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 03:01:57 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1O2J5H-0002G4-D2; Thu, 15 Apr 2010 09:01:55 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 239401660F;
	Thu, 15 Apr 2010 09:01:55 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <7vy6gpmwr4.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144954>

Am 4/15/2010 1:37, schrieb Junio C Hamano:
> * ld/discovery-limit-to-fs (2010-04-04) 6 commits
>  - write-index: check and warn when worktree crosses a filesystem boundary
>   (merged to 'next' on 2010-04-07 at 11ea09a)
>  + Rename ONE_FILESYSTEM to DISCOVERY_ACROSS_FILESYSTEM
>  + GIT_ONE_FILESYSTEM: flip the default to stop at filesystem boundaries
>  + Add support for GIT_ONE_FILESYSTEM
>  + truncate cwd string before printing error message
>  + config.c: remove static keyword from git_env_bool()
> 
> The tip one is a bit iffy; the whole series changes behaviour in a corner
> case, and is not a 1.7.1 material.

The problem I reported after your previous announcement (that I always see
the warning on Windows) was a false alarm. Appearently, I still had some
random st_dev values recorded in the index for some old files, like
Documentation/RelNotes-1.5.4.*, and it went away after I rebuilt the index.

-- Hannes
