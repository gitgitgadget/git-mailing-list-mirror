X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-show --stat on first commit
Date: Fri, 24 Nov 2006 08:49:53 +0100
Message-ID: <200611240849.53510.jnareb@gmail.com>
References: <200611211341.48862.andyparkins@gmail.com> <ejvlv9$781$1@sea.gmane.org> <200611230925.07821.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 24 Nov 2006 07:48:35 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tWt4NGFpFNooJoKlnoV96wbN12oz0wqncIDKC43ZMq2q25ynittmxZxwwQwSvygyZH6O1bIEDKOCqD7ly8Y49x4Nr8NvT6aXd1Vx6L9gKPxPuR1WIRjDeD//f9C1haUVd0cLNfycEh4PX/OjXSDUNVRHgSAZDySmntDlfwLpD58=
User-Agent: KMail/1.9.3
In-Reply-To: <200611230925.07821.andyparkins@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32191>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnVnT-0004lU-LX for gcvg-git@gmane.org; Fri, 24 Nov
 2006 08:48:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756461AbWKXHsR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 02:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757628AbWKXHsR
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 02:48:17 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:29230 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1756461AbWKXHsQ
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 02:48:16 -0500
Received: by ug-out-1314.google.com with SMTP id 44so602527uga for
 <git@vger.kernel.org>; Thu, 23 Nov 2006 23:48:15 -0800 (PST)
Received: by 10.67.97.7 with SMTP id z7mr6530183ugl.1164354495355; Thu, 23
 Nov 2006 23:48:15 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id k30sm14272260ugc.2006.11.23.23.48.14; Thu, 23 Nov
 2006 23:48:15 -0800 (PST)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:
> On Tuesday 2006 November 21 20:03, Jakub Narebski wrote:
> 
>> We don't show patch for merges by default in git-show, so I don't
>> see why we would want to show root commit diff in git-show by default:
>> those two are very similar.
> 
> $ git init-db
> $ date > file1
> $ git add file1; git commit -a -m "file1 added"
> $ date > file2
> $ git add file2; git commit -a -m "file2 added"
> $ git show --stat HEAD
> $ git show --stat HEAD^
> 
> I can understand while people get confused.  Two patches, both add a file.  
> git-show on one of them shows a stat; on the other it doesn't.

Well, perhaps "git show --stat" should show diffstat also for root
commit, because it shows diffstat for merges (although not patch),
but not patch (which usually is huge).
-- 
Jakub Narebski
