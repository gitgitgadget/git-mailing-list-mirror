From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] bisect: teach "skip" to accept a range using
 "-r|--range" option
Date: Sun, 30 Nov 2008 00:24:25 -0800
Message-ID: <7vej0ttydi.fsf@gitster.siamese.dyndns.org>
References: <20081130071511.e279e8bc.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Nov 30 09:26:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6hd9-0007Px-QX
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 09:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbYK3IY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 03:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbYK3IY7
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 03:24:59 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59341 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbYK3IY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 03:24:58 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 34BB982032;
	Sun, 30 Nov 2008 03:24:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1C91882031; Sun,
 30 Nov 2008 03:24:27 -0500 (EST)
In-Reply-To: <20081130071511.e279e8bc.chriscool@tuxfamily.org> (Christian
 Couder's message of "Sun, 30 Nov 2008 07:15:11 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5F3C4E10-BEB8-11DD-86C3-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101950>

Christian Couder <chriscool@tuxfamily.org> writes:

> 	Junio wrote:
> 	>
> 	> Although I fully realize that the established semantics of A..B in git is
> 	> bottom-exclusive, top-inclusive, and this suggestion breaks the UI
> 	> uniformity by deviating from that convention, I have to wonder if it would
> 	> be more useful if you let the bottom commit (A in your example) also be
> 	> skipped.
>
> 	I agree that it would be perhaps more usefull to skip the bottom commit.

Actually I do not think it is such a big deal to warrant more code and
complexity.  "skip A..B A", if you really wanted to, would work anyway.
