From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] start_command(), if .in/.out > 0, closes file
 descriptors, not the callers
Date: Thu, 21 Feb 2008 17:17:42 -0800
Message-ID: <7vpruprdqh.fsf@gitster.siamese.dyndns.org>
References: <7v1w7dhnov.fsf@gitster.siamese.dyndns.org>
 <7vmyq07bqe.fsf@gitster.siamese.dyndns.org>
 <200802171029.17850.johannes.sixt@telecom.at>
 <200802212342.56629.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Fri Feb 22 02:18:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSMYf-0002wk-SV
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 02:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435AbYBVBSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 20:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752332AbYBVBSA
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 20:18:00 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46753 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbYBVBR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 20:17:59 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 938A823F4;
	Thu, 21 Feb 2008 20:17:55 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CC5BC23F2; Thu, 21 Feb 2008 20:17:49 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74686>

Thanks, will queue.
