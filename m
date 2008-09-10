From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] t9400, t9401: use "git cvsserver" without dash
Date: Tue, 09 Sep 2008 21:13:04 -0700
Message-ID: <7vljy0zlin.fsf@gitster.siamese.dyndns.org>
References: <20080910062529.6117@nanako3.lavabit.com>
 <7vljy13sq0.fsf@gitster.siamese.dyndns.org>
 <20080909215635.GA4226@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 10 06:14:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdH64-000891-7F
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 06:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbYIJENU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 00:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbYIJENU
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 00:13:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44661 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbYIJENS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 00:13:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7242A5AFF1;
	Wed, 10 Sep 2008 00:13:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E99755AFF0; Wed, 10 Sep 2008 00:13:12 -0400 (EDT)
In-Reply-To: <20080909215635.GA4226@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 9 Sep 2008 17:56:35 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CB9FFF0C-7EEE-11DD-850C-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95479>

Jeff King <peff@peff.net> writes:

> On Tue, Sep 09, 2008 at 02:38:31PM -0700, Junio C Hamano wrote:
>
>> My eyes are getting dry after looking at these s/git-/git / patches, so
>> please do not get offended if I leave these in my Inbox unread for a few
>> days.
>
> I did the same "look for conversion that should _not_ have occurred"
> check for these patches, and all look sane with two exceptions:
>
>  - the cvsserver stuff that you mentioned
>
>  - patch 4/6 changes the commit log message in a few cases for some "git
>    svn" tests; presumably nothing is caring about the commit id's
>    generated here, but I don't actually have svn installed to run the
>    tests to be sure

Thanks.  Will make sure I run these tests (I do not know offhand which svn
tests I am skipping).
