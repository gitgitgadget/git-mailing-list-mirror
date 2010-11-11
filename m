From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 0/3] Teach fetch and pull to recursively fetch
 submodules
Date: Wed, 10 Nov 2010 18:05:38 -0600
Message-ID: <20101111000538.GB14189@burratino>
References: <4CDB3063.5010801@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Kevin Ballard <kevin@sb.org>,
	Jon Seymour <jon.seymour@gmail.com>,
	Chris Packham <judge.packham@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Nov 11 01:06:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGKg3-0006cg-SY
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 01:06:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095Ab0KKAGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 19:06:01 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38349 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757425Ab0KKAGA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 19:06:00 -0500
Received: by qwi4 with SMTP id 4so1048671qwi.19
        for <git@vger.kernel.org>; Wed, 10 Nov 2010 16:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=8q+uBY6Z5eoPjGkd2/OD6+VjfTOxA5B/xOhKcgETgcU=;
        b=f0Pxoc24+s2yCFGz2klddpSklj3ExTRYyLe9si5FbuAX1qWgdEsUFKf3Y74HWcgQq4
         m83lKRiMs0N3JYb4zXjbzzhDZZS+UnFvhXErUrorKE04GHPshkMoe9RmHWasktT/AEvw
         9XFfE+PQD7Xvvxmr+NXpvsUUUTxGFgJh5enEI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kBcXL5TDrgNc8zFZEYEK8oRAP2JIIJeLzyFA1A0VvVg9AE6bfkLHKuacvEUpU+h0lR
         FLXjIVNmhwnOSfZxs1n2qUI0x4LoNFfCfC5mYzFksc+rYGOq3ZOGaQWZnMSvH4v/zd0f
         ecW5xBjbAtVW/fRaliMIPT+59Cl5IL6z3KtoY=
Received: by 10.229.228.76 with SMTP id jd12mr110494qcb.291.1289433959931;
        Wed, 10 Nov 2010 16:05:59 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id s28sm1229608qcp.21.2010.11.10.16.05.57
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 10 Nov 2010 16:05:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CDB3063.5010801@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161198>

Jens Lehmann wrote:

> * Should the "--submodule-prefix" option - which is only used internally
>   now - be a hidden option to "git fetch"?

Yes.  (Any option that is useless outside scripts should be, imho.)

> But nonetheless I think this patch series is ok for inclusion as it does
> not change default behavior and gives people the opportunity to play with
> recursive fetch/pull by enabling one of the introduced config options.

Except for the .gitmodules detail I mentioned, it looks good to me.
Looking forward to trying it out.

Thanks,
Jonathan
