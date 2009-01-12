From: David Bryson <david@statichacks.org>
Subject: checking out by date
Date: Mon, 12 Jan 2009 11:30:39 -0800
Message-ID: <20090112193039.GO25823@eratosthenes.cryptobackpack.org>
Reply-To: David Bryson <david@statichacks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 12 20:32:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMSWA-00051U-Dq
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 20:32:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429AbZALTan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 14:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753615AbZALTam
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 14:30:42 -0500
Received: from cryptobackpack.org ([64.105.32.74]:53127 "EHLO
	mail.cryptobackpack.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472AbZALTam (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 14:30:42 -0500
Received: by mail.cryptobackpack.org (Postfix, from userid 1000)
	id 99AD710D0247; Mon, 12 Jan 2009 11:30:41 -0800 (PST)
X-Spam-Checker-Version: SpamAssassin 3.2.1-gr1 (2007-05-02) on
	ptolemy.cryptobackpack.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.1-gr1
Received: from eratosthenes.statichacks.org (heliosphan.cryptobackpack.org [10.6.6.6])
	by mail.cryptobackpack.org (Postfix) with ESMTP id 2CFAF10D0128
	for <git@vger.kernel.org>; Mon, 12 Jan 2009 11:30:40 -0800 (PST)
Received: by eratosthenes.statichacks.org (Postfix, from userid 1000)
	id E845D18348C; Mon, 12 Jan 2009 11:30:39 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

I have a very large repository that imported into git from CVS with
about 5 years worth of history.

Today I decided to checkout some code from the past:

$ git checkout master@{"Mon Dec 31  2007"}
warning: Log for 'master' only goes back to Tue, 2 Dec 2008 16:57:15
-0800.

Then proceeds to checkout a code snapshot from 2 Dec.  To work around
this I checked out a specific commit id, by looking at the log:

commit 3771ec1d6ccf329da378b7633fdef60474eac4b7
Author: XXXXXXXXXXXXXXX
Date:   Mon Dec 31 23:25:17 2007 +0000

    BugId: none
    correct wrong commit


$ git checkout 3771ec1d6ccf329da378b7633fdef60474eac4b7
...
HEAD is now at 3771ec1... BugId: none correct wrong commit

So what has caused git to be unable to process the date information,
even though the information is clearly in the history ?  Did I miss
something ?

Dave
