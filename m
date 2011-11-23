From: Bernd Schubert <bernd.schubert@itwm.fraunhofer.de>
Subject: Re: svn to git with non-standard layout
Date: Wed, 23 Nov 2011 22:45:32 +0100
Message-ID: <4ECD697C.5010109@itwm.fraunhofer.de>
References: <jajh7m$it7$1@dough.gmane.org> <op.v5e36lxp0aolir@keputer.lokaal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 22:45:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTKdQ-0006sG-8j
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 22:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756212Ab1KWVpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 16:45:36 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:53509 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755929Ab1KWVpf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Nov 2011 16:45:35 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 3656C21455
	for <git@vger.kernel.org>; Wed, 23 Nov 2011 16:45:34 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Wed, 23 Nov 2011 16:45:34 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=mcDAX43s2g4Mbamx5Ccp+Z
	jfCBo=; b=k7Eerbl2De/AQwUDHhyeSk09xx+rkmDntUPKtLVD/Q40Ej0COEOD1/
	ElenhTL8ut26DAH9pMX98WOBd+OPWxEW+Oe427r6Zk3WiF7pd9gXdfgxKMTsoeGW
	gJA14bxF3PWVxjWajcLyfLQue8DGwwbcsvB7iAvSzH0SOWquHoYGM=
X-Sasl-enc: zW99gMFrrdeAU0egxLmWOXGap8Io+dlM/2notmhS1IQw 1322084733
Received: from [192.168.178.29] (95-89-141-39-dynip.superkabel.de [95.89.141.39])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9C2678E0102;
	Wed, 23 Nov 2011 16:45:33 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0.1) Gecko/20111031 Thunderbird/7.0.1
In-Reply-To: <op.v5e36lxp0aolir@keputer.lokaal>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185880>

On 11/23/2011 10:19 PM, Frans Klaver wrote:
> On Wed, 23 Nov 2011 20:23:34 +0100, Bernd Schubert
> <bernd.schubert@itwm.fraunhofer.de> wrote:
>
>> we just want to migrate from subversion to git, but so far all
>> attempts to do that resulted in missing commit information.
>
> What are all attempts? Did you try only git-svn, or did you try tools
> like svn2git?

We are trying to do this ever since Monday and it included svn2git as 
well. The problem with svn2git is that you can provide several tags and 
branch paths, but only a single trunk path.

>
>
>> Any ideas what I still could try to do?
>
> If you haven't tried anything other than git-svn, try svneverever &
> svn2git[1] for an actual repository conversion. Or have a look at the
> newest kid on the block called SubGit[2][3]. In both I don't have any
> experience, but of svn2git I know Qt and KDE have used it successfully
> to convert their repositories.
>
> I assume both are somewhat more complex to use and set up than to simply
> use git-svn, but I guess it will be worth the effort.
>
> Good luck,
> Frans
>
> [1] http://techbase.kde.org/Projects/MoveToGit/UsingSvn2Git
> [2] http://subgit.com/
> [3] http://thread.gmane.org/gmane.comp.version-control.git/185806

Thanks, I'm going to read about svneverever and SubGit tomorrow. We will 
also try another tool that can convert an svn dump (once we get a dump, 
as we don't have easy access to the svn database).

Thanks,
Bernd
