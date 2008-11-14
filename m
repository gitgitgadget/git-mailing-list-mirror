From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 00/11] gitweb: display remote heads
Date: Fri, 14 Nov 2008 15:33:14 +0100
Message-ID: <200811141533.15427.jnareb@gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 15:34:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0zkx-0001Wc-Km
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 15:34:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752925AbYKNOd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 09:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752856AbYKNOdY
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 09:33:24 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:47906 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665AbYKNOdX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 09:33:23 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1658358ugf.37
        for <git@vger.kernel.org>; Fri, 14 Nov 2008 06:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=j23wImlF8ooxQDTswHDqjiyxPGnv+mHhbcAJ/VjtHyU=;
        b=r/KuVevfwCUyDwk3CIyXyYResHI2NhwrborZHBcOBsqWp/sXs6GKmqUIhGiUJzzr/C
         ym6+jnJmM6SXB7+ExdZjm1HMyPY6GU70Rvqcm2j1dvAK2SQFHhnHbns3fmUNN3l+bivm
         LQi4edZmXet3qZK9/reyXbVgjoSURA0eSTr/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=OXU1JF6TnmVUhLnBNPwnLkCJJT9e9pPBkx28WyMzmO40H2s562185/AJty++8+ntno
         V/b63F7HasRDcXCODycpba2hu+eCvIR4cc/e2ZxXd9DMi+IUUwP+gEkyuibXOJT1BZ/m
         jSH/56glh/Lla1cLuQ/CUPvKTQH+3XXHyVuao=
Received: by 10.210.10.8 with SMTP id 8mr1119280ebj.69.1226673201389;
        Fri, 14 Nov 2008 06:33:21 -0800 (PST)
Received: from ?192.168.1.11? (abwt29.neoplus.adsl.tpnet.pl [83.8.243.29])
        by mx.google.com with ESMTPS id 3sm945603eyi.5.2008.11.14.06.33.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 Nov 2008 06:33:19 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100978>

On Thu, 13 Nov 2008, Giuseppe Bilotta wrote:

> This is a patchset I presented about a year ago or so, but after a lively
> discussion it dropped into silence. I'm now presenting it again, with minor
> cleanups and adjustements.

That is very nice of you to resend this series. If you could provide
link to earlier discussion of this series...
 
> Giuseppe Bilotta (11):
>   gitweb: introduce remote_heads feature
>   gitweb: git_get_heads_list accepts an optional list of refs.
>   gitweb: separate heads and remotes list in summary view
>   gitweb: optional custom name for refs in git_heads_body
>   gitweb: git_split_heads_body function.
>   gitweb: use CSS to style split head lists.
>   gitweb: add 'remotes' action
>   gitweb: display HEAD in heads list when detached
>   gitweb: git_is_head_detached() function
>   gitweb: add HEAD to list of shortlog refs if detached
>   gitweb: CSS style and refs mark for detached HEAD

I'll try to review individual patches, but I haven't examined them
yet, so perhaps there is a reason why there are so many patches in
this series?


Note that on GMane NNTP (news) interface I can see only two last
patches. Could anyone not CC-ed confirm or deny if this is VGER
anti-SPAM filter at work, or some GMane archive hiccup?

-- 
Jakub Narebski
Poland
