X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Wed, 29 Nov 2006 21:24:16 -0800
Message-ID: <m21wnlo6bj.fsf@ziti.fhcrc.org>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home>
	<7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net>
	<87bqmswm1e.wl%cworth@cworth.org>
	<7vodqse90q.fsf@assigned-by-dhcp.cox.net>
	<87ac2cwha4.wl%cworth@cworth.org>
	<7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net>
	<878xhwwdyj.wl%cworth@cworth.org>
	<7vk61gcnzl.fsf@assigned-by-dhcp.cox.net>
	<7vd5786opj.fsf@assigned-by-dhcp.cox.net>
	<871wnnwi3k.wl%cworth@cworth.org>
	<7virgzuf38.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611282322320.9647@xanadu.home>
	<7vr6vmsnly.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611291234350.9647@xanadu.home>
	<7vzmaaozi8.fsf@assigned-by-dhcp.cox.net>
	<456DDADC.7030509@midwinter.com>
	<Pine.LNX.4.63.0611292059480.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vlkluoulf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 30 Nov 2006 05:24:17 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=k/IyKgpEagzjNgZkRQUvU8B9ZHJ86znnaXqL+tp2R2R7ud4BSTG0FJaAz0KhcJeC7lhgZ5ZYfBMrF+re53gJ9kHDTUniVe+Tm8lN8+yWy3mYJkRT9pkY+Rr3Kjqr8ggFc154JmH3ytwsIFhd6Lr3rRdbi9Mi1XQjh7qq2OjrlgY=
In-Reply-To: <7vlkluoulf.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Wed, 29 Nov 2006 12:39:56 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32703>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpeP6-0003kT-1g for gcvg-git@gmane.org; Thu, 30 Nov
 2006 06:24:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936187AbWK3FYH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 00:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936188AbWK3FYH
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 00:24:07 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:17481 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S936187AbWK3FYE
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 00:24:04 -0500
Received: by nf-out-0910.google.com with SMTP id o25so3132408nfa for
 <git@vger.kernel.org>; Wed, 29 Nov 2006 21:24:03 -0800 (PST)
Received: by 10.48.4.17 with SMTP id 17mr7295013nfd.1164864243189; Wed, 29
 Nov 2006 21:24:03 -0800 (PST)
Received: from ziti.fhcrc.org ( [67.171.24.140]) by mx.google.com with ESMTP
 id r33sm10701474nfc.2006.11.29.21.24.02; Wed, 29 Nov 2006 21:24:03 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:
> My time is better spent on _listening_ to people who might want to
> make convincing arguments to influence what I will end up deciding
> (the final decision will be mine anyway).

So I will add my $0.02:

  Summary: leave git-commit as-is

  I think the intimidation factor of the index is overstated.  A
  scratch working area is a natural concept -- that's what people do
  who don't even _know_ what an scm is.  I agree with Junio's
  description of commit -a as default breaking the mental model.

  I've played with three distributed scm: tla, hg, and git.  I've
  stuck with git because, in part, it helped me to learn its more
  advanced features -- not because it was easiest to use intially out
  of the box.  And if I'm not going to get something more than cvs or
  svn gives me, what's the point of switching in the first place?


  + seth
  
  

