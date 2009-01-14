From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] git-daemon: vhost support
Date: Wed, 14 Jan 2009 03:33:52 -0800
Message-ID: <7vmydu2kbj.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.2.00.0901141147120.16109@fbirervta.pbzchgretzou.qr>
 <alpine.LSU.2.00.0901141148130.16109@fbirervta.pbzchgretzou.qr>
 <alpine.LSU.2.00.0901141148390.16109@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Wed Jan 14 12:35:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN41o-0008P4-4a
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 12:35:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756066AbZANLd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 06:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755839AbZANLd6
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 06:33:58 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38261 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755785AbZANLd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 06:33:57 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CB48F9048B;
	Wed, 14 Jan 2009 06:33:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0D1869048A; Wed,
 14 Jan 2009 06:33:53 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3AC34576-E22F-11DD-99DB-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105621>

Jan Engelhardt <jengelh@medozas.de> writes:

> parent v1.6.1
>
> git-daemon: support vhosts
>
> Since git clients usually send the target hostname in the request
> similar to the "Host:" HTTP header, one can do virtual hosting.

Isn't this what --interpolated-path option (especially H and CH
interpolations) is about?
