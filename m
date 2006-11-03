X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 2/4] Rename remote_only to display_mode
Date: Fri, 3 Nov 2006 13:00:25 +0100
Message-ID: <200611031200.27275.andyparkins@gmail.com>
References: <bec6ab7849e3fcacac23cca44a0ba93282af5fca.1162465753.git.andyparkins@gmail.com> <200611030841.05888.andyparkins@gmail.com> <454B1F3B.1020603@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 3 Nov 2006 12:01:17 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gVAaKDVsK0Zcxchmx8/XlGjYeUnUQfG387vwspaLcv1qP6zjfJ3H0aZpULZtrk+UJo3yE6se/If245xo9omcg94aIzCspTIMctW4BW9VfU2Se4NmpFcWeNJU4w/miVeqw1uRTKwogPAujLrrL5Rlnulnj2DtZhWn3mPSxIwzXfg=
User-Agent: KMail/1.9.5
In-Reply-To: <454B1F3B.1020603@op5.se>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30833>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfxj0-0006l4-QU for gcvg-git@gmane.org; Fri, 03 Nov
 2006 13:00:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751426AbWKCMAg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 07:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWKCMAg
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 07:00:36 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:55612 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1751426AbWKCMAf
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 07:00:35 -0500
Received: by ug-out-1314.google.com with SMTP id m3so385390ugc for
 <git@vger.kernel.org>; Fri, 03 Nov 2006 04:00:34 -0800 (PST)
Received: by 10.67.117.2 with SMTP id u2mr2522912ugm.1162555230390; Fri, 03
 Nov 2006 04:00:30 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id x26sm758506ugc.2006.11.03.04.00.29; Fri, 03 Nov 2006 04:00:30 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 2006 November 03 10:51, Andreas Ericsson wrote:

> If you *need* to change something, change it. If you *want* to change
> something just because it's not written the way you would write it, back
> away. If you think some interface you're using needs clearing up
> (codewise or with extra comments), send a separate patch for that so the
> actual feature/bugfix you're sending in doesn't drown in cosmetic
> changes to the interfaces the patch uses/touches.

Thank you for the excellent advice.  What then would you suggest in the case 
in point?  I made as minimal a change as I could make; but that left the code 
a little bit bitty - I had press-ganged a variable into taking on another 
function and was using numeric literals that should really have been given 
meaning with #define?

My question is perhaps different from simply git-etiquette; it's should I 
prefer my patches to be minimal or neat?  If there is a more appropriate way 
of doing something should I do it or should I favour minimalism?

I've actually rewritten it now as per Junio's request, and while I'm happier 
with the code, it was much bigger change, that didn't really lend itself to 
being broken into smaller patches as did my first attempt.

I guess in the end it's a judgement call and the best thing to do is post it 
and see who shoots it down :-)


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
