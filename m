X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: how to authenticate with git-svn on a subversion repository
Date: Thu, 16 Nov 2006 19:59:10 +1300
Message-ID: <46a038f90611152259w6914c633u8de4adeca5dfa176@mail.gmail.com>
References: <4559D37E.1070703@archlinuxfr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 16 Nov 2006 06:59:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=geiNN9w8MWgQ/FoknLR6/XmgQY4huORh1dx7zG3ED/kAxoIKMsrhVqsiQ20JURWTZJk0051EzeLellI9Y+wWVUgYS/q1XtqBd1z2IzBqPjQAATlkc1XxORx1XO01vuMG5TaWyKbMfj8tUL8W6rLsa9p11IGaQgRf388vmLLnS+g=
In-Reply-To: <4559D37E.1070703@archlinuxfr.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31562>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkbDQ-0007FI-Tv for gcvg-git@gmane.org; Thu, 16 Nov
 2006 07:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161941AbWKPG7N (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 01:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161942AbWKPG7N
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 01:59:13 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:17095 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1161941AbWKPG7M
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 01:59:12 -0500
Received: by nf-out-0910.google.com with SMTP id o25so888629nfa for
 <git@vger.kernel.org>; Wed, 15 Nov 2006 22:59:11 -0800 (PST)
Received: by 10.49.13.19 with SMTP id q19mr216394nfi.1163660350648; Wed, 15
 Nov 2006 22:59:10 -0800 (PST)
Received: by 10.49.60.1 with HTTP; Wed, 15 Nov 2006 22:59:10 -0800 (PST)
To: "=?ISO-8859-1?Q?Com=E8te?=" <comete@archlinuxfr.org>
Sender: git-owner@vger.kernel.org

Hi Comete,

authentication with the SVN stuff is really weird. git-svn and
git-svnimport use the SVN libraries so that means that if you do

   svn login proto://host/path/to/repo
   git-svn proto://host/path/to/repo

it works because svn magic cookies get stored in ~/.svn.

cheers,


