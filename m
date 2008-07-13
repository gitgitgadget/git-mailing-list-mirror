From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2 (for GIT-GUI)] git-gui: MERGE_RR lives in .git/
 directly with newer Git versions
Date: Sun, 13 Jul 2008 01:58:33 -0700
Message-ID: <7vvdzatb2e.fsf@gitster.siamese.dyndns.org>
References: <87skufmjg4.fsf@Astalo.kon.iki.fi>
 <alpine.DEB.1.00.0807121553120.8950@racer>
 <alpine.DEB.1.00.0807121556480.8950@racer>
 <20080713011623.GC31050@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kalle Olavi Niemitalo <kon@iki.fi>, git@vger.kernel.org,
	gitster@pobox.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jul 13 10:59:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHxQw-0001dS-1s
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 10:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621AbYGMI6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 04:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752613AbYGMI6q
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 04:58:46 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33317 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573AbYGMI6p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 04:58:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D7B072933C;
	Sun, 13 Jul 2008 04:58:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C458F2933B; Sun, 13 Jul 2008 04:58:37 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E5FD36B6-50B9-11DD-B767-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88293>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> 
>> Now that MERGE_RR was moved out of .git/rr-cache/, we have to delete
>> it somewhere else.  Just in case somebody wants to use a newer git-gui
>> with an older Git, the file .git/rr-cache/MERGE_RR is removed, too (if
>> it exists).
>> 
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Ack, I can pull this into git-gui.git.  But I want to make sure
> Junio is going to take 1/2 into git.git.

Will do.
