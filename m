From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Create 'git gc' to perform common maintenance operations.
Date: Wed, 27 Dec 2006 10:46:03 -0800
Message-ID: <7vr6ul6utw.fsf@assigned-by-dhcp.cox.net>
References: <20061227071759.GA23057@spearce.org>
	<20061227131113.GB6115@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 27 19:46:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gzdn3-000109-JF
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 19:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609AbWL0SqG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 13:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753731AbWL0SqF
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 13:46:05 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:45222 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753609AbWL0SqE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 13:46:04 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061227184604.VQWB15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 Dec 2006 13:46:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3umH1W00c1kojtg0000000; Wed, 27 Dec 2006 13:46:18 -0500
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20061227131113.GB6115@admingilde.org> (Martin Waitz's message of
	"Wed, 27 Dec 2006 14:11:13 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35474>

Martin Waitz <tali@admingilde.org> writes:

> On Wed, Dec 27, 2006 at 02:17:59AM -0500, Shawn O. Pearce wrote:
>> Junio asked for a 'git gc' utility which users can execute on a
>> regular basis to perform basic repository actions such as:
>> 
>>  * pack-refs --prune
>>  * reflog expire
>>  * repack -a -d
>
> what about doing "git-repack -a -d -l" by default?

I think that is sensible.
