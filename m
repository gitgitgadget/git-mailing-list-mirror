From: Junio C Hamano <gitster@pobox.com>
Subject: Re: JGIT: discuss: diff/patch implementation
Date: Mon, 10 Nov 2008 12:50:03 -0800
Message-ID: <7v63mv5mro.fsf@gitster.siamese.dyndns.org>
References: <200811101522.13558.fg@one2team.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Francis Galiegue <fg@one2team.net>
X-From: git-owner@vger.kernel.org Mon Nov 10 21:51:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzdjc-0006wX-NG
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 21:51:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbYKJUu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 15:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbYKJUu3
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 15:50:29 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50938 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbYKJUu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 15:50:28 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 53FAB7BEBC;
	Mon, 10 Nov 2008 15:50:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BFA0E7BEBA; Mon,
 10 Nov 2008 15:50:09 -0500 (EST)
In-Reply-To: <200811101522.13558.fg@one2team.net> (Francis Galiegue's message
 of "Mon, 10 Nov 2008 15:22:13 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 343523D0-AF69-11DD-AC60-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100571>

Francis Galiegue <fg@one2team.net> writes:

> A very nice git feature, without even going as far as merges, is the cherry 
> pick feature.

I thought cherry-picking needs to be done in terms of 3-way merge, not
diff piped to patch, for correctness's sake.
