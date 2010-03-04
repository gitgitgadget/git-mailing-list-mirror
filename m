From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 1/3] hash-object: support --stdin-paths with
 --no-filters
Date: Thu, 4 Mar 2010 17:35:42 +0300
Message-ID: <20100304143542.GA2313@dpotapov.dyndns.org>
References: <1267647023-2604-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, normalperson@yhbt.net
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Mar 04 15:36:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnC9d-00028r-FF
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 15:35:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579Ab0CDOfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 09:35:52 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:4775 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884Ab0CDOfv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 09:35:51 -0500
Received: by fg-out-1718.google.com with SMTP id l26so755520fgb.1
        for <git@vger.kernel.org>; Thu, 04 Mar 2010 06:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=wYrMk/ob2L4phltXnp4+SONHhAT8iwvcuYeGyT2Y8kQ=;
        b=Ci3CM8EnFv5/hgJ71oz5fN/7DsZCxcfg0qYy3NeZz2FBXA0bE2HwWIk/GXkMfETBpa
         V72/o+Uz5SGJxHJswSgFoqYiju7/PrmDbrnjHHmIFaU5PwY7c5OhPZuT780e0D5Xq8bn
         2CrFQtm7kboDerd3Ye1bzAK3jT5wZ8D3e+VBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gJNcMlRUbxZdqaHE+ZPOtRWZSOyQ0qobN/PDHEQpyAIhomLR1O5jcNk3btuItcJkpG
         BjWRKvirMTGp5jTNkgGp3kEpi6bZQ2bao0ysp8SAQ3R/fLOX+2RmOTwpWUfQ928KpB8J
         prlBpatfNShFIoflwpemgI6YYeCzyjt+KONVg=
Received: by 10.87.20.13 with SMTP id x13mr2752769fgi.67.1267713349753;
        Thu, 04 Mar 2010 06:35:49 -0800 (PST)
Received: from localhost (ppp91-77-227-85.pppoe.mtu-net.ru [91.77.227.85])
        by mx.google.com with ESMTPS id l19sm2968777fgb.6.2010.03.04.06.35.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Mar 2010 06:35:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1267647023-2604-1-git-send-email-kusmabite@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141527>

On Wed, Mar 03, 2010 at 09:10:21PM +0100, Erik Faye-Lund wrote:
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
>  Documentation/git-hash-object.txt |    2 +-
>  builtin-hash-object.c             |    8 ++++----
>  t/t1007-hash-object.sh            |   18 ++++++++++++++----
>  3 files changed, 19 insertions(+), 9 deletions(-)

The patch looks good to me.

Thank you,
Dmitry
