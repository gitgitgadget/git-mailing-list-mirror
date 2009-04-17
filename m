From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 1/3] Changed Transport class hierarchy basing on
	underlying transport
Date: Fri, 17 Apr 2009 07:58:46 -0700
Message-ID: <20090417145846.GP23604@spearce.org>
References: <85647ef50904160703y3a416294k54f21b50f6006040@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 17:00:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LupYF-0000mM-49
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 17:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756944AbZDQO6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 10:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756454AbZDQO6r
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 10:58:47 -0400
Received: from george.spearce.org ([209.20.77.23]:59366 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753936AbZDQO6r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 10:58:47 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6CEF338211; Fri, 17 Apr 2009 14:58:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <85647ef50904160703y3a416294k54f21b50f6006040@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116743>

Constantine Plotnikov <constantine.plotnikov@gmail.com> wrote:
> Instead of WalkTransport and PackTransport the transports
> are now using SshTransport, TcpTransport, and HttpTransport,
> indicating the type of basic underlying protocol is dealt
> with. This lays groundwork for supplying transport specific
> properties in the future. The WalkTransport and PackTransport
> are now marker interfaces.

The entire patch looks fine.  Except its corrupted by line wrapping
by your MUA.  Can you please resend without using format-flawed ?
:-)
 
>  .../spearce/jgit/transport/BasePackConnection.java |    8 +-
>  .../jgit/transport/BasePackFetchConnection.java    |    4 +-
>  .../jgit/transport/BasePackPushConnection.java     |    4 +-
>  .../jgit/transport/BundleFetchConnection.java      |  247 ++++++++++++++++++++
>  .../org/spearce/jgit/transport/HttpTransport.java  |   62 +++++
>  .../org/spearce/jgit/transport/PackTransport.java  |   12 +-
>  .../org/spearce/jgit/transport/SshTransport.java   |   62 +++++
>  .../org/spearce/jgit/transport/TcpTransport.java   |   62 +++++
>  .../spearce/jgit/transport/TransportAmazonS3.java  |    2 +-
>  .../spearce/jgit/transport/TransportBundle.java    |  227 +-----------------
>  .../jgit/transport/TransportBundleFile.java        |   16 ++-
>  .../jgit/transport/TransportBundleStream.java      |   11 +-
>  .../spearce/jgit/transport/TransportGitAnon.java   |    2 +-
>  .../spearce/jgit/transport/TransportGitSsh.java    |    2 +-
>  .../org/spearce/jgit/transport/TransportHttp.java  |    9 +-
>  .../org/spearce/jgit/transport/TransportLocal.java |    2 +-
>  .../org/spearce/jgit/transport/TransportSftp.java  |    2 +-
>  .../jgit/transport/WalkFetchConnection.java        |    3 +-
>  .../spearce/jgit/transport/WalkPushConnection.java |    5 +-
>  .../org/spearce/jgit/transport/WalkTransport.java  |   21 +--
>  20 files changed, 497 insertions(+), 266 deletions(-)
>  create mode 100644
> org.spearce.jgit/src/org/spearce/jgit/transport/BundleFetchConnection.java
>  create mode 100644
> org.spearce.jgit/src/org/spearce/jgit/transport/HttpTransport.java
>  create mode 100644
> org.spearce.jgit/src/org/spearce/jgit/transport/SshTransport.java
>  create mode 100644
> org.spearce.jgit/src/org/spearce/jgit/transport/TcpTransport.java

-- 
Shawn.
