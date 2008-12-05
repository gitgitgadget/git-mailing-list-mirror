From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Make some of fwrite/fclose/write/close failures
 visible
Date: Thu, 04 Dec 2008 18:04:51 -0800
Message-ID: <7v63lz2x8c.fsf@gitster.siamese.dyndns.org>
References: <20081205003546.GA7294@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 03:06:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8Q5Q-0006YR-H7
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 03:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754081AbYLECFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 21:05:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754069AbYLECFD
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 21:05:03 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51940 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754061AbYLECFC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 21:05:02 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A73AA845C0;
	Thu,  4 Dec 2008 21:05:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EAE76845BF; Thu,
  4 Dec 2008 21:04:57 -0500 (EST)
In-Reply-To: <20081205003546.GA7294@blimp.localdomain> (Alex Riesen's message
 of "Fri, 5 Dec 2008 01:35:48 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1F829844-C271-11DD-B122-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102387>

All of them obviously look correct.  Will apply to the tip of master.

Thanks.
