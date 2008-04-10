From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] pretty=format: Add %d to show decoration
Date: Thu, 10 Apr 2008 01:39:32 -0700
Message-ID: <7v1w5exfwb.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0804071439480.430@eeepc-johanness>
 <alpine.DEB.1.00.0804071441040.430@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 10 10:40:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjsKb-0006nf-Hx
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 10:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbYDJIjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 04:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754008AbYDJIjp
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 04:39:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56137 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240AbYDJIjp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 04:39:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CC0D41C5A;
	Thu, 10 Apr 2008 04:39:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2A8391C59; Thu, 10 Apr 2008 04:39:39 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0804071441040.430@eeepc-johanness> (Johannes
 Schindelin's message of "Mon, 7 Apr 2008 14:41:12 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79196>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> With this patch, "git log --decorate --pretty=format:%d", shows the
> name decoration (i.e. whenever a commit matches a ref, that ref's name
> is shown).
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	Maybe %d should expand to " (<name decoration>)" instead of
> 	"<name decoration>"?

Not necessarily.  %d in --pretty="format:%h%d %s" may want to expand to
"(<name>) " instead of " (<name>)".
