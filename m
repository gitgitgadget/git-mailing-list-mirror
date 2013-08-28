From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Eclipse
Date: Wed, 28 Aug 2013 21:10:16 +1200
Message-ID: <521DBE78.1070709@gmail.com>
References: <521CC15A.9020602@noaa.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ron Tregaskis - NOAA Federal <ron.tregaskis@noaa.gov>
X-From: git-owner@vger.kernel.org Wed Aug 28 11:09:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEbkc-0002xg-5M
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 11:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048Ab3H1JJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 05:09:13 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:60271 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616Ab3H1JJL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 05:09:11 -0400
Received: by mail-pd0-f171.google.com with SMTP id g10so6036580pdj.30
        for <git@vger.kernel.org>; Wed, 28 Aug 2013 02:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=e0WuniDAsMBkzHOAZWMpN5s1pLPjft2WVHmXFOAHqcA=;
        b=d1uAidHZxgdgcjaFZg5TBbgU/PVKh+lf/doNeJRSGLeq5wNKNe26Ns+78+XijwOImA
         cKrq4xvel8O5WeGYWQc7XMlNcXLsWczbHHIcY/l+a48ZN5D1kiJwpIRdE8RhKsHQXc3F
         QadSIQ8KqS3JigzSgFsSO298U3jXt5IJtaDlCdTluZ/ASEOJY+ju6Anvb0oF1Ut/jKaJ
         tmPUXUFvIx1sPCv2UyBmx2iBiaKqgA5tco2pPjC8mljn+/0/lpEyzuONTERgDkw5kZwR
         rNXD008wc6F66k/i62OzJqRiHPLagDrp3d3OMDvaxTxvKEoIFxb+bBd0XXDSJDHqP043
         dgqg==
X-Received: by 10.66.25.133 with SMTP id c5mr25253354pag.4.1377680951168;
        Wed, 28 Aug 2013 02:09:11 -0700 (PDT)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id tr10sm29978108pbc.22.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 28 Aug 2013 02:09:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <521CC15A.9020602@noaa.gov>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233181>

Hi Ron,

On 28/08/13 03:10, Ron Tregaskis - NOAA Federal wrote:
> Does git work with Eclipse?
> 
> Ron
> -- 

Eclipse does have git integration courtesy of the EGit plugin. At
$dayjob most of us are running eclipse 3.7 a.k.a "Indigo". When we
started with an earlier eclipse version we had to install the git plugin
manually but these days it's bundled with the CDT release [1] (and I
assume most other flavours of eclipse[2]).

EGit is built on JGit which sometimes lags behind the core git in terms
of features. But for the majority of users you won't notice. I still use
core git for most of my day-to-day work but plenty of others do
everything from within eclipse.

I've also found that Eclipse's affinity for svn-like vcses doesn't
always line up with the git/dvcs way of doing things but that seems to
get better with each release.

Hope that helps,
- C

--
[1] -
http://www.eclipse.org/downloads/packages/eclipse-ide-cc-developers/keplerr
[2] -
http://www.eclipse.org/downloads/packages/eclipse-ide-java-developers/keplerr
