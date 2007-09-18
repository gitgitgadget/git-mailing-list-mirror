From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-fsck/lost-found's speed vs git-prune's
Date: Tue, 18 Sep 2007 02:18:44 -0700
Message-ID: <7v4phswcuj.fsf@gitster.siamese.dyndns.org>
References: <20070918090926.GA8927@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 11:18:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXZEK-0000Zy-0C
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 11:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839AbXIRJSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 05:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756138AbXIRJSt
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 05:18:49 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:51481 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753579AbXIRJSs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 05:18:48 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id A85DA1373ED;
	Tue, 18 Sep 2007 05:19:07 -0400 (EDT)
In-Reply-To: <20070918090926.GA8927@glandium.org> (Mike Hommey's message of
	"Tue, 18 Sep 2007 11:09:26 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58562>

Mike Hommey <mh@glandium.org> writes:

> I was wondering if that was to be expected for git-fsck to be
> significantly slower than git-prune (by several orders of magnitude) ?

fsck validates objects are correct and sane.  prune only looks
at reachability.
