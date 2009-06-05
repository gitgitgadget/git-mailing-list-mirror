From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 00/23] http*: refactor (v5)
Date: Fri, 05 Jun 2009 13:41:30 -0700 (PDT)
Message-ID: <m3zlcm5s7g.fsf@localhost.localdomain>
References: <20090605235959.f4df6457.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>,
	Clemens Buchacher <drizzd@aon.at>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 22:41:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCgEP-00062w-Le
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 22:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbZFEUlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 16:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbZFEUlb
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 16:41:31 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:59377 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503AbZFEUlb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 16:41:31 -0400
Received: by fg-out-1718.google.com with SMTP id 16so649232fgg.17
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 13:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=0YrycOhV+XZxLcTR8CUEAz7C7cj7oAgya9x/x3mU/2s=;
        b=rVYGcJRDYGIDem1OZ4SWfJmIR//4FCt8DUaEJ578mrPxKWl4WmSisbeiTjzlbJFiQF
         KQTydOlbKeoMeV+6a6EIHZ/gmB9KHwgwxOgOtq1JN5C2MNn0sx/s6V2276/8/Gh0Dg1B
         hGP/YQ0SwJmPoaP2yuSXPATgspAkA90KlmeFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Wmuaklv08dlUYza0Q5kGY5xtrCa5QQDwdcCNRZjGIALgBHtCHxLUng8QJlbIt05E2q
         REjXzVp7g0Z71EoV+3wBGoxT1ayvME+EKK7WI1rEjz7R1+0R2GT8ZawfixYKwpUA5AN6
         UbbEPLzY65tK+sIfLozb58BtDTI24G9PBMPUc=
Received: by 10.86.36.11 with SMTP id j11mr4354438fgj.56.1244234491012;
        Fri, 05 Jun 2009 13:41:31 -0700 (PDT)
Received: from localhost.localdomain (abwo21.neoplus.adsl.tpnet.pl [83.8.238.21])
        by mx.google.com with ESMTPS id 3sm838314fge.16.2009.06.05.13.41.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 13:41:30 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n55KfRZU024544;
	Fri, 5 Jun 2009 22:41:27 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n55KfNMQ024540;
	Fri, 5 Jun 2009 22:41:23 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090605235959.f4df6457.rctay89@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120829>

Could you please make all patches in this series to be replies to this
cover letter ('shallow' threading)?  This way it would be easier to
read this patch series (or kill / ignore it as a whole)?

Thanks in advance

P.S. Why subject is "Re: [PATCH 00/23] ..." and not "[PATCH 00/23] ..."?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
