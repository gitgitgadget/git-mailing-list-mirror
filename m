From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [ANNOUNCE] Stacked Git 0.15-rc1
Date: Mon, 13 Jul 2009 18:07:06 +0100
Message-ID: <b0943d9e0907131007q18dbed72tc017be92ed23a61d@mail.gmail.com>
References: <b0943d9e0907121540n4b9199e2re3152e71d84a0f5@mail.gmail.com>
	 <20090713133343.GA23946@skywalker>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Karl Wiberg <kha@treskal.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
X-From: git-owner@vger.kernel.org Mon Jul 13 19:13:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQP5q-0005dq-72
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 19:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756514AbZGMRNZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jul 2009 13:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756438AbZGMRNY
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 13:13:24 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:60583 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755887AbZGMRNY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jul 2009 13:13:24 -0400
Received: by fxm18 with SMTP id 18so2324448fxm.37
        for <git@vger.kernel.org>; Mon, 13 Jul 2009 10:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bW7fZL1C0IgtxFe3DT/Mg8WYG4QuhcJUISb7Eoq6EEc=;
        b=RAG6nmYeezoPFFJjzjelJm9WPOVizE1MWj+x8+COXYvanJR24XFp5k0cHcrPq6OXsm
         UFxsO9vIpDGzpC0SB9KHGb0nyiizdWpDx+qLurdhCjOR+OJ69rSx2iqSLwVqIxF4UqN3
         ep3Y1OUm6T+1CakmuoAMpc6gJ26or6g3rmqQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YlS5Q/aH6bq0ClxWHJbC3+M5nlI9APJ5GiCEzQ6eEwvHoOqY8xh3yJODyIXy/YPkpz
         grZlUv+qHOa95Q0xSFB1gNwWmZCicUypWOsIaSblWu2sAHIMH1oTy5YeX1xbfttEb3EX
         bPUCHlFz/Y3OC3tP6OiG80/uFAEWrG0nS2lJA=
Received: by 10.223.119.198 with SMTP id a6mr2353639far.42.1247504826862; Mon, 
	13 Jul 2009 10:07:06 -0700 (PDT)
In-Reply-To: <20090713133343.GA23946@skywalker>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123199>

2009/7/13 Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>:
> On Sun, Jul 12, 2009 at 11:40:05PM +0100, Catalin Marinas wrote:
>> The first release candidate for StGit 0.15 is available from the
>> git://repo.or.cz/stgit.git or http://download.gna.org/stgit/. Bugs c=
an
>> be reported on the Git mailing list or via the project bugs page
>> (https://gna.org/bugs/?group=3Dstgit).
>>
>> StGit is a Python application providing similar functionality to Qui=
lt
>> (i.e. pushing/popping patches to/from a stack) on top of Git. These
>> operations are performed using Git commands and the patches are stor=
ed
>> as Git commit objects, allowing easy merging of the StGit patches in=
to
>> other repositories using standard Git functionality.
>>
>> The main changes since release 0.14.3 (I may miss some important
>> features but they can be found in the log):
>
>
> stg show now gives me output like below
>
> ESC[1mdiff --git a/fs/nfs/nfs4acl.c b/fs/nfs/nfs4acl.cESC[m
> ESC[1mindex 09946da..c9a6dee 100644ESC[m
> ESC[1m--- a/fs/nfs/nfs4acl.cESC[m
> ESC[1m+++ b/fs/nfs/nfs4acl.cESC[m
> ESC[36m@@ -37,6 +37,7 @@ESC[m

It works fine for me. Do you have a pager for StGit configured in .gitc=
onfig?

StGit now uses the default output from git (with colours)

> I guess it is due to coloring enabled in git. I have in git
>
> $ git config --get =A0"color.ui"

What does "git config color.diff" say?

--=20
Catalin
