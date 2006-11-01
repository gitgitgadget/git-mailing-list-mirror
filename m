X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Matt McCutchen" <hashproduct+git@gmail.com>
Subject: Re: How to view an old revision?
Date: Wed, 1 Nov 2006 11:25:35 -0500
Message-ID: <3bbc18d20611010825ha4063d6wacf4f997d4652d35@mail.gmail.com>
References: <3bbc18d20611010620m11e40402v44334a8c486a4932@mail.gmail.com>
	 <4548AFA2.1040606@shadowen.org>
	 <3bbc18d20611010637s6d05aecbt98322b62cf7235e8@mail.gmail.com>
	 <4548B32A.5030803@shadowen.org>
	 <7vzmbb2m42.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 1 Nov 2006 16:26:04 +0000 (UTC)
Cc: "Andy Whitcroft" <apw@shadowen.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=KQYkbIyapELOmLNiu1uyXgO0naCKCbfHe37hIdIrYbzvn3RrLBOt/Y5cd2J7Y95SAUhu5pCgkTErJEBQOzSO/IGtkntY0OXGsyZqpAolMIyVkzyWkHnMnO6pq+MduRja/9OPV1+HGRBSngtgqCgafDeogTOBl3LYtTXMD7zIAVo=
In-Reply-To: <7vzmbb2m42.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Google-Sender-Auth: 86fcfa505eedd42d
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30648>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfIuW-0000kN-Uw for gcvg-git@gmane.org; Wed, 01 Nov
 2006 17:25:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S2992548AbWKAQZj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 11:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992630AbWKAQZj
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 11:25:39 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:46620 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S2992548AbWKAQZi
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 11:25:38 -0500
Received: by nf-out-0910.google.com with SMTP id c2so891124nfe for
 <git@vger.kernel.org>; Wed, 01 Nov 2006 08:25:37 -0800 (PST)
Received: by 10.82.111.8 with SMTP id j8mr1533838buc; Wed, 01 Nov 2006
 08:25:35 -0800 (PST)
Received: by 10.82.129.2 with HTTP; Wed, 1 Nov 2006 08:25:35 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 11/1/06, Junio C Hamano <junkio@cox.net> wrote:
> I was actually reviewing the documentation of git-rev-parse and
> noticed that it talks about naming objects in the section called
> "SPECIFYING REVISIONS".  The title implies that it is about
> committish (because we think of "revisions" as something that is
> used in walking commit ancestry chains), but it actually talks
> about naming objects of any type.

There's no way I would have known to look in git-rev-parse.  My
git-rev-parse man page doesn't mention the colon syntax, but now I see
that part in git's gitweb; my man page must be too old.  Either (1) or
(2) would have been enough for me to figure out that the colon syntax
would do what I wanted, but to grab the attention of the less
persistent user, it would be good to mention the particular case of
"git-cat-file <commit-ish>:<file>" in the git-cat-file man page.

