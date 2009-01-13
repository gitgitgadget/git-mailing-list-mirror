From: Stephen Bannasch <stephen.bannasch@deanbrook.org>
Subject: Re: egit problem with sym linked eclipse project dirs
Date: Tue, 13 Jan 2009 18:27:51 -0500
Message-ID: <p0624085fc592d385c7fb@[192.168.1.114]>
References: <p0624081cc5928e2885fd@[192.168.1.114]> <200901132237.11946.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Cc: git@vger.kernel.org, Scott Cytacki <scytacki@fastmail.fm>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 14 00:29:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMshe-0005nu-Qo
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 00:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759597AbZAMX2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 18:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759376AbZAMX2H
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 18:28:07 -0500
Received: from deanbrook.org ([72.52.70.192]:54124 "HELO deanbrook.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758788AbZAMX2D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 18:28:03 -0500
Received: from ::ffff:71.161.144.33 ([71.161.144.33]) by deanbrook.org for <git@vger.kernel.org>; Tue, 13 Jan 2009 15:27:58 -0800
In-Reply-To: <200901132237.11946.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105558>

At 10:37 PM +0100 1/13/09, Robin Rosenberg wrote:
>  > To hack around Eclipse's problem with projects in nested directories
>>  I clone a repo and then create a new top-level dir that just has
>>  symbolic links to all the project directories.
>>
>>  However when I Team/Share with git using egit the resources become
>>  untracked when displayed in Eclipse -- they still are tracked however
>>  when I check from the command line.
>
>I've seen this too, but so far not got myself to actually fix it. I 
>think it has do with
>that we ask eclipse project for it's path end there we gets off track. Thanks
>for providing a good example that help "someone" to fix it.
>
>Could you add an issue at http://code.google.com/p/egit/issues/list and maybe
>include a tar  ball with a simple project displaying this behaviour? 
>(with a note
>that the symlinks makes this impossible to recreate on Windows).

Done: http://code.google.com/p/egit/issues/detail?id=52

Fxing this will make using Eclipse and Git together SO much nicer!
