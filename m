From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: [PATCH] check_updates(): effective removal of cache entries marked
 CE_REMOVE
Date: Fri, 20 Feb 2009 10:01:35 +0100
Organization: private
Message-ID: <86vdr5iis0.fsf@broadpark.no>
References: <1234995483-933-1-git-send-email-barvik@broadpark.no>
 <7vskm9ftcq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 10:03:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaRHo-0005ex-HS
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 10:03:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753202AbZBTJBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 04:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752665AbZBTJBj
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 04:01:39 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:34317 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891AbZBTJBi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 04:01:38 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KFC001K3X2OD620@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Fri, 20 Feb 2009 10:01:36 +0100 (CET)
Received: from localhost ([84.48.79.78]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KFC000NNX2NFT40@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Fri, 20 Feb 2009 10:01:36 +0100 (CET)
In-reply-to: <7vskm9ftcq.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110822>

Junio C Hamano <gitster@pobox.com> writes:

> I've queued this in 'next' as part of your earlier series, together with
> the remaining patches..

  Thanks!!

> I am also a bit surprised that it would make a noticeable difference in
> real life.

  I guess that 77 milliseconds compared to 15 seconds is not noticable
  for the Linux checkout test, but since this is an algorithmic
  reduction from O(N^2) to O(N), I would guess that for big working
  trees it can be more noticable.

  -- kjetil
