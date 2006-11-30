X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Getting CVS and Git to play nicely in the same box
Date: Thu, 30 Nov 2006 15:16:21 +0100
Message-ID: <200611301516.22382.jnareb@gmail.com>
References: <1164890354.21950.92.camel@okra.transitives.com> <ekml1n$ask$1@sea.gmane.org> <1164894847.21950.98.camel@okra.transitives.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 14:15:44 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=iIQozga47EGUQY9jg6i5K0SgiD7+s9IOMz48BWjH4RRuR7Sx/TlYoH6piwTrM+manQ3b+BQYAjPz5Po15qo4EapbIqx5GzT/tRbRPwP9pNy5Sa7c9hjyA5QjjNEV5R5ZbC9+lCU8HGMx7siNuCFrdj2hFKCAu4zAeRZLNdIf3Mg=
User-Agent: KMail/1.9.3
In-Reply-To: <1164894847.21950.98.camel@okra.transitives.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32747>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpmgT-0007xP-5j for gcvg-git@gmane.org; Thu, 30 Nov
 2006 15:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967259AbWK3OOf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 09:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936423AbWK3OOf
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 09:14:35 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:50088 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S936421AbWK3OOf
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 09:14:35 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2122434uga for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 06:14:33 -0800 (PST)
Received: by 10.67.97.7 with SMTP id z7mr5425988ugl.1164896073212; Thu, 30
 Nov 2006 06:14:33 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id 32sm23692536ugf.2006.11.30.06.14.32; Thu, 30 Nov
 2006 06:14:32 -0800 (PST)
To: kernel-hacker@bennee.com
Sender: git-owner@vger.kernel.org

Alex Bennee wrote:
> On Thu, 2006-11-30 at 14:08 +0100, Jakub Narebski wrote:
>> Alex Bennee wrote:
>> 
>>> Has anyone successfully set up such a working environment? Can anyone
>>> offer any tips on how to make it all work nicely?
>> 
>> Why not use git-cvsserver? Or port git-svn to CVS (or use Tailor)?
> 
> I can't use git-cvsserver because the main repository is going to have
> to stay on CVS for the time being. I don't think it could be used as a
> drop in replacement for our existing server anyway as it doesn't support
> tagging or branching.
> 
> Using git is my own personal indulgence (At least until I can
> demonstrate it's worth while the other migrating ;-).

Perhaps if not git-cvsserver, then git-cvsimport (or parsecvs, or cvs2git)
and git-exportcommit would be what you want.

> It looks like git-svn  is the sort of tool I'd want for CVS although I'm
> not sure how it would live with our CVS branched development model. I'll
> have a poke around Tailor and see if that offers any help.

Well, Tailor used to work only with linear histories. But it is meant to
maintain parallel repositories in different formats.
-- 
Jakub Narebski
