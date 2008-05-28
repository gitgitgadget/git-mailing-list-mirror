From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Completion: Hint whether amend is the right thing to do.
Date: Wed, 28 May 2008 16:39:27 -0700
Message-ID: <7vlk1urob4.fsf@gitster.siamese.dyndns.org>
References: <200805281608.02000.robin.rosenberg.lists@dewire.com>
 <7v63sywhkr.fsf@gitster.siamese.dyndns.org>
 <200805290133.48490.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu May 29 01:40:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1VFx-0004Pp-FC
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 01:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035AbYE1Xjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 19:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753314AbYE1Xjl
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 19:39:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46708 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbYE1Xjk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 19:39:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C1B9F31A1;
	Wed, 28 May 2008 19:39:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 1F61A319E; Wed, 28 May 2008 19:39:34 -0400 (EDT)
In-Reply-To: <200805290133.48490.robin.rosenberg.lists@dewire.com> (Robin
 Rosenberg's message of "Thu, 29 May 2008 01:33:48 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 565EDB72-2D0F-11DD-A5D9-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83149>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> onsdagen den 28 maj 2008 17.53.40 skrev Junio C Hamano:
>> Does this mean that it would help reduce mistakes if "git commit --amend"
>> noticed the presense of .dotest-merge but absense of .dotest-merge/amend
>> and refused to operate, I have to wonder?
>
> Well I found myself making these mistakes. That would probably be better. 
> Shouldn't one block commit without amend too then?

If you mean to forbid "git commit" during rebase (perhaps interrupted by
s/pick/edit/), I do not think that would fly -- it is the advertised way
to split a commit into two, if I am not mistaken.
