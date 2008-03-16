From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: Allow "reset" to delete a new branch
 without error
Date: Sun, 16 Mar 2008 14:17:11 -0700
Message-ID: <7vfxuqid2g.fsf@gitster.siamese.dyndns.org>
References: <7AFA021C-062D-4FC2-85EB-1DD6C054BEA4@orakel.ntnu.no>
 <20080316041240.GH8410@spearce.org>
 <283B81B0-4493-41DC-A575-F72910B1EFFA@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
X-From: git-owner@vger.kernel.org Sun Mar 16 22:18:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jb0FA-0007tg-Jc
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 22:18:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbYCPVRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 17:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752580AbYCPVRd
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 17:17:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33829 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550AbYCPVRd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 17:17:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DB98E12F2;
	Sun, 16 Mar 2008 17:17:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id DFEBE12F1; Sun, 16 Mar 2008 17:17:24 -0400 (EDT)
In-Reply-To: <283B81B0-4493-41DC-A575-F72910B1EFFA@orakel.ntnu.no> (Eyvind
 Bernhardsen's message of "Sun, 16 Mar 2008 20:49:09 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77386>

Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no> writes:

> On 16. mars. 2008, at 05.12, Shawn O. Pearce wrote:
>
>> I think this is a slightly better patch, as it avoids creating a
>> lock file around the ref if we aren't going to actually alter it.
>
> Yes, that's a much better patch, and since you pointed out that
> existing branches won't be deleted, here it is again with a better
> commit message.  Thanks!

I'll add Acked-by from Shawn and apply.  Thanks, both.
