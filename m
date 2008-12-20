From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Applying patches from a patch set
Date: Sat, 20 Dec 2008 12:06:22 -0800
Message-ID: <7vabaqy5kx.fsf@gitster.siamese.dyndns.org>
References: <dac45060812200637m49c71aa5x3c25010fa00f4a63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Mark Ryden" <markryde@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 21:10:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LE89m-0001hc-QV
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 21:10:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086AbYLTUG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 15:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753075AbYLTUG3
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 15:06:29 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43782 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752775AbYLTUG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 15:06:28 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5F2EE8730C;
	Sat, 20 Dec 2008 15:06:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 75B148730A; Sat,
 20 Dec 2008 15:06:24 -0500 (EST)
In-Reply-To: <dac45060812200637m49c71aa5x3c25010fa00f4a63@mail.gmail.com>
 (Mark Ryden's message of "Sat, 20 Dec 2008 16:37:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AF31F09A-CED1-11DD-98F2-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103659>

"Mark Ryden" <markryde@gmail.com> writes:

> Hello,
>   I am subscribed to some linux kernel subsystem mailing list; in this
> list there are sometimes patchsets with more than
> 30-40 patches.
> I am using gmail web interface client.
>
> In order to apply a patch set I copy and paste each patch from the
> patchset into a file, and then apply that patch.
> I assume that there is a better way.
> Recently I encountered a fatal error when doing so (and I am not sure
> what caused it).
>
> So my question is: does anyone know a more elegant way of applying a
> large patchset ?
> Maybe there is better mail client with which this process can be done easily ?

First mistake(?) is you seem to be doing copy&paste from browser.  Don't.
It can easily damage whitespaces.  Find out how your webmail interface
allows you to save selected messages in a mbox and let you download it.

Then

	$ git am that-mbox-file
