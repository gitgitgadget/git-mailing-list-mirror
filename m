From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] Make "diff --check" output match "git apply"
Date: Thu, 13 Dec 2007 16:12:59 -0800
Message-ID: <7v1w9qyvzo.fsf@gitster.siamese.dyndns.org>
References: <1197552751-53480-1-git-send-email-win@wincent.com>
	<1197552751-53480-2-git-send-email-win@wincent.com>
	<1197552751-53480-3-git-send-email-win@wincent.com>
	<1197552751-53480-4-git-send-email-win@wincent.com>
	<1197552751-53480-5-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 01:13:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2yBS-0008FI-0q
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 01:13:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934316AbXLNANQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 19:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934123AbXLNANP
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 19:13:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36378 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934001AbXLNANO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 19:13:14 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B37F8ABB;
	Thu, 13 Dec 2007 19:13:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id AEBAE8AB9;
	Thu, 13 Dec 2007 19:13:06 -0500 (EST)
In-Reply-To: <1197552751-53480-5-git-send-email-win@wincent.com> (Wincent
	Colaiuta's message of "Thu, 13 Dec 2007 14:32:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68204>

Nice attention to the details.
