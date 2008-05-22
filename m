From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: Fix skipped section level
Date: Wed, 21 May 2008 20:52:18 -0700
Message-ID: <7vwslnvvv1.fsf@gitster.siamese.dyndns.org>
References: <1211423323-5024-1-git-send-email-hendeby@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Thu May 22 05:53:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jz1rn-0005d3-OL
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 05:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756132AbYEVDwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 23:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbYEVDwc
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 23:52:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34287 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbYEVDwb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 23:52:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0CAFD66E1;
	Wed, 21 May 2008 23:52:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6E37A66E0; Wed, 21 May 2008 23:52:20 -0400 (EDT)
In-Reply-To: <1211423323-5024-1-git-send-email-hendeby@isy.liu.se> (Gustaf
 Hendeby's message of "Thu, 22 May 2008 04:28:43 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7E774B88-27B2-11DD-9FAC-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82602>

Gustaf Hendeby <hendeby@isy.liu.se> writes:

> With xmlto 0.0.18 it seems to demand that no section levels are
> skipped.  The commit 'implement gitcvs.usecrlfattr' (8a06a632976ead)
> one such skip, which here is removed by increasing the level of the
> offender.
>
> Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
> ---
>
> This seems to only be in next so the patch applies there.

Thanks.  Catching breakages before a series hits 'master' is greatly
appreciated.
