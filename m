From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Optimize prefixcmp()
Date: Sat, 29 Dec 2007 23:44:08 +0100
Message-ID: <e5bfff550712291444t7b6b5887g24b477552c76a6d7@mail.gmail.com>
References: <e5bfff550712291001q5f246ceah6700b98308fb96f1@mail.gmail.com>
	 <Pine.LNX.4.64.0712292019450.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	 <e5bfff550712291239y5648b923y8d332d9c40a8c97b@mail.gmail.com>
	 <Pine.LNX.4.64.0712292307210.14355@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Dec 29 23:44:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8kQ4-0004dE-5w
	for gcvg-git-2@gmane.org; Sat, 29 Dec 2007 23:44:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbXL2WoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2007 17:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbXL2WoK
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Dec 2007 17:44:10 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:19428 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbXL2WoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2007 17:44:09 -0500
Received: by rv-out-0910.google.com with SMTP id k20so4007089rvb.1
        for <git@vger.kernel.org>; Sat, 29 Dec 2007 14:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=SO5NLKF0ySL85q9nbR/Dy3CBQeiKOYHveSX653/w9gY=;
        b=E3aGqI7I/7cReRprJZsuiw42IOjDcNg9tVyeI1V0lQIPpPJ2LuPeS6JqA0/e9p2sdq97W7nO09wMMsSYr8EYpNOHEHpSoHM+h79Z/oG1MCLiu6gB1T4HWy7FhgpBudxdUlzflCtWgkIYH2ZtZBtHpU7gRFq6UQIt/x5eeK1hv2s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y9j8wUsu5cNS9/3neUsmFQLVuNQqiQUwaPPMbclNPwZzIpqFoVKh+Gx2mPhQDvOS0laZA2CsAoUosw3ooSg3banTW6B1pf/H5l7x+ioeVn5ohFy4XfXh86CZd8F7anNHIVI2vSkT+TKeXncvoOg5fh8IS0uUgDQedJkmXQ4XB/8=
Received: by 10.141.43.5 with SMTP id v5mr5599138rvj.49.1198968248724;
        Sat, 29 Dec 2007 14:44:08 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sat, 29 Dec 2007 14:44:08 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0712292307210.14355@wbgn129.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69335>

On Dec 29, 2007 11:15 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> However, since you already seem to have a profiling setup ready, I would
> be interested in some numbers, i.e. if this patch is faster for you or
> slower, or shows no effect at all.
>

Ok. I will do some tests with your patch and I'll let you know.

Marco
