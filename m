From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] index-pack: allocate NUL byte at the buffer end
Date: Sat, 01 Mar 2008 17:06:22 -0800
Message-ID: <7vablix7ch.fsf@gitster.siamese.dyndns.org>
References: <12044064822655-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Sun Mar 02 02:07:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVcfg-000301-KO
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 02:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350AbYCBBGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 20:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbYCBBGk
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 20:06:40 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35630 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbYCBBGk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 20:06:40 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 958DC173E;
	Sat,  1 Mar 2008 20:06:38 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id EE002173D; Sat,  1 Mar 2008 20:06:32 -0500 (EST)
In-Reply-To: <12044064822655-git-send-email-mkoegler@auto.tuwien.ac.at>
 (Martin Koegler's message of "Sat, 1 Mar 2008 22:21:21 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75712>

Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:

> Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> ---
> Other parts of git add a NUL to buffers as safty measure, so why not index-pack/
> unpack-objects too?

Perhaps because nobody other than index-pack itself accesses it as if it
is a NUL terminated buffer?
