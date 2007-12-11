From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [PATCH] Better errors when trying to merge a submodule
Date: Tue, 11 Dec 2007 19:11:10 +0100
Message-ID: <20071211181110.GA16491@pvv.org>
References: <20071210124435.GA4788@pvv.org> <7vsl2al5ia.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 19:11:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J29Zx-0004UI-OD
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 19:11:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbXLKSLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 13:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752061AbXLKSLQ
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 13:11:16 -0500
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:38580 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbXLKSLP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 13:11:15 -0500
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.60)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1J29ZW-0005F1-N5; Tue, 11 Dec 2007 19:11:10 +0100
Content-Disposition: inline
In-Reply-To: <7vsl2al5ia.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67897>

On Mon, Dec 10, 2007 at 11:22:05AM -0800, Junio C Hamano wrote:
> Finn Arne Gangstad <finnag@pvv.org> writes:
> 
> > Instead of dying with weird errors when trying to merge submodules from a
> > supermodule, emit errors that show what the problem is.
> 
> Thanks.
> 
> Your change to merge-one-file.sh is Ok, although I'd reword the message
> a bit, and fold it as a new case arm to the existing case statement
> immediately above.
> [...]
> merge-recursive did not support merging trees that have conflicting
> changes in submodules they contain, and died.  Support it exactly the
> same way as how it handles conflicting symbolic link changes --- mark it
> as a conflict, take the tentative result from the current side, and
> letting the caller resolve the conflict, without dying in merge_file()
> function.
> [...]

Your patch is obviously much nicer than the one I sent in, so please
put it in if/when convenient! 

On another note, has there been any though to get merge to support
sub-module merging properly? It seems like it should be possible (and
it would make submodules a lot more useful)

- Finn Arne
