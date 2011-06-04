From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] Clarified how "git submodule add" handles relative paths.
Date: Fri, 03 Jun 2011 22:23:32 -0400
Message-ID: <4DE99724.9090607@gmail.com>
References: <7vaae2ihe1.fsf@alter.siamese.dyndns.org> <1306943792-1825-1-git-send-email-marcnarc@xiplink.com> <7vsjrth4iy.fsf@alter.siamese.dyndns.org> <4DE69945.1080601@web.de> <7v39jsdulf.fsf@alter.siamese.dyndns.org> <4DE93B29.4030401@web.de> <7vhb86a4kt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 04 04:23:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSgWq-0005vz-Iv
	for gcvg-git-2@lo.gmane.org; Sat, 04 Jun 2011 04:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755713Ab1FDCXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 22:23:37 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:36267 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247Ab1FDCXh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 22:23:37 -0400
Received: by vxi39 with SMTP id 39so1773790vxi.19
        for <git@vger.kernel.org>; Fri, 03 Jun 2011 19:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=7gzGx4xWYsQZvwsPU5wAhvgkzKCYSSg42mxRRwHSwGI=;
        b=t2fC146zdzyZBeQInHWWDzAjyMGR1jRp/B/a1h5LVpJ82C11Gjx2mLcv3yLgTQRrSq
         KuT7QwywPcI8IGoeogr7UF/tx5oLCELWIv1Qg1TmzfPNPjwhfgmEu+0RQGONqmc4zj6U
         zOiSciWErtv3+7cl8lCc/FEia5PZMgXBkfpj8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=hbp5wda74KcGWYk2CjlgYhWzTrzX5ftNGZGZsULyKykT9Jacv8faAV44zaSt96F8yx
         WrWLZwX65S/ocwKAJsGDa5H3hS6OhRQRTQJJRLsJIzNyYXlPZ8hIKWrj0fr/LTBFsfXb
         RE7Awrd5wkJRSA6DsFK2sJ+U4aoR+fT7EqKMQ=
Received: by 10.52.73.3 with SMTP id h3mr3477283vdv.106.1307154216158;
        Fri, 03 Jun 2011 19:23:36 -0700 (PDT)
Received: from mark-laptop.lan (pool-173-79-111-180.washdc.fios.verizon.net [173.79.111.180])
        by mx.google.com with ESMTPS id da4sm578045vdb.21.2011.06.03.19.23.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Jun 2011 19:23:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <7vhb86a4kt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175055>

On 06/03/2011 07:16 PM, Junio C Hamano wrote:
> Jens Lehmann<Jens.Lehmann@web.de>  writes:
> The "how about this" patch you are voting against (I am neutral by the
> way) is a response to your earlier "I have three use cases and the current
> implementation is forgetting the third", which in turn was a response to
> my "your third use case does not count, so the updated wording of the
> documentation is wrong---it should say 'do not', not 'cannot'".
>
> So what should the updated document say?
>
If I understand this correctly, the third use case isn't actually 
unique: if the upstream repo is on a local file system, why not just use 
a file://... url for the super project's origin?

Mark
