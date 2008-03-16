From: Junio C Hamano <gitster@pobox.com>
Subject: Re: integrity of a repository
Date: Sun, 16 Mar 2008 00:01:38 -0700
Message-ID: <7v8x0jkv8t.fsf@gitster.siamese.dyndns.org>
References: <20080315132645.GC17579@ins.uni-bonn.de>
 <7v4pb7migk.fsf@gitster.siamese.dyndns.org>
 <20080316063215.GA6067@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 16 08:02:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jamt5-0002tP-UT
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 08:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbYCPHBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 03:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbYCPHBw
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 03:01:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33675 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbYCPHBv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 03:01:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E7FF61C60;
	Sun, 16 Mar 2008 03:01:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D26141BFF; Sun, 16 Mar 2008 03:01:46 -0400 (EDT)
In-Reply-To: <20080316063215.GA6067@ins.uni-bonn.de> (Ralf Wildenhues's
 message of "Sun, 16 Mar 2008 07:32:15 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77357>

Ralf Wildenhues <Ralf.Wildenhues@gmx.de> writes:

> OK.  Now, is there a way to quickly ensure that a repository is in a
> pruned state, short of running 'git gc --prune'?

"git fsck --full"?
