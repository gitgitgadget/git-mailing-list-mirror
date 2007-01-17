From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Wed, 17 Jan 2007 20:25:14 +0100
Message-ID: <200701172025.14870.jnareb@gmail.com>
References: <200701150144.56793.jnareb@gmail.com> <Pine.LNX.4.63.0701162337330.22628@wbgn013.biozentrum.uni-wuerzburg.de> <dbfc82860701171008r65006b60vf81df9f82ab25712@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <junkio@cox.net>,
	"Eric Wong" <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 20:25:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7GOv-0000V3-9y
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 20:24:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663AbXAQTYr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 14:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932659AbXAQTYr
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 14:24:47 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:25566 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932663AbXAQTYq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 14:24:46 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2070676uga
        for <git@vger.kernel.org>; Wed, 17 Jan 2007 11:24:45 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MX41TPMp4w9GI3RrkaHAg6nbooETb8GdMTI8Qz8y9lYB8WDHa+Ze7biz+b7HVSru+Z+1cwrM3+k4t0pcFho2wcXNvg99d5ZCN+RF+Yja4ahKeEcEMu0dZ3RFw2sy1BCoS1yLWDkEuuUG6Dh2hZe3pqLZYYp4QrLlVtwXkTAChYk=
Received: by 10.67.119.9 with SMTP id w9mr10041734ugm.1169061885177;
        Wed, 17 Jan 2007 11:24:45 -0800 (PST)
Received: from host-81-190-20-200.torun.mm.pl ( [81.190.20.200])
        by mx.google.com with ESMTP id 53sm8933152ugd.2007.01.17.11.24.43;
        Wed, 17 Jan 2007 11:24:44 -0800 (PST)
To: "Nikolai Weibull" <now@bitwi.se>
User-Agent: KMail/1.9.3
In-Reply-To: <dbfc82860701171008r65006b60vf81df9f82ab25712@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37028>

Nikolai Weibull wrote:
> On 1/16/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

>> I was not happy when we introduced more relaxed section titles, and I am
>> not happy now that I see what problems we introduced with that.
> 
> I'm with you on this one.

More relaxed section (actually _sub_section) titles are not the problem.
The fact that they are case sensitive (where section and key names
are not) can be.

-- 
Jakub Narebski
Poland
