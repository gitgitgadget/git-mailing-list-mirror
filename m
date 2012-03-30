From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [GSOC] Contributing to git.
Date: Fri, 30 Mar 2012 12:45:58 +0100
Message-ID: <201203301345.59195.jnareb@gmail.com>
References: <CAH-tXsB39OpbmVcD3Fd+tq8UcBsyCf6JBZ-rSyf1VwrQPKLiFQ@mail.gmail.com> <201203301305.23567.jnareb@gmail.com> <CACeyogeboKPEhsaY357+hBvVquW7kn3ygOk11ZSKvXOt4vkzvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, jaseem abid <jaseemabid@gmail.com>,
	git@vger.kernel.org
To: chaitanyaa nalla <nallachaitu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 13:46:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDaHR-0005vE-Gf
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 13:46:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933457Ab2C3LqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 07:46:05 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38264 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab2C3LqC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 07:46:02 -0400
Received: by wibhq7 with SMTP id hq7so518327wib.1
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 04:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=iGD3dshfdxRZOQd4zeSyS3JKSfgxl6EQzG4ofV3YPQs=;
        b=l93+9rg1V+3mQVC6kW88arShOBC7HZssClaU6+P6tERflqHErVFQkWh/cr0eQhY2on
         QKqZIK1IxKQi8XDwlwe5MRFKezWZ+n4RgI3w2jXXl/dMe/6Dw1qMD/6w7f5X54GSrolB
         u6eZ7yzUYwsF0KCdiZaljdMrn69POIpE3S4rGxhX3IDn9WLiMkAx5jJjp/hILLcWXBQP
         B0d5B9MeUS5mPZHSk4PBz4HwNAmoYsuTFLZ/aQOCuCZ1kxN2H65ty+V68EsuqmyWGWwh
         11LnMsPhWIGck3G1YYZGfWPrrT63o+S4zTHvcNnWhS/wGg4sSFt2QC6fDgNZ0RJcUXNf
         kDVw==
Received: by 10.180.100.2 with SMTP id eu2mr5797286wib.1.1333107961381;
        Fri, 30 Mar 2012 04:46:01 -0700 (PDT)
Received: from [192.168.1.13] (aeh224.neoplus.adsl.tpnet.pl. [83.25.111.224])
        by mx.google.com with ESMTPS id w10sm9342049wiy.3.2012.03.30.04.46.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Mar 2012 04:46:00 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <CACeyogeboKPEhsaY357+hBvVquW7kn3ygOk11ZSKvXOt4vkzvQ@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194349>

On Fri, 30 Mar 2012, chaitanyaa nalla wrote:

> There are good Opensource tools like
> TestSwarm (jQuery), JSTestDriver(Google). Both are distributed
> javascript testing tools that supports testing on all major browsers.

We don't need _distributed_ javascript testing tool; we need automated
command-line javascript testing tool which we can integrate into git
testsuite (t/).

* TestSwarm is distributed continuous integration testing tool,
  (not necessary for us), and from what I understand it shows results
  as a web page (in a browser).

  It is written in PHP and uses MySQL.

* jsTestDriver looks like something we could use, as it is run from
  command line, and prints results to standard output.

  It requires however a web browser attached (this is not an obstacle:
  having web browser can be prerequisite for such tests)... and is
  written in Java, and as far as I understand doesn't output TAP.


Documentation/CodingGuidelines says:

 - Avoid introducing a new dependency into git. This means you
   usually should stay away from scripting languages not already
   used in the git core command set [...]

So no PHP, and no Java.

-- 
Jakub Narebski
Poland
