X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 10:19:39 +0000
Message-ID: <200612011019.40548.andyparkins@gmail.com>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200612010001.57111.andyparkins@gmail.com> <20061201093244.GP12463MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 10:20:31 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=idTED1Ut9plXUZMiPGtJO9UlYdN1rThhX+EKk6VLIfnfKLYgtdVKOhySx+ShMh6HIto+8Hys76er40a4RHAlG/FTcJeqA1QQ6aIGVIKhRa+nNgfKtx26LC4IBhfBX9iVKrrsxF/5SAUe8x+r+BG4x9yKc4fax21Mb6jkLhHmkNs=
User-Agent: KMail/1.9.5
In-Reply-To: <20061201093244.GP12463MdfPADPa@greensroom.kotnet.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32884>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq5Uq-0000vb-RE for gcvg-git@gmane.org; Fri, 01 Dec
 2006 11:19:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936116AbWLAKTq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 05:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936120AbWLAKTq
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 05:19:46 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:14304 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S936116AbWLAKTp
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 05:19:45 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2378704uga for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 02:19:44 -0800 (PST)
Received: by 10.67.97.18 with SMTP id z18mr6898658ugl.1164968384051; Fri, 01
 Dec 2006 02:19:44 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 32sm25169002ugf.2006.12.01.02.19.43; Fri, 01 Dec 2006 02:19:43 -0800
 (PST)
To: git@vger.kernel.org, skimo@liacs.nl
Sender: git-owner@vger.kernel.org

On Friday 2006 December 01 09:32, Sven Verdoolaege wrote:

> This is heresy.  Any object referenced in a tree should be in the repo
> (possibly via alternates).

The "submodule" object would be in the local repository.  That would refer to 
another object, and is merely part of the submodule object.  Just as  
the "Author" and "Commiter" fields are part of the commit object but aren't 
actual objects in the tree.

Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
