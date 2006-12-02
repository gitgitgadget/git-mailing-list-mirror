X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 2 Dec 2006 09:27:49 +0000
Message-ID: <200612020927.50787.andyparkins@gmail.com>
References: <20061130170625.GH18810@admingilde.org> <200612020114.42858.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0612011621380.3695@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 2 Dec 2006 09:30:49 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NymfW1+mtxGbYqapKuKGnf6uFoS7dl/zweuedm1Hi8X8lGD4MrP0wNpDoQWsbI8/1xYrf8XLANhfYntkBjN4D2EfIPrfbPS+bjFPAGo7hTy2zG0gc+8M7Va8VLdL/AWL/H2MEFRivL3BLeVD9jFsjfmtR5jtWGiA99R1ZNowl1s=
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0612011621380.3695@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33013>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqRCj-000173-BC for gcvg-git@gmane.org; Sat, 02 Dec
 2006 10:30:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162864AbWLBJah (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 04:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162866AbWLBJah
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 04:30:37 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:15857 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1162864AbWLBJag
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 04:30:36 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2615535uga for
 <git@vger.kernel.org>; Sat, 02 Dec 2006 01:30:34 -0800 (PST)
Received: by 10.78.164.13 with SMTP id m13mr5695254hue.1165051834295; Sat, 02
 Dec 2006 01:30:34 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id 36sm14609680huc.2006.12.02.01.30.33; Sat, 02 Dec
 2006 01:30:33 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Saturday 2006, December 02 00:33, Linus Torvalds wrote:

> Yes, you do need to have a list of submodules somewhere, and you'd need to
> maintain that separately. One of the results of having the submodules be

Why?  You just recursively search for every "link" object in the supermodule.  
That tells you which submodules you need and where they should be.

During a supermodule clone, it can tell the client end to start a new clone 
with the correct path because it knows what the local path is at that moment.



Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
