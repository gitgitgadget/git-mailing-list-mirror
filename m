X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: Re: git pull and merging.
Date: Wed, 6 Dec 2006 15:35:15 +0530
Message-ID: <cc723f590612060205p1fd26cd7u3c7efc723b0177de@mail.gmail.com>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com>
	 <7vodqhaa7o.fsf@assigned-by-dhcp.cox.net>
	 <cc723f590612052121u1f6e3c9lc7329f40ee1c9e5a@mail.gmail.com>
	 <Pine.LNX.4.63.0612061019350.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 10:05:36 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NTRlIiXk7QAR2SbaVNlwpaPrgR6esYoLW+ZjedspboClsx42SVjcLcMeB0Izf9OT7lNPM8Z7tAddynkY9MBuQ+PIYfcOCEsEc3AjiVQnnSk5UMM5nfiJFQddMNgYa4yOCECBWU6Kz5+eP64qLTq6opE2JvOWQPjBzlMrXwJge0c=
In-Reply-To: <Pine.LNX.4.63.0612061019350.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33419>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grtef-0008VQ-4Q for gcvg-git@gmane.org; Wed, 06 Dec
 2006 11:05:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760424AbWLFKFU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 05:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760425AbWLFKFT
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 05:05:19 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:50157 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1760409AbWLFKFR (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 05:05:17 -0500
Received: by nf-out-0910.google.com with SMTP id o25so508047nfa for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 02:05:16 -0800 (PST)
Received: by 10.48.14.4 with SMTP id 4mr1941835nfn.1165399515870; Wed, 06 Dec
 2006 02:05:15 -0800 (PST)
Received: by 10.48.210.15 with HTTP; Wed, 6 Dec 2006 02:05:15 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On 12/6/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > I almost felt the branch.<name>.merge was for that.
>
> No. This tells git which _default_ branch to merge with. I.e.
>
> $ git repo-config branch.master.remote origin
> $ git repo-config branch.master.merge next
>
> means that if your current branch is "master", a "git pull" _without_
> parameters will default to the branch "next" of the remote "origin" you
> just set up like above.

This doesn't work. So this is what i tried
test repository with master and devel branch
cloned it to test.devel

.git/config have

[branch "devel"]
        remote = origin
        merge = devel

Now IIUC this should be when i am in branch devel when i do a git pull
pull from origin remote and merge with the local branch devel  the
remote branch devel.

But git pull says already up to date.

Now i thought merge should be local reference. So i changed it to
merge = remotes/origin/devel.

That also didn't work.

Then i tried the name of the branch should be indicated as
"refs/heads/devel" . That also didn't work.

So i guess i am missing something.

