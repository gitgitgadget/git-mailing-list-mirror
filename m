From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] git-init: autodetect core.ignorecase
Date: Tue, 25 Mar 2008 14:03:29 +0300
Message-ID: <20080325110329.GK25381@dpotapov.dyndns.org>
References: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org> <1206428273-15926-1-git-send-email-dpotapov@gmail.com> <alpine.LSU.1.00.0803251056520.10660@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 25 12:04:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je6wz-0007J7-TL
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 12:04:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462AbYCYLDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 07:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753443AbYCYLDf
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 07:03:35 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:16813 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753433AbYCYLDe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 07:03:34 -0400
Received: by fg-out-1718.google.com with SMTP id l27so3447481fgb.17
        for <git@vger.kernel.org>; Tue, 25 Mar 2008 04:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=ddQuF7bcA8uHyvxt20w+dgSTKXOmElyhWUA6a5vSJgw=;
        b=p6B5jW/Kq1azv/qwMSGfsafx5koyRH4PhqbgSanXNf5X1vwNa+Zos2Yuqf6mQXZ1ME6OaMFahkr1Y2Q/vNtMiPheoDf3Oq1YM8FY6ZbGSYJsLHClZvvpVAWtrsfwSAXCFKHl/rEQsrq3Povb/5EcogsxElpfGTpGRAaNS2/4ZAk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=eMvUTL9Wjsw2G+OV1iozgOExQnbixM6RCfwt0ZAw89ecWQocFMYVuqncm+VOoRKzak5Rpooh3GhuJs0OEq3CXDCJKxlAS4hneKYni3z3EZJIUv6pVKQ9x1BNqjPjX5LMVuoc6T5vAu4m8JnMLronbCfbC3uyoCX9poruF4fG2N8=
Received: by 10.82.105.1 with SMTP id d1mr20504235buc.29.1206443013168;
        Tue, 25 Mar 2008 04:03:33 -0700 (PDT)
Received: from localhost ( [83.237.187.35])
        by mx.google.com with ESMTPS id 12sm9311896fgg.6.2008.03.25.04.03.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 25 Mar 2008 04:03:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803251056520.10660@wbgn129.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78178>

On Tue, Mar 25, 2008 at 10:59:00AM +0100, Johannes Schindelin wrote:
> 
> Last time I checked, the "HEAD" file on VFAT was converted to "head" when 
> the repository was initialised on Win32 (IIRC) and read on Linux (IIRC).  

It is result of mounting the VFAT disk on Linux with shortname=lower,
which is the default :( Perhaps, it was a reasonable default for DOS
days, but now it only creates troubles. I usually mount VFAT disks with
shortname=winnt on Linux, though some people prefer shortname=mixed.

Dmitry
