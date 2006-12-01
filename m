X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 12:20:42 +0000
Message-ID: <200612011220.43813.andyparkins@gmail.com>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200612011029.28059.andyparkins@gmail.com> <20061201113103.GM18810@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 12:21:01 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZTuHd88ZY87cjfflTErXJNWnRjAeGWmLZ8a8AN1+Ix6uYr2RHtynN8z7+KE0g5FU3cXrLNRfPtC9zf0z4EsVY+ZS3CATMb8W/FGVma9jQjf0H6KpHJmlGOgn4Uu3y/xAb2seWVacmKyl20CU+FcsW3H9jbjQYO0xG2HOVQhtaRY=
User-Agent: KMail/1.9.5
In-Reply-To: <20061201113103.GM18810@admingilde.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32911>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq7Nt-0004iS-QU for gcvg-git@gmane.org; Fri, 01 Dec
 2006 13:20:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967498AbWLAMUu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 07:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967576AbWLAMUu
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 07:20:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:26671 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S967498AbWLAMUu
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 07:20:50 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2405518uga for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 04:20:49 -0800 (PST)
Received: by 10.66.255.7 with SMTP id c7mr7158644ugi.1164975648749; Fri, 01
 Dec 2006 04:20:48 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 59sm25444876ugf.2006.12.01.04.20.47; Fri, 01 Dec 2006 04:20:47 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 2006 December 01 11:31, Martin Waitz wrote:

> It really only stores the commit of the submodule directly.
> So there is no new submodule object type.  The parent has a direct link
> to the submodule commit in his tree object and in its index.  In order
> to separate them from normal files or normal subdirectories, they get a
> special mode: they are represented as socket.

Okay.  I think I've got it now.  I'm not convinced that the way you've chosen 
is the correct way, primarily because the separation between supermodule and 
submodule is not strong.  Regardless, as you're doing it, you get to pick :-) 
Is there a public repository I can look at to see what you've done?  I'm 
interested in the sort of plumbing changes needed to make something like this 
work.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
