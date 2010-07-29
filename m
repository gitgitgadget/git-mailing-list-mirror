From: Richard Bronosky <Richard@Bronosky.com>
Subject: hooks not fired by a merge's auto-commit
Date: Wed, 28 Jul 2010 21:25:36 -0400
Message-ID: <AANLkTindr-y0uAu46FVEqtB5BLw9ZjB0y0ETwmW+8+PV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 29 03:46:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeICd-0006O4-CV
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 03:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734Ab0G2Bq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 21:46:26 -0400
Received: from slice1.bronosky.com ([174.143.204.116]:34591 "EHLO
	slice1.bronosky.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194Ab0G2BqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 21:46:25 -0400
X-Greylist: delayed 1245 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Jul 2010 21:46:25 EDT
Received: from mail-wy0-f174.google.com (mail-wy0-f174.google.com [74.125.82.174])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by slice1.bronosky.com (Postfix) with ESMTP id C231017670
	for <git@vger.kernel.org>; Thu, 29 Jul 2010 01:25:39 +0000 (UTC)
Received: by wyb39 with SMTP id 39so66014wyb.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 18:25:38 -0700 (PDT)
Received: by 10.216.231.230 with SMTP id l80mr11372152weq.53.1280366736951; 
	Wed, 28 Jul 2010 18:25:36 -0700 (PDT)
Received: by 10.216.172.139 with HTTP; Wed, 28 Jul 2010 18:25:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152144>

Using git 1.7.1 it seems that a merge (more specifically the
auto-commit) does not fire any of the following hooks:
pre-commit  prepare-commit-msg commit-msg

Is that by design?
Would it be folly to try to patch that behavior?

I humbly request your input before I go trying to "correct" this behavior.

-- 
.!# RichardBronosky #!.
