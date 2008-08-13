From: "srinivas naga vutukuri" <srinivas.vutukuri@gmail.com>
Subject: Re: Local uncommitted changes, not checked in to index with gitk
Date: Wed, 13 Aug 2008 18:23:41 +0530
Message-ID: <ace3f33d0808130553g318ce97gf654c3f998d4047a@mail.gmail.com>
References: <ace3f33d0808130207w109e834bxa12b3e96ce3ec096@mail.gmail.com>
	 <vpqljz1cfkm.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Matthieu Moy" <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Aug 13 14:54:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTFsE-0002xl-F8
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 14:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616AbYHMMxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 08:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752758AbYHMMxn
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 08:53:43 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:29873 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbYHMMxl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 08:53:41 -0400
Received: by wf-out-1314.google.com with SMTP id 27so5503345wfd.4
        for <git@vger.kernel.org>; Wed, 13 Aug 2008 05:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3gC1HfJkMSUcyb3idz7YhEaAXNStKbKcDb/izeU/188=;
        b=mASX/v88VrYkAArjG/XqJ/r8IRpEHks9Ixayiqt4g+zL4fhnbv0eNpZRS4QHP54OJn
         FfzTONUbETN22i7grgcc5tKzTM5OkGCP+h6jOIGG23Gn4x6X/6jsOyy8RXq6nWzPAUpe
         YmxSmxmdoLWI92ozq5+q16eFxW9xP5LY4I07I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=vD1Vtrl6XOSoDVOGhH/xoGHACXlubUn76jg5l/HcK+MExFzBnpetGS/8kVQR/pMgXX
         55qAmQ2hO0EbVPFXYUF6NOyVlC0vaNj5O+64+BGNVpZHy9FckGZdwQrYibHhHgYiC9NP
         w7xb4UXNaYbl9bb3uNMqah07sRaCcewM9+goE=
Received: by 10.142.80.7 with SMTP id d7mr2609751wfb.173.1218632021013;
        Wed, 13 Aug 2008 05:53:41 -0700 (PDT)
Received: by 10.142.134.7 with HTTP; Wed, 13 Aug 2008 05:53:40 -0700 (PDT)
In-Reply-To: <vpqljz1cfkm.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92214>

Actually am doing around the 2.6 linux kernel git, and once cloned
using rsync url
and then done couple of times the git pull, to sync to the latest to the remote.

I just done "git status", Its giving the following output. But i
have't done around these files anything at all, not opened, etc.

-------------
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   include/linux/netfilter/xt_connmark.h
#       modified:   include/linux/netfilter/xt_dscp.h
#       modified:   include/linux/netfilter/xt_mark.h
#       modified:   include/linux/netfilter/xt_rateest.h
#       modified:   include/linux/netfilter/xt_tcpmss.h
#       modified:   include/linux/netfilter_ipv4/ipt_connmark.h
#       modified:   include/linux/netfilter_ipv4/ipt_dscp.h
#       modified:   include/linux/netfilter_ipv4/ipt_ecn.h
#       modified:   include/linux/netfilter_ipv4/ipt_mark.h
#       modified:   include/linux/netfilter_ipv4/ipt_tcpmss.h
#       modified:   include/linux/netfilter_ipv4/ipt_tos.h
#       modified:   include/linux/netfilter_ipv4/ipt_ttl.h
#       modified:   include/linux/netfilter_ipv6/ip6t_hl.h
#       modified:   include/linux/netfilter_ipv6/ip6t_mark.h
#       modified:   net/ipv4/netfilter/ipt_ecn.c
#       modified:   net/ipv4/netfilter/ipt_ttl.c
#       modified:   net/ipv6/netfilter/ip6t_hl.c
#       modified:   net/netfilter/xt_connmark.c
#       modified:   net/netfilter/xt_dscp.c
#       modified:   net/netfilter/xt_mark.c
#       modified:   net/netfilter/xt_rateest.c
#       modified:   net/netfilter/xt_tcpmss.c
#
no changes added to commit (use "git add" and/or "git commit -a")
---------------

-srinivas.


On Wed, Aug 13, 2008 at 5:06 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> "srinivas naga vutukuri" <srinivas.vutukuri@gmail.com> writes:
>
>> just cloning any git repository, next time onwards after pulling
>> changes, the gitk is showing
>> at the top "Local uncommitted changes, not checked in to index". Why
>> it is happening.
>
> What do "git status" and "git diff" say?
>
> --
> Matthieu
>
