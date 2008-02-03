From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/11] Better error handling in compress_all()
Date: Sun, 03 Feb 2008 14:54:27 -0800
Message-ID: <7vlk61r6qk.fsf@gitster.siamese.dyndns.org>
References: <1201952156-6764-1-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-2-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-3-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-4-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-5-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-6-git-send-email-mcostalba@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 23:55:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLnk5-0002DX-DU
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 23:55:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753315AbYBCWyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 17:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753297AbYBCWyi
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 17:54:38 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33310 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbYBCWyi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 17:54:38 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 133FB6806;
	Sun,  3 Feb 2008 17:54:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id ABDE26805;
	Sun,  3 Feb 2008 17:54:34 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72420>

Marco Costalba <mcostalba@gmail.com> writes:

> Also let the caller to xmalloc() the buffer
> int compress_start()

This is meant to be an improvement for [01/11] and I think
should be done from the beginning by squashing into it.

Haven't looked at the decompression side yet.  Help in reviewing
this series from others are appreciated.
