From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: What's cooking in git.git (Aug 2013, #04; Thu, 15)
Date: Sun, 18 Aug 2013 13:46:55 +0200
Message-ID: <5210B42F.7050106@kdbg.org>
References: <7vbo4ypon7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 18 13:47:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB1Ru-0005Ax-EU
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 13:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754974Ab3HRLrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 07:47:06 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:24114 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754867Ab3HRLrE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 07:47:04 -0400
Received: from [10.79.126.148] (178.115.250.148.wireless.dyn.drei.com [178.115.250.148])
	by bsmtp.bon.at (Postfix) with ESMTP id C3960130055;
	Sun, 18 Aug 2013 13:46:59 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <7vbo4ypon7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232475>

Am 16.08.2013 00:36, schrieb Junio C Hamano:
> Due to unfortunate regressions, two topics had to be reverted:
>
>   * An attempted fix to "git stash save", to detect that going back
>     to the state of the HEAD needs to lose killed files, and/or
>     untracked files in a killed directory, to prevent the command
>     from proceeding without "--force".
>
>     This used "ls-files -k" that was unusably slow.
>
>   * An attempted enhancement to allow "@" to be used to name "HEAD".
>
>     This rewrote "@" in a ref where it shouldn't have,
>     e.g. refs/@/foo.

You still need to remove corresponding paragraphs from the release notes.

-- Hannes
