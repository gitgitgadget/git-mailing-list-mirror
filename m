From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] Teach git-add--interactive to accept a file path to patch
Date: Wed, 21 Nov 2007 12:40:47 -0800
Message-ID: <7vejejfi28.fsf@gitster.siamese.dyndns.org>
References: <1195648601-21736-1-git-send-email-win@wincent.com>
	<1195648601-21736-2-git-send-email-win@wincent.com>
	<1195648601-21736-3-git-send-email-win@wincent.com>
	<20071121152118.GG24108@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 21 21:41:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuwOM-0005Nw-40
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 21:41:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756429AbXKUUk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 15:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756405AbXKUUk4
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 15:40:56 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:54446 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756292AbXKUUkz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 15:40:55 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 3D9CC2F0;
	Wed, 21 Nov 2007 15:41:16 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id B68A398123;
	Wed, 21 Nov 2007 15:41:11 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65705>

Jeff King <peff@peff.net> writes:

> ...
> On top of that, it would be great to be able to do something like
>
>   git-add -i *.c
>
> and just get prompted for changed files (right now, you only get
> prompted for changed files, but unchanged files seem to print a spurious
> newline).
>
> And at any rate, this would require fixing 3/4 to handle the multiple
> files from git-add.
>
> What do you think?

If we are to add path limited behaviour, I think it should also
grok "git-add -i sub/dir/".  IOW, you would want to have the
same path selection semantics as git-add without the
"interactive" bit.
