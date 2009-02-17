From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/8] config: Use parseopt.
Date: Mon, 16 Feb 2009 21:44:42 -0800
Message-ID: <7vab8laa7p.fsf@gitster.siamese.dyndns.org>
References: <1234832094-15541-1-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-2-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 06:46:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZImf-0002FF-2w
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 06:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbZBQFou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 00:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbZBQFou
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 00:44:50 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38613 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbZBQFot (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 00:44:49 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 954462B4D0;
	Tue, 17 Feb 2009 00:44:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C9A0C2B4CF; Tue,
 17 Feb 2009 00:44:44 -0500 (EST)
In-Reply-To: <1234832094-15541-3-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Tue, 17 Feb 2009 02:54:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 16B1673E-FCB6-11DD-8D8B-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110310>

I've queued the entire series on top of fc/config-editor topic and even
merged the result in 'pu' once, but I had to reintegrate 'pu' without the
series.

Before this commit, t/t1300-repo-config.sh passes, but this one breaks
the test.
