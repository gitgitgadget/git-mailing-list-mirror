From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add maven distribution management info for the new
	snapshot repository
Date: Tue, 11 Nov 2008 16:58:38 -0800
Message-ID: <20081112005838.GU2932@spearce.org>
References: <4919EECB.7070408@wellfleetsoftware.com> <2c6b72b30811111337v2fe23c75v25251838f721a007@mail.gmail.com> <20081111214434.GS2932@spearce.org> <2c6b72b30811111401i3c995889n54407243a1072599@mail.gmail.com> <20081111231106.GT2932@spearce.org> <20081111234858.GA17662@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonas Fonseca <jonas.fonseca@gmail.com>,
	Farrukh Najmi <farrukh@wellfleetsoftware.com>,
	git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Wed Nov 12 02:00:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L045Q-0004yF-9n
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 02:00:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbYKLA6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 19:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752106AbYKLA6j
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 19:58:39 -0500
Received: from george.spearce.org ([209.20.77.23]:54234 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079AbYKLA6i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 19:58:38 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0F396381FF; Wed, 12 Nov 2008 00:58:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081111234858.GA17662@diku.dk>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100710>

Jonas Fonseca <fonseca@diku.dk> wrote:
>  Shawn O. Pearce <spearce@spearce.org> wrote Tue, Nov 11, 2008:
>  > Jonas Fonseca <jonas.fonseca@gmail.com> wrote:
>  > > I don't think admin rights are necessary as long as I have
>  > > "commit"/webdav access. And no svn or git-svn interaction should be
>  > > needed to upload to the maven repository.
>  > 
>  > Then have at it.  It sounds like it would be worthwhile setting up.
> 
>  Instructions at http://code.google.com/p/egit/wiki/ConfiguringMaven
> 
> diff --git a/jgit-maven/jgit/pom.xml b/jgit-maven/jgit/pom.xml
> index a123470..c370783 100644
> --- a/jgit-maven/jgit/pom.xml
> +++ b/jgit-maven/jgit/pom.xml
> @@ -185,4 +185,12 @@ ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>              <scope>compile</scope>
>          </dependency>
>      </dependencies>
> +    <distributionManagement>
> +        <snapshotRepository>
> +            <id>jgit-maven-snapshot-repository</id>
> +            <name>JGit Maven Snapshot Repository</name>
> +            <url>dav:https://egit.googlecode.com/svn/maven/snapshot-repository/</url>

Shouldn't that be http:// and not https:// ?

The https interface asked me for a username/password, the
http:// one doesn't.  We want this to be public, don't we?

-- 
Shawn.
