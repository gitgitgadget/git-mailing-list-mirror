From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git and Scmbug integration
Date: Tue, 13 Nov 2007 17:09:45 -0800
Message-ID: <7vtznppr8m.fsf@gitster.siamese.dyndns.org>
References: <1194980792.4106.6.camel@localhost>
	<ee77f5c20711131500h6ee067ffv3e488ac7bde1d22c@mail.gmail.com>
	<1194998142.4106.24.camel@localhost>
	<ee77f5c20711131602m5b9042fx72689af53e24ddd2@mail.gmail.com>
	<1194999404.4106.40.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Symonds <dsymonds@gmail.com>, jnareb@gmail.com,
	git@vger.kernel.org, scmbug-users@lists.mkgnu.net
To: Kristis Makris <kristis.makris@asu.edu>
X-From: git-owner@vger.kernel.org Wed Nov 14 02:10:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is6lg-0003sZ-Tq
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 02:10:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760538AbXKNBJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 20:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760814AbXKNBJ5
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 20:09:57 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:39499 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760438AbXKNBJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 20:09:56 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id DD0B42F2;
	Tue, 13 Nov 2007 20:10:17 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 4C2C595347;
	Tue, 13 Nov 2007 20:10:12 -0500 (EST)
In-Reply-To: <1194999404.4106.40.camel@localhost> (Kristis Makris's message of
	"Tue, 13 Nov 2007 17:16:44 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64935>

Kristis Makris <kristis.makris@asu.edu> writes:

> I just tried again tagging with both:
>
> $ git tag TAG_NAME
>
> $ git tag -a TAG_NAME
>
> and I don't get the post-commit hook executed.
>
> Perhaps I missed something ?

You didn't.  You did not create any commit.  No post-commit hook
runs.  There is no post-tag hook.

> Can the new commit SHA-1 hash be added as a parameter to the post-commit
> hook please ?

Looking at "git-rev-parse HEAD" in your hook should be enough.
