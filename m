X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Sean Kelley" <sean.v.kelley@gmail.com>
Subject: Re: Stupid Git question
Date: Wed, 22 Nov 2006 08:28:58 -0600
Message-ID: <89b129c60611220628l59e305b8h4d2196f7cf6498d4@mail.gmail.com>
References: <89b129c60611211331r3bb286b6re3c2c8f65ec3896f@mail.gmail.com>
	 <89b129c60611211341j71079633g53b0ec1d2e3193a5@mail.gmail.com>
	 <ejvs65$vo8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 22 Nov 2006 14:29:25 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jVU/CEUqTvojnUebegYrZyEoXrhDZpasdpbF4N1rj0pCp1jHDQRV5dZZw2KfyIln99VLZXc4KIJf1QXAfWr122PYt9dZ0SmLmCsdYIpIibehlyZDoKTdCO1QCdCw/zNearNecBE574Gc4FqE5P+c/NXewECI1+0cXy/mfiPrWWE=
In-Reply-To: <ejvs65$vo8$1@sea.gmane.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32087>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gmt63-00025o-Nz for gcvg-git@gmane.org; Wed, 22 Nov
 2006 15:29:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755966AbWKVO3E (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 09:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755971AbWKVO3E
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 09:29:04 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:52008 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1755966AbWKVO3B
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 09:29:01 -0500
Received: by ug-out-1314.google.com with SMTP id 44so178735uga for
 <git@vger.kernel.org>; Wed, 22 Nov 2006 06:29:00 -0800 (PST)
Received: by 10.78.193.19 with SMTP id q19mr7866081huf.1164205738987; Wed, 22
 Nov 2006 06:28:58 -0800 (PST)
Received: by 10.78.179.10 with HTTP; Wed, 22 Nov 2006 06:28:58 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On 11/21/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Sean Kelley wrote:
>
> > git checkout origin
>
> It should be "git checkout master". You shouldn't do work on tracking
> branches like origin branch.
>
> > git pull . fm-modulator
> >
> > git push origin
>
> Here origin means origin remote (repository). Check out what you have in
> remotes/origin, or in [remote "origin"] section in git config.


Thanks!  One more question.  It appears that the problem that I am
having is that people are comitting to origin and should be committing
to master.  Perhaps the names can be confusing.  One suggestion made
is that we give a branch on the remote server a more meaningful name.

If on my remote server I have:

  /data/git/kernel/mh.git

How do I add a branch to the remote repository that is visible to all
team members.  It seems like the git checkout -b commands just create
local topic branches.

So I would have something like:

git clone git+ssh://git.example.com/data/git/kernel/mh.git kernel
cd kernel
git checkout Project
git checkout -b fm-modulator
edit/add/commit changes...

git checkout Project
git pull . fm-modulator
git push origin Project

So how do I create this Project branch on the remote repository such
that it is visible to all?  Do I log onto the remove server and do it
manually?  If so, how is that done?

Thanks!

Sean

> --
> Jakub Narebski
> Warsaw, Poland
> ShadeHawk on #git
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
