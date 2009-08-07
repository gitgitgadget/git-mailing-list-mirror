From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v2] Re: mailinfo: allow individual e-mail files as input
Date: Fri, 7 Aug 2009 03:56:28 +0200
Message-ID: <20090807015628.GG12924@vidovic>
References: <COrzR9ThNBy5SQ7chsXyUB30jVGIijxZQ3LI9L_y7Ab5vWcDcy_HolvjjuHTC7DHI9ntV-eR_v0@cipher.nrlssc.navy.mil> <fmF7fF0TYh9QnFuUzmi-Zw9fKRhYn2-S-kCVb2e-d84D87BPqjfwrwFursOoLGkB99qKJmb_oRs@cipher.nrlssc.navy.mil> <20090807015238.GF12924@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>, gitster@pobox.com,
	giuseppe.bilotta@gmail.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Fri Aug 07 03:56:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZEhD-0000O7-G6
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 03:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754933AbZHGB4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 21:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754221AbZHGB4c
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 21:56:32 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:46653 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754217AbZHGB4b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 21:56:31 -0400
Received: by ewy10 with SMTP id 10so1246277ewy.37
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 18:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=ry9xqi9QWBUC2Sr/a0osjwJiwrzYrLbNeG20+F69VuQ=;
        b=kEmVYD9hjhnX0bfL4ukTNjf0Re9DyJDW+guqERMKhpUxVhflH9Lx9UCYGeY7xUaOtB
         CwZKpydNjr36LSVu4VmZUZmLV2/QLagb5eDOFDsoe4Slnicu4bL/ojOl7A14e6g2w6Sk
         rl0wwWZY5Yly94U2QQiuV5oN1wgytc4leiLA8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AYflDEDzChi4FHB6toLkd/KIaEL7GgkqmVU4nsPPY89mAvVkJDpS90JVXGRXqYm4/q
         8aRJ2tb8V8BrSP6AsZZV4OGIFJqHMCSgjLZC6GZW0uDNZd26h8i8Hj1mQosAbpb65T8I
         Zza6C4jfRWslfWjXpsnHnDa5BoW1ho2KKXFKA=
Received: by 10.210.128.17 with SMTP id a17mr264716ebd.19.1249610191261;
        Thu, 06 Aug 2009 18:56:31 -0700 (PDT)
Received: from @ (91-164-149-117.rev.libertysurf.net [91.164.149.117])
        by mx.google.com with ESMTPS id 24sm1400796eyx.33.2009.08.06.18.56.30
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 06 Aug 2009 18:56:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090807015238.GF12924@vidovic>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125159>

The 07/08/09, Nicolas Sebrecht wrote:
> The 06/08/09, Brandon Casey wrote:
> 
> > diff --git a/git-am.sh b/git-am.sh
> > index d64d997..49f2be4 100755
> > --- a/git-am.sh
> > +++ b/git-am.sh
> 
> <...>
> 
> > +			{
> > +				echo "$l1"
> > +				echo "$l2"
> > +				echo "$l3"
> > +				cat
> 
> UUOC, I guess.
> 
> > +			} | sed -n -e '/^$/q' -e '/^[ 	]/d' -e p "$1" |
>                                                    ^^

Owned by the tabulation, sorry.

Do we still need the "$1"?

-- 
Nicolas Sebrecht
