From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] git-svn: Add --add-author-from option.
Date: Tue, 15 Apr 2008 21:33:11 -0700
Message-ID: <7vej96v2pk.fsf@gitster.siamese.dyndns.org>
References: <1208307858-31039-1-git-send-email-apenwarr@gmail.com>
 <1208307858-31039-2-git-send-email-apenwarr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@versabanq.com>
To: apenwarr@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 16 08:09:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlzLl-0000xZ-FJ
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 06:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbYDPEda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 00:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbYDPEda
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 00:33:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41918 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbYDPEda (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 00:33:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C3FBC2E06;
	Wed, 16 Apr 2008 00:33:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 1A4EC2E04; Wed, 16 Apr 2008 00:33:23 -0400 (EDT)
In-Reply-To: <1208307858-31039-2-git-send-email-apenwarr@gmail.com>
 (apenwarr@gmail.com's message of "Tue, 15 Apr 2008 21:04:17 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79675>

apenwarr@gmail.com writes:

> From: Avery Pennarun <apenwarr@versabanq.com>
>
> This adds a From: line (based on the commit's author information) when
> sending to svn.  It doesn't add if a From: or Signed-off-by: header already
> exists for that commit.

I admit that I do not use git-svn, but I am confused.  Where are you
adding that "From:"?  You grab a commit log message out of git (which does
not have such "From:", add such a line at the beginning of the commit
message using the authorship information and send the resulting commit log
message to svn?  Why?
