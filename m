From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-fetch: more terse fetch output
Date: Fri, 02 Nov 2007 22:36:04 -0700
Message-ID: <7vtzo3yjp7.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.0.9999.0711030101340.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jeff King <peff@peff.net>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Nov 03 06:36:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoBgI-000196-OA
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 06:36:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755553AbXKCFgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 01:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755203AbXKCFgM
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 01:36:12 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:36040 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104AbXKCFgL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 01:36:11 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id AA4BA2EF;
	Sat,  3 Nov 2007 01:36:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 22BE48F9FE;
	Sat,  3 Nov 2007 01:36:28 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.9999.0711030101340.21255@xanadu.home> (Nicolas
	Pitre's message of "Sat, 03 Nov 2007 01:32:48 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63206>

Nicolas Pitre <nico@cam.org> writes:

> This makes the fetch output much more terse and prettier on a 80 column 
> display, based on a consensus reached on the mailing list.  Here's an 
> example output:
>
> Receiving objects: 100% (5439/5439), 1.60 MiB | 636 KiB/s, done.
> Resolving deltas: 100% (4604/4604), done.
> From git://git.kernel.org/pub/scm/git/git
>  ! [rejected]        html -> origin/html  (non fast forward)
>    136e631..f45e867  maint -> origin/maint  (fast forward)
>    9850e2e..44dd7e0  man -> origin/man  (fast forward)
>    3e4bb08..e3d6d56  master -> origin/master  (fast forward)
>    fa3665c..536f64a  next -> origin/next  (fast forward)
>  + 4f6d9d6...768326f pu -> origin/pu  (forced update)
>  * [new branch]      todo -> origin/todo

Yay!
