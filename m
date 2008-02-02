From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix "git checkout -b foo ':/substring'"
Date: Sat, 02 Feb 2008 01:01:27 -0800
Message-ID: <7vprvf3f6g.fsf@gitster.siamese.dyndns.org>
References: <7v1w7w6oq7.fsf@gitster.siamese.dyndns.org>
	<alpine.LNX.1.00.0802020331210.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Feb 02 10:02:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLEGV-0004S9-Lx
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 10:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765609AbYBBJBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 04:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765578AbYBBJBj
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 04:01:39 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37652 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765422AbYBBJBi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 04:01:38 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D61A4BBB;
	Sat,  2 Feb 2008 04:01:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A4E6A4BBA;
	Sat,  2 Feb 2008 04:01:34 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0802020331210.13593@iabervon.org> (Daniel
	Barkalow's message of "Sat, 2 Feb 2008 03:32:32 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72233>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Could we have a test for this? I'm not exactly sure how to use it, and I 
> want to make sure my C version works.

$ git checkout -b newone ':/Initial revision of "git"'
$ git log
commit e83c5163316f89bfbde7d9ab23ca2e25604af290
Author: Linus Torvalds <torvalds@ppc970.osdl.org>
Date:   Thu Apr 7 15:13:13 2005 -0700

    Initial revision of "git", the information manager from hell

;-)
