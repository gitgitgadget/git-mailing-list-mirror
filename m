From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Getting a file revision
Date: Sat, 18 Aug 2007 17:52:20 -0700
Message-ID: <7vir7ccpmj.fsf@gitster.siamese.dyndns.org>
References: <7ac1e90c0708181742w531dab4asc7c90835cc56e8a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Bahadir Balban" <bahadir.balban@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 19 02:52:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMZ2I-0002cc-Ed
	for gcvg-git@gmane.org; Sun, 19 Aug 2007 02:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312AbXHSAw1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Aug 2007 20:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753618AbXHSAw1
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Aug 2007 20:52:27 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:38650 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753002AbXHSAw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2007 20:52:26 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 4CE0C123F9A;
	Sat, 18 Aug 2007 20:52:44 -0400 (EDT)
In-Reply-To: <7ac1e90c0708181742w531dab4asc7c90835cc56e8a1@mail.gmail.com>
	(Bahadir Balban's message of "Sun, 19 Aug 2007 01:42:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56120>

"Bahadir Balban" <bahadir.balban@gmail.com> writes:

> This might sound like a novice question but anyway: I sometimes have a
> need to quickly recover an old revision of a file just to check
> something or copy some code from it.

$ git show -p $commit:$path >$path.old-version
