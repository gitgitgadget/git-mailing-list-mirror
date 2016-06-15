From: Junio C Hamano <gitster@pobox.com>
Subject: Re: filter-branch: Remove original/*
Date: Sun, 15 Feb 2009 11:33:31 -0800
Message-ID: <7vvdrblcl0.fsf@gitster.siamese.dyndns.org>
References: <431341160902131845g58d99635ie0735b433802d6be@mail.gmail.com>
 <alpine.DEB.1.00.0902142219010.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Kidd <git@randomhacks.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 15 20:35:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYmle-0005ul-4K
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 20:35:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbZBOTdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 14:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbZBOTdi
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 14:33:38 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46717 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbZBOTdh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 14:33:37 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A24152B331;
	Sun, 15 Feb 2009 14:33:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E97BD2B31E; Sun,
 15 Feb 2009 14:33:32 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8A188CCC-FB97-11DD-B6C8-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110036>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hmm.  Indeed, we ignore reflogs in log_ref_write() when the ref starts 
> with refs/tags/ (implicitly, not explicitely).
>
> Maybe it is time to change that.

Why?  Most tags will be created once and will stay there.  That is how tags
are supposed to behave, isn't it?
