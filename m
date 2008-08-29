From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git-aware HTTP transport
Date: Thu, 28 Aug 2008 23:50:25 -0700
Message-ID: <7vej488gcu.fsf@gitster.siamese.dyndns.org>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com>
 <20080826145857.GF26523@spearce.org> <48B4303C.3080409@zytor.com>
 <20080826172648.GK26523@spearce.org> <48B485F8.5030109@zytor.com>
 <20080828035018.GA10010@spearce.org>
 <7vhc95iwcs.fsf@gitster.siamese.dyndns.org>
 <20080828145706.GB21072@spearce.org>
 <7vwsi0a2op.fsf@gitster.siamese.dyndns.org> <48B784FD.3080005@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 08:52:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYxq3-0005zi-NN
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 08:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753716AbYH2Gue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 02:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753715AbYH2Gue
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 02:50:34 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60377 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691AbYH2Gud (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 02:50:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 86FD26C569;
	Fri, 29 Aug 2008 02:50:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0EE9E6C568; Fri, 29 Aug 2008 02:50:27 -0400 (EDT)
In-Reply-To: <48B784FD.3080005@zytor.com> (H. Peter Anvin's message of "Thu,
 28 Aug 2008 22:11:25 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C661F65A-7596-11DD-828E-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> We should be able to detect either inconsistency, or lack of forward
> progress, but as long as there is forward progress made there doesn't
> seem to be a strong need to terminate.

Yeah, what I wanted to say was that it would be tricky to detect (any/lack
of) forward progress without having server side state and without trusting
the client.
