X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git and bzr
Date: Wed, 29 Nov 2006 11:47:38 +1300
Message-ID: <46a038f90611281447j66ea97f2j9ecbe9af0edcc620@mail.gmail.com>
References: <45357CC3.4040507@utoronto.ca>
	 <Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0611280754050.30076@woody.osdl.org>
	 <456C7592.6020700@ableton.com> <ekhtnt$rkk$1@sea.gmane.org>
	 <456C9DFF.1040407@onlinehome.de>
	 <46a038f90611281340u521fb5fct745ebe1ded9a630e@mail.gmail.com>
	 <456CADE9.7060503@onlinehome.de>
	 <46a038f90611281414y165ed376r80e3dbc3c7888985@mail.gmail.com>
	 <456CB9D3.4060900@onlinehome.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 22:47:52 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"bazaar-ng@lists.canonical.com" <bazaar-ng@lists.canonical.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kh5WEWKaOIVwPHXpDyxm77luC7LqsXVI2lf79Vtm5FW1mN9V85HlbUbQH6keEIz12KPu6/J2JTT9oBgtJ4KzR5Z7rKddSSlfdtSdpj7VizA+CiOyM1Cse7T4SVfvcTApWCc0u2oLtGYvK0ZHnswhH+VLkHTHg/bNifh/VuMY6a4=
In-Reply-To: <456CB9D3.4060900@onlinehome.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32603>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpBjr-0004vu-FE for gcvg-git@gmane.org; Tue, 28 Nov
 2006 23:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755296AbWK1Wrk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 17:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755276AbWK1Wrk
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 17:47:40 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:39291 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1755296AbWK1Wrk
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 17:47:40 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2713468nfa for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 14:47:38 -0800 (PST)
Received: by 10.49.10.17 with SMTP id n17mr5312207nfi.1164754058626; Tue, 28
 Nov 2006 14:47:38 -0800 (PST)
Received: by 10.49.60.1 with HTTP; Tue, 28 Nov 2006 14:47:38 -0800 (PST)
To: "Nicholas Allen" <nick.allen@onlinehome.de>
Sender: git-owner@vger.kernel.org

On 11/29/06, Nicholas Allen <nick.allen@onlinehome.de> wrote:
> > ps: hope you don't mind I re-added the CC to git@vger in my reply
>
> Of course not - I also added bzr mailing list back on this discussion too...

Cool

> For the kind of development we do this is not really a big deal though
> as all developers can agree on using one RCS. But if you mix git and svn
> in this way then the changes can only go one way (from svn to git) can't
> they as svn is not so intelligent so this somewhat limits its usefulness
> doesn't it?

Well, if you look in the git toolset, you'll find things like git-svn
which is geared to make it almost transparent to use git to work on a
project where the upstream is using svn and push patches into SVN (if
you have write access, naturally). And git-cvsexportcommit which is a
lot less useful but helps me push series of patches from git into cvs
easily and with the certaintly that I am not messing up the content.

> I know bzr it has some beta level plugin support for SVN foreign
> branches (git, mercurial and svk ones too I think) and I believe this
> works in both directions. So you can commit to bzr, push that to an svn
> repository and also pull changes from svn. Merge branches in bzr and
> commit back to svn with log messages and history intact. So bzr still
> allows the use of multiple RCS systems...

Sounds roughly like git-svn ;-)

converge, ye DSCMs


