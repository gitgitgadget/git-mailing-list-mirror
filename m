From: Benjamin Meyer <ben@meyerhome.net>
Subject: Re: git-p4 and git clone
Date: Mon, 22 Mar 2010 20:15:19 -0400
Message-ID: <4880E32B-7880-40BF-8AFD-AC00DA457CEE@meyerhome.net>
References: <B978892CA0FBD142827E74F92AC4BBD429B2444D4D@HQMAIL03.nvidia.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "'git@vger.kernel.org'" <git@vger.kernel.org>
To: Thomas Kistler <tkistler@nvidia.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 01:15:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtrmP-0005DL-Ac
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 01:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754826Ab0CWAP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 20:15:28 -0400
Received: from qmta07.westchester.pa.mail.comcast.net ([76.96.62.64]:32774
	"EHLO qmta07.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751532Ab0CWAP1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 20:15:27 -0400
Received: from omta15.westchester.pa.mail.comcast.net ([76.96.62.87])
	by qmta07.westchester.pa.mail.comcast.net with comcast
	id wH8F1d0051swQuc57QFUVR; Tue, 23 Mar 2010 00:15:28 +0000
Received: from [192.168.3.111] ([71.192.50.29])
	by omta15.westchester.pa.mail.comcast.net with comcast
	id wQK91d0040dnthT3bQKGov; Tue, 23 Mar 2010 00:19:16 +0000
In-Reply-To: <B978892CA0FBD142827E74F92AC4BBD429B2444D4D@HQMAIL03.nvidia.com>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142980>


On Mar 22, 2010, at 7:16 PM, Thomas Kistler wrote:

> I'm probably missing something fairly fundamental but I'm running into problems with cloning a git-p4 repository:
> 
> First, I'm setting up a git-p4 master repository:
> 
>    $ cd tmp1
>    $ git-p4 clone //foo/bar
> 
> Then I'm cloning it through git:
> 
>    $ cd tmp2
>    $ git clone tmp1/bar
> 
> Finally, I'm trying to submit back to p4:
> 
>    $ git-p4 submit
> 
> This now fails because the remotes/p4/master seems to get lost when doing the "git clone". Is this supposed to work?
> 
> -Thomas

There is a -import-local option you can use.  Then the p4/master branch is local and when you do the second clone you will get the p4/master branch.

-Benjamin Meyer