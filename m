From: Kristian Amlie <kristian.amlie@trolltech.com>
Subject: How to find the first commit belonging to any branch
Date: Tue, 22 Jul 2008 11:08:47 +0200
Message-ID: <4885A39F.5080209@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII";
	format="flowed"
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 22 11:09:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLDsV-00069n-5O
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 11:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795AbYGVJIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 05:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752791AbYGVJIv
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 05:08:51 -0400
Received: from hoat.troll.no ([62.70.27.150]:54948 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752718AbYGVJIv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 05:08:51 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 0BF6C20A6A
	for <git@vger.kernel.org>; Tue, 22 Jul 2008 11:08:46 +0200 (CEST)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id F074020755
	for <git@vger.kernel.org>; Tue, 22 Jul 2008 11:08:45 +0200 (CEST)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id m6M98jXM013651
	for <git@vger.kernel.org>; Tue, 22 Jul 2008 11:08:45 +0200
Received: from [10.3.5.25] (axis.troll.no [10.3.5.25])
    by sx01.troll.no (Scalix SMTP Relay 11.3.0.11339)
    via ESMTP; Tue, 22 Jul 2008 11:08:45 +0200 (CEST)
x-scalix-Hops: 1
User-Agent: Thunderbird 2.0.0.14 (X11/20080519)
X-Enigmail-Version: 0.95.6
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89473>

Hi all!

I have a question about git: I have one commit sha1, and I would like to 
know the nearest commit that appears in *any* other branch. The sha1 
that I have does not belong to any branch.

The obvious thing to do would be to make a for loop and iterate over 
existing branches while calling git merge-base, but I'm wondering if 
there's a more clever method.

Regards
Kristian Amlie
