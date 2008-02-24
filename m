From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-filter-branch: add a new commit-filter
 example
Date: Sun, 24 Feb 2008 09:58:41 -0800
Message-ID: <7v7iguxmlq.fsf@gitster.siamese.dyndns.org>
References: <20080223193058.GE31441@genesis.frugalware.org>
 <7vejb3319j.fsf@gitster.siamese.dyndns.org>
 <20080223220433.GG31441@genesis.frugalware.org>
 <alpine.DEB.1.00.0802241151390.6881@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 24 18:59:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTL8e-0002Ei-Sq
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 18:59:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbYBXR67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 12:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbYBXR67
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 12:58:59 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55206 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbYBXR66 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 12:58:58 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 336952D68;
	Sun, 24 Feb 2008 12:58:56 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 727BC2D62; Sun, 24 Feb 2008 12:58:52 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0802241151390.6881@eeepc-johanness> (Johannes
 Schindelin's message of "Sun, 24 Feb 2008 11:53:34 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74947>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 23 Feb 2008, Miklos Vajna wrote:
>
>> +-------------------------------------------------------
>> +git filter-branch --commit-filter '
>> +	sed -e "/^git-svn-id:/d" | git commit-tree "$@"
>> +'
>> +-------------------------------------------------------
>
> And there I thought that was the job of --msg-filter ;-)

Ahhhhhhh, that was the little voice that kept telling me there
is something wrong with the patch...
