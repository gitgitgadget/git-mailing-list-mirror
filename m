From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git describe candidate filtering
Date: Wed, 12 Dec 2007 22:12:03 -0800
Message-ID: <7vodcv3yz0.fsf@gitster.siamese.dyndns.org>
References: <4760C250.5080103@byu.net> <20071213055746.GV14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Blake <ebb9@byu.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Dec 13 07:12:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2hJI-0005Gt-02
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 07:12:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520AbXLMGMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 01:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752431AbXLMGMR
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 01:12:17 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65502 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253AbXLMGMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 01:12:16 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EBA17946;
	Thu, 13 Dec 2007 01:12:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D9B87943;
	Thu, 13 Dec 2007 01:12:04 -0500 (EST)
In-Reply-To: <20071213055746.GV14735@spearce.org> (Shawn O. Pearce's message
	of "Thu, 13 Dec 2007 00:57:46 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68123>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> We only match things that were "added".  So if you don't add a tag
> via add_to_known_names() then git-describe won't return it.
>
> However that's only true for the standard case; for --contains its
> a different story as we are actually passing everything to name-rev.

A good news is that name-rev is supposed to respect the name limiter.
