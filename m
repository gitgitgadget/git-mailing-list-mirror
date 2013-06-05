From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: SNI (SSL virtual hosts)
Date: Wed, 5 Jun 2013 08:58:07 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1306050851210.4783@tvnag.unkk.fr>
References: <DC851F5EA18E478DACB62178624BF5B7@gmail.com> <97F8F367D27D4B3E93439FF8D0F121FA@gmail.com> <alpine.DEB.2.00.1306041142200.16303@tvnag.unkk.fr> <8B7A2C3A8CC346D6B34D153F591F878F@gmail.com> <alpine.DEB.2.00.1306041349290.32021@tvnag.unkk.fr>
 <CEC3E2C7A86A477DAC658432461A60BC@gmail.com> <alpine.DEB.2.00.1306042305300.2878@tvnag.unkk.fr> <630928524B6441DC907D7AFF34389010@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1129329158-242410352-1370415487=:4783"
Cc: git@vger.kernel.org
To: Janusz Harkot <janusz.harkot@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 05 08:58:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uk7fk-0001uj-IC
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 08:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412Ab3FEG6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 02:58:11 -0400
Received: from giant.haxx.se ([80.67.6.50]:50391 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752015Ab3FEG6L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 02:58:11 -0400
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id r556w7Gb014897
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 5 Jun 2013 08:58:07 +0200
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id r556w79r014894;
	Wed, 5 Jun 2013 08:58:07 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <630928524B6441DC907D7AFF34389010@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226434>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1129329158-242410352-1370415487=:4783
Content-Type: TEXT/PLAIN; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 4 Jun 2013, Janusz Harkot wrote:

> valid point, but from what you can find on the web, the only solution 
> provided everywhere was to disable certificate checking… so maybe that's not 
> me, but this is first time someone spent some time to check whats going on 
> :)

I don't disagree with that. You may be right.

But I am the maintainer of libcurl and I have *never* gotten a report about 
this before, and I rather base my actions and assumptions on true reports from 
actual developers with whom I can discuss and delve into details with (like 
you and me right now). Basing decisions on vague statements posted elsewhere 
by unknown people is for sure a road into sadness.

Anyway, now I'm off topic. I'm glad you could fix the problem. Thanks for 
flying git + libcurl! =)

-- 

  / daniel.haxx.se
--1129329158-242410352-1370415487=:4783--
