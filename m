From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] contrib/hooks: add an example pre-auto-gc hook
Date: Wed, 02 Apr 2008 13:34:27 -0700
Message-ID: <7vfxu4808c.fsf@gitster.siamese.dyndns.org>
References: <cover.1207049697.git.vmiklos@frugalware.org>
 <7vhceldv12.fsf@gitster.siamese.dyndns.org>
 <20080402011447.GO3264@genesis.frugalware.org>
 <7vwsngaoqg.fsf@gitster.siamese.dyndns.org>
 <20080402190240.GV3264@genesis.frugalware.org>
 <7vtzik848t.fsf@gitster.siamese.dyndns.org>
 <cover.1207164676.git.vmiklos@frugalware.org>
 <96017502f7bca67a14f9a09d19c8ea42bde78949.1207167342.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bj?rn Steinbrink <B.Steinbrink@gmx.de>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Apr 02 22:36:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jh9gZ-0007Ku-Qj
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 22:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762923AbYDBUe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 16:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762851AbYDBUe6
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 16:34:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38238 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763432AbYDBUe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 16:34:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D5BB2477D;
	Wed,  2 Apr 2008 16:34:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 1BEB5477C; Wed,  2 Apr 2008 16:34:48 -0400 (EDT)
In-Reply-To: <96017502f7bca67a14f9a09d19c8ea42bde78949.1207167342.git.vmiklos@frugalware.org> (Miklos Vajna's message of "Wed, 2 Apr 2008 22:22:21 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78714>

Miklos Vajna <vmiklos@frugalware.org> writes:

> Hm, I must be crazy when I wrote this. It has three exit codes:
>
> 0 if on AC power
> 1 if not on AC power
> 255 if can't tell
>
> So IMHO the right think to do is to check if the return value is != 1,
> and if that's true, then do an exit 0.

If it is "can't tell", then it is "can't tell".  Don't you want to err on
the safe side?
