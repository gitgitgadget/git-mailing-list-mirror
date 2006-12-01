X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 19:17:17 +0000
Message-ID: <200612011917.19252.andyparkins@gmail.com>
References: <20061130170625.GH18810@admingilde.org> <20061201165418.GD18810@admingilde.org> <45706758.2020907@b-i-t.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 19:21:13 +0000 (UTC)
Cc: Martin Waitz <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QmAepyRDUa/ahnMLxmj7Ehiqvdf1kwu0Dx8UR6piukn1ZLqgjLt9YnddpNcEHM0Rqk4gnXGHhsHxLbrKvJqwBGynk+ychyJishRkS8iiGMufn6fgzbxsPUO/I60xr2IKPASWO0gkqBxV55Gddtws/psYfPcI+APf7DmHn85xHN8=
User-Agent: KMail/1.9.5
In-Reply-To: <45706758.2020907@b-i-t.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32958>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqDw7-0000A9-7I for gcvg-git@gmane.org; Fri, 01 Dec
 2006 20:20:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031745AbWLATUG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 14:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031744AbWLATUG
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 14:20:06 -0500
Received: from wr-out-0506.google.com ([64.233.184.226]:47308 "EHLO
 wr-out-0506.google.com") by vger.kernel.org with ESMTP id S1031746AbWLATUE
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 14:20:04 -0500
Received: by wr-out-0506.google.com with SMTP id i7so1302825wra for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 11:20:03 -0800 (PST)
Received: by 10.78.149.15 with SMTP id w15mr5166899hud.1165000802218; Fri, 01
 Dec 2006 11:20:02 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id 40sm19515186hue.2006.12.01.11.20.01; Fri, 01 Dec
 2006 11:20:01 -0800 (PST)
To: git@vger.kernel.org, sf@b-i-t.de
Sender: git-owner@vger.kernel.org

On Friday 2006, December 01 17:33, Stephan Feder wrote:

> 1. A submodule is stored as a commit id in a tree object.
>
> 2. Every object that is reachable from the submodule's commit are
> reachable from the supermodule's repository.

I'm still not convinced about 2.  Why should any of the submodule commits be 
in the supermodule repository?  I know that is what you've implemented, but 
it still feels like too much of a blending of the submodule into the 
supermodule.

In fact, why should the submodule commits be even visible in the supermodule?  
That tree->submodule commit is sufficient; there isn't any need to view 
submodule history in the supermodule.



Andy

-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
