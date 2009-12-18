From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: core.autocrlf & Cygwin - files incorrectly flagged as modified
Date: Fri, 18 Dec 2009 07:06:46 +0100
Message-ID: <200912180706.46455.robin.rosenberg@dewire.com>
References: <loom.20091215T225528-115@post.gmane.org> <200912170800.35752.robin.rosenberg@dewire.com> <loom.20091218T033941-445@post.gmane.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Antliff <david.antliff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 07:07:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLVzk-0002Rf-Qj
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 07:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbZLRGHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 01:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbZLRGHI
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 01:07:08 -0500
Received: from mail.dewire.com ([83.140.172.130]:8190 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797AbZLRGHG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 01:07:06 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id DAA6E139DE5E;
	Fri, 18 Dec 2009 07:07:03 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w-wX-oZrWrdp; Fri, 18 Dec 2009 07:06:57 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id A0D4D800688;
	Fri, 18 Dec 2009 07:06:55 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31-17-generic; KDE/4.3.2; i686; ; )
In-Reply-To: <loom.20091218T033941-445@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135402>

fredagen den 18 december 2009 03.43.05 skrev  David Antliff:
> Robin Rosenberg writes:
> > tisdag 15 december 2009 23:24:15 skrev  David Antliff:
> > > The problem is that sometimes, after a git-clone, the output of
> > > git-status and git-diff shows entire files as being different. However
> > > these files have not been modified by the user - only git has had a
> > > chance to change them (due to autocrlf=true). But surely if git has
> > > converted the file automatically, it should know that it has to
> > > compensate for this when comparing with the local repository?
> >
> > AFAIK, this happens if you have CRLF line endings in the blobs in the
> > repo.
> 
> Oh? That could very well be true - how would such line endings get into a
>  blob? I'm pretty sure everyone is using autocrlf=true which should convert
>  all line endings to LF on commit, but perhaps there's another way to get
>  CRLF line endings into a blob?
> 
> If autocrlf=false, files are committed as-is (I believe), so this would be
>  one way to end up committing such files. But as far as I know, nobody has
>  turned that option off in our group.

EGit works this way at the moment. 
Conversion tools might do this.
Some Eclipse plugins produce files with CRLF regardless on platform and on
non-Windows the core.autocrlf flags is false by default.

-- robin
