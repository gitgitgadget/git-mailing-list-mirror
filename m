From: "J.H." <warthog9@kernel.org>
Subject: Re: problems installing git docs and gitweb on centos 5.5
Date: Thu, 30 Sep 2010 15:35:22 -0700
Message-ID: <4CA510AA.2010908@kernel.org>
References: <4CA3EFE6.2010306@brainstorm-digital.com> <20100930024059.GA2373@burratino> <4CA41FCC.8050704@kernel.org> <4CA49D39.1020403@brainstorm-digital.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Dennis Huynh <dennis@brainstorm-digital.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 00:35:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1Rit-0007kd-RQ
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 00:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756592Ab0I3Wf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 18:35:26 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:56726 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911Ab0I3WfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 18:35:25 -0400
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id o8UMZMW3013161
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Thu, 30 Sep 2010 15:35:23 -0700
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.7
In-Reply-To: <4CA49D39.1020403@brainstorm-digital.com>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 30 Sep 2010 15:35:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157718>

On 09/30/2010 07:22 AM, Dennis Huynh wrote:
> Alright, I'm going with the Fedora EPEL repositories.  But last I
> checked the latest version available via that method was 1.5.x.  Since
> this is a server, I preferred to use the latest and greatest so to last
> in the long run from any major patches or cover any major upgrades, but
> if that's the version that's preferred, who am I to argue.  One problem
> I recall in yum'ing the install for git however was the man pages
> weren't installed either.  I could be wrong however.  I'll keep you guys
> up to date.  Wish me luck!  Thanks for all your help and the timely
> responses.

The stuff in EPEL is a bit older, I should have words with whoever is
maintaining those to see if we can get those upgraded.  There really
isn't any reason those should be lagging that much.

This is however why I suggested just recompiling the rpms present on
kernel.org, which would get you the latest and greatest and not,
completely, push you into maintaining the packages on your own.

> Also, is there how-tos you'd suggest I use in setting up the git/gitweb
> combo with the yum install?  I noticed yum installs files in different
> locations then the source does.  Thanks again!

They install into different locations though the instructions should be
relatively straight forward.

http://git.kernel.org/?p=git/warthog9/gitweb.git;a=blob;f=gitweb/README;h=ad6a04c464075c31afe3c67222f0bdeabc76f569;hb=HEAD

is the official documentation, but a quick glance at it shows that it
doesn't stay consistent on where the the document root is.  If you have
problems give me a holler and I'll throw up how I have it configured at
kernel.org on the kernel.org wiki as a reference point for people to a
specific installation.

- John 'Warthog9' Hawley
