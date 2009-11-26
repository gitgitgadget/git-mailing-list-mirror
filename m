From: Kurt Harriman <harriman@acm.org>
Subject: [StGit] push/pull stacked patches
Date: Thu, 26 Nov 2009 04:17:38 -0800
Message-ID: <4B0E71E2.3040908@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 26 13:24:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDdP0-0003za-T4
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 13:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760317AbZKZMYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 07:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759699AbZKZMYj
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 07:24:39 -0500
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:39128 "EHLO
	mail1.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758825AbZKZMYi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 07:24:38 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Nov 2009 07:24:38 EST
Received: (qmail 25776 invoked from network); 26 Nov 2009 12:18:05 -0000
Received: from dsl027-182-087.sfo1.dsl.speakeasy.net (HELO [10.0.1.104]) (hweili@[216.27.182.87])
          (envelope-sender <harriman@acm.org>)
          by mail1.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <git@vger.kernel.org>; 26 Nov 2009 12:18:05 -0000
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133788>

Suppose two developers are collaborating on a series of patches.
What is the best way to synchronize their repositories, including
the StGit state?

Even if both repositories are StGit-enabled, the patch metadata
and unapplied patches don't seem to be transferred by push/pull.

Applied patches are transferred as ordinary commits, losing
their patch names and their place in the patch stack.
It seems that a remote branch cannot have a patch stack.

Instead of using push/pull, a patch series can be transferred
using stg export/import, but this is error-prone, requiring
extra steps, and changes the commit timestamp and SHA1.
Stg export/import are good for distributing the final version
of a patch series; but ungitly for back-and-forth collaboration.
Is there a better way?
