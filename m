X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Patch to tutorial.txt
Date: Mon, 20 Nov 2006 10:25:10 +0100
Message-ID: <200611201025.11048.jnareb@gmail.com>
References: <4d8e3fd30611191444r710f23e5uc488d35aa4abaf06@mail.gmail.com> <200611200949.32722.jnareb@gmail.com> <4d8e3fd30611200110y224b5b8dpf974d30d738455c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 20 Nov 2006 09:23:57 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=iGA+0aAt30XIAat0k2U16m4mtw7H6+kbphatMLINvAtg05CQOEmUG/VY0RjFSRGv4HihJ2zlsndwL2Sl81oQ7iqwGQ5DJPbGopa1mjcMRC6NHzQJ5utKOxsa4O3yoqxg+k4pMkbJJQBkOwai2Xqv5DSOVIOHj3setpH25YNMKME=
User-Agent: KMail/1.9.3
In-Reply-To: <4d8e3fd30611200110y224b5b8dpf974d30d738455c9@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31888>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gm5NW-0005a4-80 for gcvg-git@gmane.org; Mon, 20 Nov
 2006 10:23:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934033AbWKTJXr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 04:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934034AbWKTJXr
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 04:23:47 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:50986 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S934033AbWKTJXq
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 04:23:46 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1123979ugc for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 01:23:45 -0800 (PST)
Received: by 10.66.242.5 with SMTP id p5mr6935842ugh.1164014624612; Mon, 20
 Nov 2006 01:23:44 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id 29sm7383152uga.2006.11.20.01.23.44; Mon, 20 Nov
 2006 01:23:44 -0800 (PST)
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Sender: git-owner@vger.kernel.org

Paolo Ciarrocchi wrote:
> On 11/20/06, Jakub Narebski <jnareb@gmail.com> wrote:
>
>> followed by empty line, then signoff line, for example
>>
>>   Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
> 
> Ok, but the Signed/off-by part should handled by the -s option in
> git-format-patch.

Signed-off-by _can_ be added by -s option in git-format-patch, but 
I think it is usually better to have it added in the commit, by the -s 
option to git-commit.

-- 
Jakub Narebski
