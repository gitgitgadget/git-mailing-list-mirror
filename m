X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] git-fetch: do not use "*" for fetching multiple refs
Date: Thu, 7 Dec 2006 00:38:24 +0100
Message-ID: <200612070038.24920.jnareb@gmail.com>
References: <1165261102.20055.9.camel@ibook.zvpunry.de> <el6sni$re3$1@sea.gmane.org> <Pine.LNX.4.63.0612070020580.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 23:36:23 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PSocfwQgmiFxKaE1WZg8JzvKT+U3z9JgSb8QCRGdioCxks4vHLqrdcn5HlZt8qcSYIOPkRomhQwt2WvxttsyXlckebEhCr9oPcye+v+v7pQmb1yj76+FsROOPiUW+sMOaitLevfin0BhaljmUh+Xpoo3ALC/DQ4noot+1FKl6O8=
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0612070020580.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33537>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs6JJ-0004oz-B9 for gcvg-git@gmane.org; Thu, 07 Dec
 2006 00:36:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937797AbWLFXgS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 18:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937800AbWLFXgS
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 18:36:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:27352 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S937797AbWLFXgR (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 18:36:17 -0500
Received: by ug-out-1314.google.com with SMTP id 44so302672uga for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 15:36:16 -0800 (PST)
Received: by 10.66.242.20 with SMTP id p20mr1803999ugh.1165448176058; Wed, 06
 Dec 2006 15:36:16 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id m1sm30896668ugc.2006.12.06.15.36.15; Wed, 06 Dec
 2006 15:36:15 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:

> On Wed, 6 Dec 2006, Jakub Narebski wrote:
> 
>> Michael Loeffler wrote:
>> 
>>> Am Montag, den 04.12.2006, 20:48 +0100 schrieb Jakub Narebski:
>>> ...
>>>> I'm not sure if regexp support is truly better than the usual path globbing,
>>>> as in fnmatch / glob.
>>>
>>> The current code does not do a real glob, this was the reason for me to
>>> think about regex support, I thought it is easy to use sed for this. Now
>>> I know it better.
>> 
>> We could use perl for that, but embedded perl is a bit horrible.
> 
> Not to talk about portable, and as we saw, dependent on the C compiler 
> (you would have to make git compile with the same C compiler that perl was 
> compiled with).
> 
> So, please look into other options first.

No, not embedded in C, but embedded in shell script.
Use perl -ip instead of sed.

-- 
Jakub Narebski
