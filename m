From: Bradley Wagner <bradley.wagner@hannonhill.com>
Subject: What is the scenario for a commit with 3 or more parents
Date: Wed, 28 Jul 2010 22:05:31 -0400
Message-ID: <AANLkTikMRa_LrD2fU9Piv3GW2H0r7Jf_9s5iM0wc9t6s@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 29 04:05:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeIV6-0002S0-OO
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 04:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048Ab0G2CFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 22:05:32 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57599 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170Ab0G2CFc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 22:05:32 -0400
Received: by gxk23 with SMTP id 23so62113gxk.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 19:05:31 -0700 (PDT)
Received: by 10.151.124.5 with SMTP id b5mr152946ybn.333.1280369131242; Wed, 
	28 Jul 2010 19:05:31 -0700 (PDT)
Received: by 10.229.236.2 with HTTP; Wed, 28 Jul 2010 19:05:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152148>

I was reading over the Specifying Revisions section in the man entry
gitrevisions. I understand having 2 parent commits with a merge.

I was trying to understand the HEAD^2 style syntax and wondering where
HEAD^3 would be used. From the example diagram, this would be Commit B
but I'm unclear how this would ever happen. Is this some kind of
multi-way merge?

Does git log show the parents in their ordinal order in the "Merge:" line?
