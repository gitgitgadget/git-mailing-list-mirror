From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Why Git is so fast
Date: Thu, 30 Apr 2009 17:28:04 +0200
Message-ID: <200904301728.06989.jnareb@gmail.com>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com> <m3fxfqnxn5.fsf_-_@localhost.localdomain> <b4087cc50904300556s359c91dfu444fa40ea85bd66e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 17:28:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzYBS-0005VH-IA
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 17:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761492AbZD3P2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 11:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758345AbZD3P2N
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 11:28:13 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:61515 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756559AbZD3P2M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 11:28:12 -0400
Received: by ewy24 with SMTP id 24so1974925ewy.37
        for <git@vger.kernel.org>; Thu, 30 Apr 2009 08:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Z7tpp64XUtZba96OVatYlUBl3ysIgQjbKpEUecg4ZUY=;
        b=IhjBZMrrQJUVh2FoBSonuvC/S5Gx7oAcCCLC7w1hgnwEvmBBCRvI6zqcBPvwL60wh+
         qAzcyUlkaZGZnrSjDhzZ+AGHOhQTAoGcv5Qfr1lkZhvKOD723cw2snQ9MgtsRFRnElWN
         mh4cGUMRwwkiTSOAX6q3fLW6X83WNo3Pi2S4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=kLJfjvuaBONgxrEmyKC6egl+bh66CNt0MwkKtfuIK8MdFdDRpzxiXWkzg4Bi15xkbP
         MYC6NN7z4eabC3Exh8fFw/R5p1TcSh4/+pSZ5ALqpe/8GW3wHQOsuAVrkD4/9yjQ6P63
         TyPNgTmDwfh9R3PE0gWyDziBtat8yNUxBUvGQ=
Received: by 10.216.19.212 with SMTP id n62mr540739wen.66.1241105291149;
        Thu, 30 Apr 2009 08:28:11 -0700 (PDT)
Received: from ?192.168.1.13? (abwf75.neoplus.adsl.tpnet.pl [83.8.229.75])
        by mx.google.com with ESMTPS id j8sm5949394gvb.11.2009.04.30.08.28.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Apr 2009 08:28:10 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <b4087cc50904300556s359c91dfu444fa40ea85bd66e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118025>

On Thu, 30 Apr 2009, Michael Witten wrote:
> On Thu, Apr 30, 2009 at 07:17, Jakub Narebski <jnareb@gmail.com> wrote:

> > I hope that JGit developers can
> > tell us whether using higher level language affects performance, how
> > much, and what features of higher-level language are causing decrease
> > in performance.
> 
> Java is definitely higher than C, but you can do some pretty low-level
> operations on bits and bytes and the like, not to mention the presence
> of a JIT.
> 
> My point: I don't think that Java can tell us anything special in this regard.

Let's rephrase question a bit then: what low-level operation were needed
for good performance in JGit? 

-- 
Jakub Narebski
Poland
