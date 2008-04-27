From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git checkout: add -t alias for --track
Date: Sun, 27 Apr 2008 10:33:15 -0700
Message-ID: <7v8wyzgq3o.fsf@gitster.siamese.dyndns.org>
References: <20080423230448.GL4012@genesis.frugalware.org>
 <7vmynfj0a4.fsf@gitster.siamese.dyndns.org>
 <7v1w4rizlm.fsf@gitster.siamese.dyndns.org>
 <20080427114152.GS4012@genesis.frugalware.org>
 <alpine.DEB.1.00.0804271247030.16320@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Apr 27 19:34:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqAlU-0005RI-43
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 19:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757077AbYD0Rd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 13:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756426AbYD0Rd2
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 13:33:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41895 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755924AbYD0Rd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 13:33:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7103B3DDC;
	Sun, 27 Apr 2008 13:33:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CA7703DDB; Sun, 27 Apr 2008 13:33:22 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80464>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 27 Apr 2008, Miklos Vajna wrote:
>
>> On Sat, Apr 26, 2008 at 11:25:09PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
>> > What I meant to say was that this may be useful to _some_ degree but 
>> > probably _not very much_.
>> 
>> Yes, it's just about my "having short option aliases are good" idea. 
>> Should I improve the commit message by mentioning that this is useful 
>> "in case you don't want to have branch.autosetupmerge set to true for 
>> some reason"?
>
> AFAIR you still need to specify --track if you want to setup tracking 
> information for local branches, and have branch.autosetupmerge different 
> than "always", but as always, I might be mistaken.

Ah, you are right.  The change is fine as-is regardless of the
"autosetupmerge" thing.
