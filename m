From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-commit fatal: Out of memory? mmap failed: Bad file descriptor
Date: Fri, 11 Jan 2008 15:48:04 -0800
Message-ID: <7vve5z2abv.fsf@gitster.siamese.dyndns.org>
References: <4787E981.7010200@nrlssc.navy.mil>
	<4787F1F5.2010905@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, drafnel@gmail.com
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Jan 12 00:48:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDTc8-0002Fu-88
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 00:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757731AbYAKXsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 18:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757148AbYAKXsL
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 18:48:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59943 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754313AbYAKXsL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 18:48:11 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BB90F18C9;
	Fri, 11 Jan 2008 18:48:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EA7518C6;
	Fri, 11 Jan 2008 18:48:06 -0500 (EST)
In-Reply-To: <4787F1F5.2010905@nrlssc.navy.mil> (Brandon Casey's message of
	"Fri, 11 Jan 2008 16:47:17 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70224>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> It's reproduceable for me by amending the commit.

Reliably reproducible?  Can you build with "-O0 -g" and run
"commit --amend" under gdb?
