From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: Re: [EGIT PATCH Series] Cleanups and javadocs
Date: Tue, 05 Feb 2008 13:09:26 -0200
Message-ID: <47A87C26.2070307@intelinet.com.br>
References: <1202170534-15788-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Dave Watson <dwatson@mimvista.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 16:08:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMPPd-0001CD-4H
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 16:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbYBEPIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 10:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbYBEPIL
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 10:08:11 -0500
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1748 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751189AbYBEPIK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 10:08:10 -0500
Received: (qmail 76123 invoked by uid 0); 5 Feb 2008 13:11:34 -0200
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.238207 secs); 05 Feb 2008 15:11:34 -0000
Received: from unknown (HELO ?200.152.180.33?) (200.152.180.33)
  by cvxbsd.convex.com.br with SMTP; 5 Feb 2008 15:11:34 -0000
User-Agent: Thunderbird 1.5.0.12 (X11/20071129)
In-Reply-To: <1202170534-15788-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72665>


Robin Rosenberg escreveu:
> Here is a number of small enhancements that reduce the number of warnings
> displayed and raises the standard on comments. We now get javadoc comments
> on all public and protected methods which hopefully will make it slighly
> easier to get on the train for those interested in helping out with Egit/Jgit.
>
> Disabling the else-warning is probably fairly uncontroversial. Disabling some
> warning about boxing/unboxing of integers might be as might be requiring
> javadoc comments.
>
>   
Hi Robin,

[2, 3, 5 and 6] - looks fine to me.

[1] - What about something like "nothing to be done here" and/or 
"implementing interface method"?

[4] - Some typos:
+     * Construct an GitStorage instance corresponding to
+     * Construct a GitTag object with a give name.
+     * with some filtering applied. The filter could reduces the number of
+     * commitgs returned or just mark some versions as interesting.
+     *            true if all revisions are returned and interesting 
revisiosn.
+ * An class for changing a ref and possibly index and workdir too.
+     * Construct a {@link CheckpointJob} for the specified resource maping
+     * Drop the Eclipse project from our assocation of 
projects/repositories

And
+    /**
+     * Maps the commit id of this object and
+     *
+     * @return the {@link Commit} object this {@link IFileRevision} 
refers to
+     */
and what?

[]s,
Roger.
