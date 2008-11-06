From: "Dilip M" <dilipm79@gmail.com>
Subject: Re: Fetch via http and proxy which requires authentication
Date: Thu, 6 Nov 2008 18:59:41 +0530
Message-ID: <c94f8e120811060529i4e51ebefr2e14f8212ead6752@mail.gmail.com>
References: <4d8e3fd30808272300g58d92dd8pd877d72805bc29c0@mail.gmail.com>
	 <4d8e3fd30808280313i70f572cfh9c14fbc2adbf5cea@mail.gmail.com>
	 <c94f8e120811030602p57007278p5a2c48ce7663282d@mail.gmail.com>
	 <4d8e3fd30811040313x44290557yecfedb2fbc8cad0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 06 14:31:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky4ws-0003DQ-Ri
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 14:30:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753744AbYKFN3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 08:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753421AbYKFN3o
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 08:29:44 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:61054 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753387AbYKFN3n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 08:29:43 -0500
Received: by ug-out-1314.google.com with SMTP id 39so822641ugf.37
        for <git@vger.kernel.org>; Thu, 06 Nov 2008 05:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=FSqb4t6vbQ6tI4MtTjXezpjKUnxcLsRO9PV7sMp31vo=;
        b=g94MbygQfD6ytn4VxvZcVPbB2EwlBS+HYy4F6ZA8YsPjspoPQ2quhw8Wp2o5Cmnb0s
         L6kqxBZzivODig6NRNSmhNy70uYbW50aLUbdjFFxm2Q8sY+QLmajAjBWJHdRjqRPi3ug
         8/VeYZ4ptoAaevFPuVDzkTbtwVO8mV3BBlUjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=CYPrt7LrOHRf1CuOlEk2YiveQFA4UiMLw89UWXkQdkzPRtQ9eJAO5ErgS9W47PbaX2
         jd1DyZQf+qnZyZTxpeMscq1z2NkXRXlGkZ3NcqPBaLppSGPtgFfgKmXEolsP/C4uYqkE
         Ak8GYWR/hPYcbsK2Zon7J7ZE4U1tBMLSGNkdo=
Received: by 10.66.250.17 with SMTP id x17mr568712ugh.67.1225978182040;
        Thu, 06 Nov 2008 05:29:42 -0800 (PST)
Received: by 10.66.220.11 with HTTP; Thu, 6 Nov 2008 05:29:41 -0800 (PST)
In-Reply-To: <4d8e3fd30811040313x44290557yecfedb2fbc8cad0b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100235>

On Tue, Nov 4, 2008 at 4:43 PM, <paolo.ciarrocchi@gmail.com> wrote:
> Works for me: $ git version git version 1.6.0.2.1172.ga5ed0
>
> I set in the Environment Variables panel:
>
> Variable          Value http_proxy      http://ip_of_my_proxy

Okay it solved now. Problem was old version of GIT. libcurl library
problem.

Upgrade the OS ,which in turn upgraded the libs...

Working fine for me too..


-- 
Dilip
