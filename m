From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: What's cooking in git.git (Apr 2010, #04; Sat, 10)
Date: Sun, 11 Apr 2010 22:27:36 +0200
Message-ID: <4BC230B8.4000608@kdbg.org>
References: <7vr5mmr6ce.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 22:27:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O13l0-0001Qx-NB
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 22:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900Ab0DKU1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 16:27:43 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:35036 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752893Ab0DKU1k (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 16:27:40 -0400
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 4697210012;
	Sun, 11 Apr 2010 22:27:35 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <7vr5mmr6ce.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144679>

Am 11.04.2010 05:55, schrieb Junio C Hamano:
> * ld/discovery-limit-to-fs (2010-04-04) 6 commits
>   - write-index: check and warn when worktree crosses a filesystem boundary
>    (merged to 'next' on 2010-04-07 at 11ea09a)
>   + Rename ONE_FILESYSTEM to DISCOVERY_ACROSS_FILESYSTEM
>   + GIT_ONE_FILESYSTEM: flip the default to stop at filesystem boundaries
>   + Add support for GIT_ONE_FILESYSTEM
>   + truncate cwd string before printing error message
>   + config.c: remove static keyword from git_env_bool()
>
> The tip one is a bit iffy; the whole series changes behaviour in a corner
> case, and is not a 1.7.1 material.

I do see the warning on Windows even though I shouldn't because we always 
set st_dev and st_rdev to zero. There's something iffy. Will investigate.

-- Hannes
