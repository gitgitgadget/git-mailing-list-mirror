From: Johan Herland <johan@herland.net>
Subject: Re: Hand-rolling migration to Git
Date: Tue, 25 Mar 2008 11:14:55 +0100
Message-ID: <200803251114.55673.johan@herland.net>
References: <Pine.LNX.4.64.0803251056570.8472@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Mar 25 11:16:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je6C8-0000Nm-Fy
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 11:15:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477AbYCYKPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 06:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752543AbYCYKPK
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 06:15:10 -0400
Received: from sam.opera.com ([213.236.208.81]:44756 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752477AbYCYKPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 06:15:09 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m2PAEt5N005911
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 25 Mar 2008 10:14:56 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <Pine.LNX.4.64.0803251056570.8472@ds9.cixit.se>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.92.1/6389/Tue Mar 25 07:58:48 2008 on smtp.opera.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78170>

On Tuesday 25 March 2008, Peter Karlsson wrote:
> Hi!
> 
> I am looking for documentation on how to hand-roll a conversion to Git,
> but I keep getting lost in the maze of similar-looking man pages. Is
> there a tutorial, howto, or perhaps even just a list of recommended man
> pages to read on importing project changes to Git?
> 
> I have projects of two different kinds that I need to import:
> 
> 1. The "make a copy of the source code directory and edit the new copy"
> source management system. I need to be able to import one directory at
> a time, each describing a version controlled state. The date stamp on
> the commits should probably be the most recent file in each directory.
> 
> 2. A piece of software using PVCS (a RCS-like version control system
> with added support for parallel development (using a locking model)). I
> have a complete "trail file" which lists all commits done to the
> repository in chronological order since the repository was created, and
> can use that as a base. Since it has no concept of an atomic commit, I
> need to semi-manually join commits by walking the trail file and
> comparing lock sets, time stamps, commit messages and authors.
> 
> I can probably make the output from (2) look like from (1), so I
> basically just need to find a pointer to information on how to
> (re-)create the history with Git.

Take a look at git-fast-import. It should be relatively easy to write a small script that converts from either (1) or (2) to a stream of git-fast-import commands.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
