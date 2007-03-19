From: "Christian MICHON" <christian.michon@gmail.com>
Subject: how to do these 2 one-liners ?
Date: Mon, 19 Mar 2007 23:25:41 +0100
Message-ID: <46d6db660703191525w613b02e1nae0f30efaca3b269@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 23:26:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTQIk-0007py-EF
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 23:26:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042AbXCSWZp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 18:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbXCSWZp
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 18:25:45 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:58593 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964944AbXCSWZm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 18:25:42 -0400
Received: by wr-out-0506.google.com with SMTP id 41so1706246wry
        for <git@vger.kernel.org>; Mon, 19 Mar 2007 15:25:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aTsne/gWT/xhsp+eFaNQLRJ2d9AND9dxcwOely9z878u0MwDRHhMMag/1nLa1HU8IjQIYvahSR0PXxUfYsTcqHzEasW6NWw/Qc2OHNeIXOUZOfmDbohaZsqE3xpMEoFGXCfve/brW+bwUsJVlgbmUrBGOlfuS3FAZPY3w99bA8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kWuharl8ovJ/1ZxOefXmFRMjhoj58Udq3vTJH0IBDMlZM1e3+U1VbMiJysVGGofUE7TKxqqKA7MgZzHMNWN2wISM+ekCU+JZZH9rbJYkAUibVtM0uEgqeIwHlKnOr8082W2HLL/SUQJV8oBDnl9a4XPpopVRTMn9Isnx9YfxfTs=
Received: by 10.65.251.2 with SMTP id d2mr8520427qbs.1174343141591;
        Mon, 19 Mar 2007 15:25:41 -0700 (PDT)
Received: by 10.115.16.8 with HTTP; Mon, 19 Mar 2007 15:25:41 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42674>

Hi list,

in order to code a gvim plugin for git (I started something), I now miss
2 one-liners, and I hope experts around this list will find it easy
to answer (for the sake of this plugin)

================================================
1) how do I check the status of a single file ? ( the file is already
added in the index)

I usually use git-status here, but for single files that need update,
there should be a faster way.

================================================
2) how do I find in historical reverse order all the commits a
certain file belongs to since the origin ?

I usually do: git-log <file> | grep ^commit
I would like to avoid piping here...

I may need more than these 2 one-liners, if they're doable.
I'll post something soon :)
Thanks in advance!

-- 
Christian
