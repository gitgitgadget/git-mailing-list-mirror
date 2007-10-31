From: David Kastrup <dak@gnu.org>
Subject: Re: Newbie: report of first experience with git-rebase.
Date: Wed, 31 Oct 2007 23:49:11 +0100
Message-ID: <85d4uux5lk.fsf@lola.goethe.zz>
References: <87d4uv3wh1.fsf@osv.gnss.ru>
	<20071031195702.GB24332@atjola.homenet> <874pg73u6h.fsf@osv.gnss.ru>
	<Pine.LNX.4.64.0710312111170.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergei Organov <osv@javad.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 31 23:49:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InMMx-0001sg-2g
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 23:49:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761992AbXJaWrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 18:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761963AbXJaWru
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 18:47:50 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:56807 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761477AbXJaWrt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 18:47:49 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1InMLk-000090-4U; Wed, 31 Oct 2007 18:47:48 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 7C8911C464E3; Wed, 31 Oct 2007 23:49:11 +0100 (CET)
In-Reply-To: <Pine.LNX.4.64.0710312111170.4362@racer.site> (Johannes
	Schindelin's message of "Wed, 31 Oct 2007 21:12:06 +0000 (GMT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62895>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 31 Oct 2007, Sergei Organov wrote:
>
>> Yes, and that's the problem. Why 'git --continue' didn't just skip this 
>> patch that *already became no-op* after conflict resolution and forced 
>> me to explicitly use 'git --skip' instead?
>
> Isn't that obvious?  To prevent you from accidentally losing a commit.

The commit would not change anything, so what is there to lose?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
