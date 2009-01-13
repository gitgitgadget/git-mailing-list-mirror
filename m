From: Alan <alan@clueserver.org>
Subject: How can I restrict git-diff to a specific set of directories?
Date: Tue, 13 Jan 2009 15:49:03 -0800
Message-ID: <1231890543.31432.5.camel@rotwang.fnordora.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 00:50:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMt1l-000449-MM
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 00:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753577AbZAMXtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 18:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752150AbZAMXtI
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 18:49:08 -0500
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:50764 "EHLO
	clueserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751189AbZAMXtH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 18:49:07 -0500
Received: from [127.0.0.1] (blackbox.fnordora.org [127.0.0.1])
	by clueserver.org (Postfix) with ESMTP id B9283F5050C
	for <git@vger.kernel.org>; Tue, 13 Jan 2009 15:49:04 -0800 (PST)
X-Mailer: Evolution 2.24.2 (2.24.2-2.fc10) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105561>

I have a repository that I need to build a set of patches for a single
directory path.  (I just want the diffs on the one driver.)

Is there a clean non-hacky way to do this?

It is not cross repository or anything. I just need to generate a diff
between one commit and another, but only for the contents of a specific
directory.

I am not finding a real straightforward way to do that.  (Unless I am
missing something, which is quite possible.)

Thanks!
