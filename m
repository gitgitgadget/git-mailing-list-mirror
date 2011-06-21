From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] Add a lot of dummy returns to avoid warnings with
 NO_NORETURN
Date: Tue, 21 Jun 2011 00:00:03 -0500
Message-ID: <20110621050003.GB16763@elie>
References: <1308445625-30667-1-git-send-email-andi@firstfloor.org>
 <1308445625-30667-2-git-send-email-andi@firstfloor.org>
 <7vsjr4b3tf.fsf@alter.siamese.dyndns.org>
 <20110620213001.GB32765@one.firstfloor.org>
 <7vfwn4b1vb.fsf@alter.siamese.dyndns.org>
 <20110620220347.GE32765@one.firstfloor.org>
 <20110620223156.GA695@elie>
 <20110620223705.GG32765@one.firstfloor.org>
 <20110620224619.GB695@elie>
 <20110621002448.GB700@alboin.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Kleen <andi@firstfloor.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 07:00:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYt4Y-0000Si-8P
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 07:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658Ab1FUFAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 01:00:15 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59813 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074Ab1FUFAN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 01:00:13 -0400
Received: by qwk3 with SMTP id 3so1105032qwk.19
        for <git@vger.kernel.org>; Mon, 20 Jun 2011 22:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=csc5HEblnmbfy/8G+rFnDhPPzrXeg06Do0L37OPFcgE=;
        b=dQzjETAetTJlaJPSxtTbQk1Rdgy8RIPkCs8gDbkRG1UnBWknP4gf2l/djEXd6ke0Wm
         lph+8YuwlxYQX1qkYSCR+ZoBfz6Ia4yMfVQ4HQMr74a7yhPqjrZY/qnQhg+6m57LwRkL
         Y4q3eOLad3CaEAkkzSyq9e74rK+hMLgymN6ww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=W7U7SxjYgTzAPud4SNBOjmgZJsVbHqofdDUJowDfWUTquI9q7ehagxsNhZp5A0IgeH
         /v9mLRTvfC+4HlkuCLgcF72jIyGj7MbOLe7KYQma5V/m6P5Ay0eVXLZdOZBsjvxYgALh
         4pnArbTnKS3oOHyF+fwTZqM/5+Lw+DfA06Hko=
Received: by 10.224.125.66 with SMTP id x2mr4499597qar.365.1308632413052;
        Mon, 20 Jun 2011 22:00:13 -0700 (PDT)
Received: from elie (adsl-69-209-79-158.dsl.chcgil.ameritech.net [69.209.79.158])
        by mx.google.com with ESMTPS id e5sm101232qck.43.2011.06.20.22.00.11
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Jun 2011 22:00:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110621002448.GB700@alboin.amr.corp.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176121>

Andi Kleen wrote:

> For some optimizations (basic block reordering) you could get
> the same benefit with __builtin_expect.
>
> But based on my own experience with __builtin_expect in other projects
> I strongly recommend to not use it manually:
[...]
> In addition there are various optimizations in gcc where I am not
> aware of a manual annotation possibility (like register allocation). 
> The data from profile feedback is used in quite a lot of places all
> over the compiler.

Thanks.  Alas.
