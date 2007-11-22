From: Junio C Hamano <gitster@pobox.com>
Subject: Reordering lines in "git-rebase -i" task sheet
Date: Thu, 22 Nov 2007 01:21:55 -0800
Message-ID: <7vlk8q7hzg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 22 10:26:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv8Kd-0006FI-Ux
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 10:26:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbXKVJWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 04:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbXKVJWF
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 04:22:05 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:37270 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbXKVJWE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 04:22:04 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 8A2D42F0;
	Thu, 22 Nov 2007 04:22:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 2BB09957A4;
	Thu, 22 Nov 2007 04:22:19 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65763>

When you start "git rebase -i" to reorder a few commits, you are
presented with an editor buffer with 9 or so lines of help text
and then lines you are supposed to edit, but most editors start
with your edit cursor at line 1.  IOW, _everybody_ has to move
their cursor down at least 9 lines before doing anything
meaningful (or they can remove 9 lines but that is the same
thing).

Could we please reorder the lines so that list of initial
"pick"s come first and have the help comment lines at the very
end?

That is the reason why git commit leaves the first line empty in
its initial template.  It is to allow the user to immediately
start typing.
