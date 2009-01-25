From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Heads up: major rebase -i -p rework coming up
Date: Sun, 25 Jan 2009 12:35:39 -0800
Message-ID: <7vwscjceec.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901242056070.14855@racer>
 <200901242347.23187.trast@student.ethz.ch>
 <alpine.DEB.1.00.0901250303150.14855@racer>
 <alpine.DEB.1.00.0901250324320.14855@racer> <glhqdi$tec$1@ger.gmane.org>
 <alpine.DEB.1.00.0901251509550.14855@racer>
 <bd6139dc0901250707m5e1898cdu530a0d7566ca2da5@mail.gmail.com>
 <alpine.DEB.1.00.0901251622310.14855@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 25 21:37:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRBjH-0001Du-2S
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 21:37:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbZAYUfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 15:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbZAYUfr
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 15:35:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35289 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbZAYUfq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 15:35:46 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 764CF1D472;
	Sun, 25 Jan 2009 15:35:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8CE1D1D470; Sun,
 25 Jan 2009 15:35:41 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BE91D84C-EB1F-11DD-A8FE-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107097>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So maybe I answered my question myself:
>
> 	merge parents $sha1 [$sha1...] original $sha1 $msg

When you are reparenting, how would original commit get in the picture?
You wouldn't want the resulting merge to claim it merged X (which would be
what's in original's commit log) when in fact it now merged Y because the
user reparented it, would you?
