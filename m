From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSoC idea: adding JavaScript library / framework in gitweb
Date: Fri, 30 Mar 2012 13:56:13 +0100
Message-ID: <201203301456.13965.jnareb@gmail.com>
References: <CACeyogcFJoUyAiTReDJK_nCMGBp+23OjcS407A1X=fqFR+aGag@mail.gmail.com> <201203291114.15284.jnareb@gmail.com> <CACeyogeh7SSfx5NPFSt=gDdUzrUj0zxQKh84MDA-dW2e7UNGcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: chaitanyaa nalla <nallachaitu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 14:56:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDbNT-0007Em-Rg
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 14:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760796Ab2C3M4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 08:56:23 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:44568 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760011Ab2C3M4W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 08:56:22 -0400
Received: by wejx9 with SMTP id x9so345625wej.19
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 05:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=OqiH7hs7Gmf8xQuyY6dnnazZTxR62Y40UCp/WS0Pf9g=;
        b=WEi92i58WrXOqgtLUh2O4PM5eT4j63FoE7IweVD8qyPC3xUo0c3SIj9EVOFNUzktw8
         X71ks/ZlVp9VovAVs9xPFWI8n3EwB7fwLRsdGtPhbGiMtoRenaw64tvXK6LOzsullI9X
         ZUjACQxqpPRJh1RKv5H2ZwwVeS44sbrSARmhN14Fb/BepO9bGdKUS5vU9vOBG0yxrSWA
         miDR2Fm7inWObVluTSBSEP8COryOv8WO2TLhRLit4iR5RtT5Gt1pynaMUTf+6f1B/2A2
         q5UMtx4e8mFeqjnh1Z3ORL6/y8q2sxUDIRYXCJK+Bj7cQg12zdcoCXrgwjg87QrdmLPI
         7GNA==
Received: by 10.180.91.165 with SMTP id cf5mr6330042wib.2.1333112181040;
        Fri, 30 Mar 2012 05:56:21 -0700 (PDT)
Received: from [192.168.1.13] (aeh224.neoplus.adsl.tpnet.pl. [83.25.111.224])
        by mx.google.com with ESMTPS id k6sm6136838wiy.7.2012.03.30.05.56.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Mar 2012 05:56:20 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <CACeyogeh7SSfx5NPFSt=gDdUzrUj0zxQKh84MDA-dW2e7UNGcw@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194356>

On Thu, 29 Mar 2012, chaitanyaa nalla wrote:
> Jakub Narebski wrote:

> > Another source of inspiration for JavaScript usage in gitweb might
> > be git-browser project.  Just FYI.
> 
> Dear Jakub,
> 
> please tell me more about this idea , it is interesting :)


git-browser is an experimental gitk-like web interface which was developed
in December 2005 by Artem Khodush <greenkaa@gmail.com> and then largely
forgotten and abandoned.  User interface is done in JavaScript, and is
rather heavy on the client side.  Server-side scripting is done in Perl
(and uses gitweb IIRC).

  https://git.wiki.kernel.org/articles/i/n/t/Interfaces,_frontends,_and_tools.html#git-browser
  http://repo.or.cz/gitweb.cgi/git-browser.git

I don't think there is existing demo deployment remaining...

-- 
Jakub Narebski
Poland
