From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (resend) 3/3] Check return value of ftruncate call in
 http.c
Date: Mon, 10 Aug 2009 22:13:14 -0700
Message-ID: <7v63cvorv9.fsf@alter.siamese.dyndns.org>
References: <be6fef0d0908100847h7e9b53a2ofdf318e9958be3b2@mail.gmail.com>
 <20090810235548.110c43a6.rctay89@gmail.com>
 <20090810235955.1a659e6c.rctay89@gmail.com>
 <20090811000506.c63eb8f1.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff Lasslett <jeff.lasslett@gmail.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 14:15:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaqGR-0000RC-Ux
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 14:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179AbZHKMGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 08:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753176AbZHKMGa
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 08:06:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43844 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123AbZHKMG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 08:06:28 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0239E6FF4;
	Tue, 11 Aug 2009 01:13:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 506426FF3; Tue, 11 Aug
 2009 01:13:16 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AF4A8FEE-8635-11DE-85DF-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125524>

Thanks; all three patches queued.
