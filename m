From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] added -C option to chdir() into another directory first
Date: Thu, 26 Feb 2009 12:35:57 -0800
Message-ID: <7vr61lq6ky.fsf@gitster.siamese.dyndns.org>
References: <1235679099-33994-1-git-send-email-kbrint@rufus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: kevin brintnall <kbrint@rufus.net>
X-From: git-owner@vger.kernel.org Thu Feb 26 21:38:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lcmzg-0005Ka-MB
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 21:38:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754428AbZBZUgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 15:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753808AbZBZUgl
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 15:36:41 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43426 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbZBZUgk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 15:36:40 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DDDC09DEC2;
	Thu, 26 Feb 2009 15:36:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B32829DEC1; Thu,
 26 Feb 2009 15:36:03 -0500 (EST)
In-Reply-To: <1235679099-33994-1-git-send-email-kbrint@rufus.net> (kevin
 brintnall's message of "Thu, 26 Feb 2009 14:11:39 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2A6E534A-0445-11DE-9A3C-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111595>

kevin brintnall <kbrint@rufus.net> writes:

> This allows things like 'git -C /somewhere pull' without specifying both
> --work-tree and --git-dir.

Where should "git -C sub/dir apply this.patch" find the file "this.patch"?

More generally, when "git -C there cmd arg1 arg2 arg3..." is run, how
should the implementation of cmd learn what to prefix arg$N with?
