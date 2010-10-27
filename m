From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] help.c: Pull cmd_version out of this file.
Date: Wed, 27 Oct 2010 10:18:33 -0500
Message-ID: <20101027151832.GA10614@burratino>
References: <2ae543604216146b742253584d8393c5e3179697.1283114573.git.tfransosi@gmail.com>
 <20100830023812.GA4010@burratino>
 <20100830024020.GB4010@burratino>
 <AANLkTimDjRz=JmiVn+ybQ5ewaj=7N5tp48fUArD5vG_H@mail.gmail.com>
 <7v1v9e803a.fsf@alter.siamese.dyndns.org>
 <AANLkTinHJHzcoFFjv-TaQ+DYVyqn46fqA802m8Lq5anp@mail.gmail.com>
 <20100902043500.GF29713@burratino>
 <7vvd6o14zz.fsf@alter.siamese.dyndns.org>
 <AANLkTimX2NhXGdK0vVMaw-Fm6fpg4i5pbOZGA8Cc-+ui@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 17:18:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7m3-0005va-BI
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 17:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933645Ab0J0PSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 11:18:43 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56162 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933540Ab0J0PSl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 11:18:41 -0400
Received: by fxm16 with SMTP id 16so787338fxm.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 08:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ALYb5wvFZGVYLV8dt53XsymJQgRwcQLGSIEWiT1I8io=;
        b=d6nOMhfTtJv9X/uvsSEw9uqPWXpwy20+bI0Peupz1SYJSD7bwc2bVCSYlyzHwEQ0+1
         QwNp9CWggRKn5J01o/D3YXvkmo+SHxDeXdbh9hcMWsMgy57Pauv9A2y9Frnto+UdCWXz
         p+UTnnsSmjqXcfSwUhiJZphOpoqjisiIca+MA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JbnGswiotsf7k+OoWlQ+pjE6CUwWiywJCOOEqStVkjzKe9recTnvUxtFq7bWzLo5JT
         6MUB4kgIroS33q9JjEP5GS5n9VeBkcTe+jyPAxhmngtSQOeSc9shRNlhu2nZAkcRZQp2
         RzULrfzF5PwLd09Gd3j8cdrKHxHrRcHNNl3Ek=
Received: by 10.223.79.2 with SMTP id n2mr2507128fak.133.1288192720545;
        Wed, 27 Oct 2010 08:18:40 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id a25sm4232563fab.37.2010.10.27.08.18.38
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 08:18:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimX2NhXGdK0vVMaw-Fm6fpg4i5pbOZGA8Cc-+ui@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160086>

Thiago Farina wrote:

> What happened to this patch? I can't see it on any branch (master, pu, maint).

I thought there was some discussion about another binary in
/usr/lib/git-core being a bad thing?
