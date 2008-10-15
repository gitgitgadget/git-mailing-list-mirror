From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Usability of git stash
Date: Wed, 15 Oct 2008 14:31:05 -0500
Message-ID: <nKimSsYZj6xfGNCQS3i5cRwnWQfbHrtUrwdGB2zGWVfMOcfZMwJDKg@cipher.nrlssc.navy.mil>
References: <87wsg9acfv.fsf@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Wed Oct 15 21:32:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqC6e-0001tt-Lo
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 21:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754586AbYJOTbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 15:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752829AbYJOTbQ
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 15:31:16 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53202 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520AbYJOTbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 15:31:16 -0400
Received: by mail.nrlssc.navy.mil id m9FJV67c027941; Wed, 15 Oct 2008 14:31:06 -0500
In-Reply-To: <87wsg9acfv.fsf@cup.kalibalik.dk>
X-OriginalArrivalTime: 15 Oct 2008 19:31:05.0618 (UTC) FILETIME=[91012F20:01C92EFC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98305>

Anders Melchiorsen wrote:

> When trying to recover from that scenario, I do "git stash apply" as
> recommended by the "git stash" output. Now I still lost my index
> state, all changes are unstaged.

See the documentation, apply has a '--index' option.

-brandon
