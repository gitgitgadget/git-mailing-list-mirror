X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 11:02:15 +0000
Message-ID: <200612011102.17079.andyparkins@gmail.com>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200612011029.28059.andyparkins@gmail.com> <20061201104256.GQ12463MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 11:02:51 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pFgpvuRbThzngc5OAz675lSqS+ZvS8DDqtWTyAoI4+DM6u14P3S2JrudUnuWBAYEHhP2FesLAhUyhXiWAF0bXcb2d5k78qIjCVSj0KS4qfHSdiKeRcct6IKm5nwivfxQzVAeAGGyaDatKwc8Im4kwp+tm2vgpXMSDhHna/Mwna4=
User-Agent: KMail/1.9.5
In-Reply-To: <20061201104256.GQ12463MdfPADPa@greensroom.kotnet.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32893>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq69x-0001zk-SE for gcvg-git@gmane.org; Fri, 01 Dec
 2006 12:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936397AbWLALCX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 06:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936408AbWLALCX
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 06:02:23 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:6573 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S936397AbWLALCW
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 06:02:22 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2388077uga for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 03:02:20 -0800 (PST)
Received: by 10.67.22.2 with SMTP id z2mr7010084ugi.1164970940457; Fri, 01
 Dec 2006 03:02:20 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id z40sm23837233ugc.2006.12.01.03.02.19; Fri, 01 Dec 2006 03:02:19
 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 2006 December 01 10:42, Sven Verdoolaege wrote:

> He showed it to you in the example.  The "submodule object" is the COMMIT
> of the submodule itself.

That's no different from mine.  I need more detail than that.

Is that commit in the submodule or the supermodule?  If it's in the submodule 
then we're talking about the same thing, as that's all I want.  If it's in 
the supermodule then I want to know what the tree object that that commit 
points to contains.  I also want to know how we tell the difference between a 
commit-in-supermodule and a 
commit-in-supermodule-which-is-actually-in-submodule.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
