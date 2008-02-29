From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] Make git-fetch follow tags we already have objects
 for sooner
Date: Fri, 29 Feb 2008 00:41:38 -0800
Message-ID: <7v3arcduil.fsf@gitster.siamese.dyndns.org>
References: <20080228084257.GC16870@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 29 09:42:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV0p8-0003Ez-HI
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 09:42:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753988AbYB2Il6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 03:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753935AbYB2Il5
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 03:41:57 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41857 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753922AbYB2Il5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 03:41:57 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D1A6721A3;
	Fri, 29 Feb 2008 03:41:55 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 3242021A2; Fri, 29 Feb 2008 03:41:48 -0500 (EST)
In-Reply-To: <20080228084257.GC16870@spearce.org> (Shawn O. Pearce's message
 of "Thu, 28 Feb 2008 03:42:57 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75515>

This is cute.  Obviously some tests need to be adjusted for this
change, though.
