From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] push, send-pack: support pushing HEAD to real ref name
Date: Sun, 28 Oct 2007 00:28:32 -0700
Message-ID: <7vwst7wvdr.fsf@gitster.siamese.dyndns.org>
References: <119350380778-git-send-email-prohaska@zib.de>
	<11935038081211-git-send-email-prohaska@zib.de>
	<11935038081650-git-send-email-prohaska@zib.de>
	<1193503808519-git-send-email-prohaska@zib.de>
	<11935038083369-git-send-email-prohaska@zib.de>
	<11935038084055-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Oct 28 08:29:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im2a9-0006YK-1t
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 08:29:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbXJ1H2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 03:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbXJ1H2h
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 03:28:37 -0400
Received: from rune.pobox.com ([208.210.124.79]:46201 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797AbXJ1H2g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 03:28:36 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 90166151706;
	Sun, 28 Oct 2007 03:28:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 17319151703;
	Sun, 28 Oct 2007 03:28:55 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62529>

Steffen Prohaska <prohaska@zib.de> writes:

> This teaches "push <remote> HEAD" to resolve HEAD on the local
> side to its real ref name, e.g. refs/heads/master, and then
> use the real ref name on the remote side to search a matching
> remote ref.

This probably is a good idea.

> +	if (real_name) {
> +		free(real_name);
> +	}

Excess and unnecessary brace pair.
