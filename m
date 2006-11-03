X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 3/4] Default to displaying /all/ non-tag refs, not just locals
Date: Fri, 3 Nov 2006 09:47:20 +0100
Message-ID: <200611030847.22252.andyparkins@gmail.com>
References: <bec6ab7849e3fcacac23cca44a0ba93282af5fca.1162465753.git.andyparkins@gmail.com> <200611021111.22604.andyparkins@gmail.com> <7vac39mew2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 3 Nov 2006 08:47:42 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QG0hw/klF8KjMdRUm2lIwl+ewfky6vnWls5OztEzAissnfHFZgKrcoud3p7PhgS/eTi5Xwm028C/0ECM0gT3hsWyMoSrgja+eHjfLvqEVhnfZtJGwb1FlyaUzLK3Xa1ftf2S/SUdJ9ql8t/XYvMhrdGLB07bCM5g3Av8T0y0Ky8=
User-Agent: KMail/1.9.5
In-Reply-To: <7vac39mew2.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30798>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfui2-0004HP-Rd for gcvg-git@gmane.org; Fri, 03 Nov
 2006 09:47:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752153AbWKCIr1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 03:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752332AbWKCIr1
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 03:47:27 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:62958 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1752153AbWKCIr0
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 03:47:26 -0500
Received: by ug-out-1314.google.com with SMTP id m3so351386ugc for
 <git@vger.kernel.org>; Fri, 03 Nov 2006 00:47:25 -0800 (PST)
Received: by 10.66.216.20 with SMTP id o20mr2280195ugg.1162543645337; Fri, 03
 Nov 2006 00:47:25 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 30sm612792ugf.2006.11.03.00.47.25; Fri, 03 Nov 2006 00:47:25 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 2006 November 03 02:40, Junio C Hamano wrote:

> That is a change in behaviour and given that we introduced
> remotes for the explicit purpose of not to clutter the local
> branch namespace, I doubt defaulting to _show_ remotes is a good

Really?  I had imagined it was to prevent accidental checking out of an 
upstream-tracking branch.  Also; I don't think "not cluttering the namespace" 
is the same as "not showing multiple namespaces".  The local namespace 
remains as uncluttered as it ever was.  This is a question of what to 
display.

Assuming my "mixed mode" display thing were in place, doesn't that make the 
two choices of UI

1)
 git-branch            : show local branches
 git-branch --all      : show local and remote branches
 git-branch -r         : show remote branches
2)
 git-branch            : show local and remote branches
 git-branch --local    : show local branches
 git-branch -r         : show remote branches

In case 2) the switch is simply selecting a filter, and so fits in with 
the "-r" better.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
