From: Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: Git GUI client SmartGit released
Date: Wed, 02 Dec 2009 22:15:36 +0100
Message-ID: <4B16D8F8.90804@syntevo.com>
References: <4B161B15.2020106@syntevo.com> <20091202164810.GB31648@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Alexander Kitaev <Alexander.Kitaev@svnkit.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 02 22:15:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFwY7-0000yH-0H
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 22:15:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755448AbZLBVPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 16:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755266AbZLBVPd
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 16:15:33 -0500
Received: from syntevo.com ([85.214.39.145]:44727 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755263AbZLBVPd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 16:15:33 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTP id 2931F37C767
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20091202164810.GB31648@spearce.org>
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134402>

> I noticed you use JGit and the Trilead SSH client.
> 
> I'm curious, did you guys replace JSch because its a pile of junk?
> Did you patch JGit to use Trilead SSH instead of JSch?  If so,
> would you be interested in contributing that change back to JGit?
> I'm rather fed up with JSch...  :-)

We currently don't use JGit's transport, but we plant a custom SSH
client on the git executable which connects back to SmartGit and just
tunnels SSH data through. Anyway, I can remember that SVNKit was using
JSch initially and they switched to Trilead because of problems with
JSch (maybe Alexander in Cc can shed more light on that).

--
Best regards,
Marc Strapetz
=============
syntevo GmbH
http://www.syntevo.com
http://blog.syntevo.com



Shawn O. Pearce wrote:
> Marc Strapetz <marc.strapetz@syntevo.com> wrote:
>> We are proud to announce the general availability of our Git client
>> SmartGit[1]:
>>
>>  http://www.syntevo.com/smartgit/index.html
> 
> Congrats on your release.
> 
> I noticed you use JGit and the Trilead SSH client.
> 
> I'm curious, did you guys replace JSch because its a pile of junk?
> Did you patch JGit to use Trilead SSH instead of JSch?  If so,
> would you be interested in contributing that change back to JGit?
> I'm rather fed up with JSch...  :-)
> 
