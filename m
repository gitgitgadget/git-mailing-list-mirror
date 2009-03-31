From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] quote: implement "sq_dequote_many" to unwrap many
 args in one string
Date: Mon, 30 Mar 2009 22:09:43 -0700
Message-ID: <7v7i268ei0.fsf@gitster.siamese.dyndns.org>
References: <20090329114444.5579813c.chriscool@tuxfamily.org>
 <7vocvjjyqa.fsf@gitster.siamese.dyndns.org>
 <200903310704.52864.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Mar 31 07:11:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoWFx-0001sL-NB
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 07:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbZCaFJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 01:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbZCaFJz
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 01:09:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60813 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbZCaFJy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 01:09:54 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D3F06A610D;
	Tue, 31 Mar 2009 01:09:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3C321A610C; Tue,
 31 Mar 2009 01:09:44 -0400 (EDT)
In-Reply-To: <200903310704.52864.chriscool@tuxfamily.org> (Christian Couder's
 message of "Tue, 31 Mar 2009 07:04:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 29A2093A-1DB2-11DE-8F20-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115210>

Christian Couder <chriscool@tuxfamily.org> writes:

> But you might want to change the function name in the 
> patch title too.

Thanks, sure I might ;-)
