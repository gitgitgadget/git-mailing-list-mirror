From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: Support diff.color-words config option
Date: Mon, 19 Jan 2009 22:59:37 -0800
Message-ID: <7v1vuympie.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0901200031350.3586@pacific.mpi-cbg.de>
 <200901192017.54163.bss@iguanasuicide.net>
 <200901192145.21115.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Santi =?utf-8?Q?B?= =?utf-8?Q?=C3=A9jar?= <santi@agolina.net>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Teemu Likonen <tlikonen@iki.fi>
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Tue Jan 20 08:01:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPAbv-0006cn-QM
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 08:01:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392AbZATG7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 01:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752890AbZATG7t
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 01:59:49 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36837 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835AbZATG7s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 01:59:48 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C7D46916EB;
	Tue, 20 Jan 2009 01:59:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 86D5D916E4; Tue,
 20 Jan 2009 01:59:39 -0500 (EST)
In-Reply-To: <200901192145.21115.bss@iguanasuicide.net> (Boyd Stephen Smith,
 Jr.'s message of "Mon, 19 Jan 2009 21:45:20 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EC44E810-E6BF-11DD-B1B6-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106446>

"Boyd Stephen Smith Jr." <bss@iguanasuicide.net> writes:

> When diff is invoked with --color-words (w/o =regex), use the regular
> expression the user has configured as diff.color-words.
>
> diff drivers configured via attributes take precedence over the
> diff.color-words setting.  If the user wants to change them, they have
> their own configuration variables.

This needs an entry in Documentation/config.txt

None of the existing configuration variables defined use hyphens in
multi-word variable names.

Other than that, I think this is a welcome addition to the suite.

Thanks.
