From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problem with merge when renaming
Date: Tue, 18 Sep 2007 15:28:39 -0700
Message-ID: <7v7imnvca0.fsf@gitster.siamese.dyndns.org>
References: <95b3d0af0709181334y1e21507ey485860e4d45aa26f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "David Euresti" <evelio@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 00:28:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXlYt-0004Nr-30
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 00:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755945AbXIRW2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 18:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755563AbXIRW2o
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 18:28:44 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:37082 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436AbXIRW2n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 18:28:43 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 91A55137A12;
	Tue, 18 Sep 2007 18:29:02 -0400 (EDT)
In-Reply-To: <95b3d0af0709181334y1e21507ey485860e4d45aa26f@mail.gmail.com>
	(David Euresti's message of "Tue, 18 Sep 2007 13:34:53 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58642>

"David Euresti" <evelio@gmail.com> writes:

> I think I found a problem when you move a file into a directory of the
> same name.  Here's what I did.

Two questions.

 (1) git --version?

 (2) if you do "git merge -s resolve" instead of just "git
     merge", do you see a difference?
