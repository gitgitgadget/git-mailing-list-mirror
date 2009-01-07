From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] diff --no-index: test for pager after option parsing
Date: Tue, 06 Jan 2009 16:09:18 -0800
Message-ID: <7vfxjwf041.fsf@gitster.siamese.dyndns.org>
References: <1231286163-9422-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jan 07 01:10:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKM0a-0000eB-RG
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 01:10:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756620AbZAGAJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 19:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755949AbZAGAJZ
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 19:09:25 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48288 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756514AbZAGAJY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 19:09:24 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8D3098E7C2;
	Tue,  6 Jan 2009 19:09:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DB1958E7C0; Tue,
  6 Jan 2009 19:09:20 -0500 (EST)
In-Reply-To: <1231286163-9422-1-git-send-email-trast@student.ethz.ch> (Thomas
 Rast's message of "Wed, 7 Jan 2009 00:56:03 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 704D9D3A-DC4F-11DD-8B49-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104741>

Thomas Rast <trast@student.ethz.ch> writes:

> I noticed this while working on the earlier patch for diff --no-index.
> It seems like the right thing to do (and passes tests), but I don't
> have a clue about git's normal setup sequences, so I'm flagging it
> RFC.

I think the patch itself makes sense from the logic flow point of view.

But I wonder if it still makes a difference in real life.idn't we stop
reporting the exit status from the pager some time ago?
