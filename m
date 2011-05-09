From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Approxidate with YYYY.MM
Date: Mon, 9 May 2011 15:02:33 -0400
Message-ID: <CAE5FB52-0F90-4F21-828F-7E40ED596B33@gernhardtsoftware.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 09 21:02:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJVj8-00088e-Uz
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 21:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850Ab1EITCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 15:02:38 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:59231 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551Ab1EITCh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2011 15:02:37 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 56F781FFC0F0; Mon,  9 May 2011 19:02:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from hermes-bcg.wireless.rit.edu (unknown [129.21.62.237])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 6F10C1FFC0F0
	for <git@vger.kernel.org>; Mon,  9 May 2011 19:02:28 +0000 (UTC)
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173250>

(This is in response to a discussion on #parrot.)

Rakudo (https://github.com/rakudo/rakudo/) uses tags of the form YYYY.MM for their monthly releases.  When we were attempting to find the cause of a slowdown, somewhat was trying to find what commits occurred after the 2011.01 release with "git log --after=2011.01".  His mistake was pointed out but this led to the confusion of why this was parsed as "May 1 2011" instead of "Jan 1 2011".  Shouldn't date.c:match_multi_number() parse something with only two numbers as a beginning of month instead of allowing it to pass through to the generic parsing?

I'm currently nearing finals in school, so lack the time for an RFC patch at the moment.

~~ Brian