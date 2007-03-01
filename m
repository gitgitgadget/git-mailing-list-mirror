From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [EGIT PATCH 6/9] Add branch and StGit patch to decorator
Date: Thu, 1 Mar 2007 09:22:17 +0100
Message-ID: <200703010922.18149.robin.rosenberg@dewire.com>
References: <20070228222355.12021.13029.stgit@lathund.dewire.com> <20070228222637.12021.63285.stgit@lathund.dewire.com> <20070301035909.GA8103@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 01 09:20:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMgWo-0005Qk-9Q
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 09:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933001AbXCAIUl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 03:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933014AbXCAIUl
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 03:20:41 -0500
Received: from [83.140.172.130] ([83.140.172.130]:4052 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S933001AbXCAIUk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 03:20:40 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 4FE3C802E29;
	Thu,  1 Mar 2007 09:15:34 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 23525-02; Thu,  1 Mar 2007 09:15:33 +0100 (CET)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id E8C1E802809;
	Thu,  1 Mar 2007 09:15:31 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <20070301035909.GA8103@spearce.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41050>

torsdag 01 mars 2007 04:59 skrev Shawn O. Pearce:
> Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> > +	public String getPatch() throws IOException {
> > +		final File ptr = new File(getDirectory(),"patches/"+getBranch()+"/current");
> > +		final BufferedReader br = new BufferedReader(new FileReader(ptr));
> > +		final String line = br.readLine();
> > +		return line;
> > +	}
> 
> Last time I checked leaking a file descriptor was a bad idea.
It's a hallmark of mine. Sooner or later the GC picks them up :), but you're right.

> I fixed it (in both methods) when I applied the patch.
> 
> Your whole series is now pushed. Thanks for the cleanups.
> 

-- robin
