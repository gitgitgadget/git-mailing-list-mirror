X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Cleaning up git user-interface warts
Date: Tue, 14 Nov 2006 23:04:33 +0100
Message-ID: <200611142304.33673.jnareb@gmail.com>
References: <87k61yt1x2.wl%cworth@cworth.org> <ejdapj$vc0$1@sea.gmane.org> <Pine.LNX.4.64.0611141627200.2591@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 14 Nov 2006 22:03:42 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pc9VfctYlM69lvOj83nIdyIxgs4Lxyk0mxVHgpQxtSIS2FzyDMnhp63SEYu7gNueaMb4zCXN5rzEJznpaOumhA/Sm6a7BB06WTHU0nux6ZVfFkAmN1p/jnocy73QGxAgPUvZHEQjDgzUhWSzgxGGfQ1tkJNv8GoI4JZE5soLJL4=
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0611141627200.2591@xanadu.home>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31383>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk6NP-0001Qn-Nf for gcvg-git@gmane.org; Tue, 14 Nov
 2006 23:03:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966386AbWKNWD2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 17:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966411AbWKNWD1
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 17:03:27 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:46450 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S966386AbWKNWD1
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 17:03:27 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1470372ugc for
 <git@vger.kernel.org>; Tue, 14 Nov 2006 14:03:25 -0800 (PST)
Received: by 10.67.101.10 with SMTP id d10mr1596013ugm.1163541805356; Tue, 14
 Nov 2006 14:03:25 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id 39sm7009885ugb.2006.11.14.14.03.24; Tue, 14 Nov
 2006 14:03:25 -0800 (PST)
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre wrote:
> On Tue, 14 Nov 2006, Jakub Narebski wrote:

>> We can always have --merge arguments to git-pull, and --fetch argument to
>> git-merge.
> 
> That would be a complete abomination if you want my opinion.
> 
> Please let git-pull actually pull stuff from a remote place, and 
> git-merge actually merge stuff only.  Let's keep simple concepts mapped 
> to simple commands please.  Nothing prevents _you_ from scripting more 
> involved operations with a single command of your liking afterwards.

Do we want to abandon completely "single-branch" workflow, where you
don't use tracking branch, only merge directly into your working branch?
That is the cause to (unused by most) future git-merge (replacement for
git-pull .) --fetch=<remote>[#<branch>] option.

I'm not that sure about --merge option, but it could be useful, at least
to have current automatic "Merge branch '<branch>' of <URL>" commit message.
-- 
Jakub Narebski
