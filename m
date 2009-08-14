From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git submodule summary: add --files option
Date: Fri, 14 Aug 2009 12:52:22 -0700
Message-ID: <7v8whmjhqh.fsf@alter.siamese.dyndns.org>
References: <4A846A62.7010306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: hjemli@gmail.com
X-From: git-owner@vger.kernel.org Fri Aug 14 21:52:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc2pG-0001Dj-DE
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 21:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757071AbZHNTwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 15:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757072AbZHNTwa
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 15:52:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57311 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757063AbZHNTw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 15:52:29 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 57F6C294CE;
	Fri, 14 Aug 2009 15:52:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F10E1294CB; Fri, 14 Aug 2009
 15:52:23 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 002D3686-890C-11DE-AB43-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125941>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> git submodule summary is providing similar functionality for submodules as
> git diff-index does for a git project (including the meaning of --cached).
> But the analogon to git diff-files is missing, so add a --files option to
> summarize the differences between the index of the super project and the
> last commit checked out in the working tree of the submodule.
>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>

Makes sense to me.  Comments?
