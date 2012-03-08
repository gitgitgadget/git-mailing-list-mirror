From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Git 1.7.10-rc0
Date: Thu, 8 Mar 2012 17:55:59 +0100
Message-ID: <201203081756.00604.jnareb@gmail.com>
References: <7v7gyvkh84.fsf@alter.siamese.dyndns.org> <m3wr6vs7a2.fsf@localhost.localdomain> <7v4ntzf45w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 17:56:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5gdP-0000uI-BZ
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 17:56:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757285Ab2CHQ4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 11:56:06 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38657 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621Ab2CHQ4E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 11:56:04 -0500
Received: by wibhm2 with SMTP id hm2so459970wib.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 08:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=712TrQSOI2v7sTMdlwDksAcCnW3ipLAV5XsBkg+VNQs=;
        b=BLRp4gObF79osNy1KYHBr/5xbDe9X3ADHn2CG9UuEzh0WW0p55hWFu64kyBZSdkASM
         yXG9q5gs6vYxnAEnH5CiqZNhMNPaKKr3Aq6Qd/MayWiGXbPltsmEqUlcNQwk97DLAv6o
         LJRV6LhZd2eIQNen+6A2qAxr4UjwiqVe/9TOVpMS7ml95Pm2dqt3aJ5xTknXdKijvEzc
         s+b3oce1Vf45T/jrVn8foLPK5KF03DKgzVa+W7kCcKzUnFoHXkkHvU56QLuou4ybPqJU
         ppPDPNuAgkvNfU2DxUFz+h/m4nD7u9QRdttRDV+BfKaXwmQH2QzduLBXyitGEerUuSef
         ee3Q==
Received: by 10.180.87.8 with SMTP id t8mr36737410wiz.15.1331225763498;
        Thu, 08 Mar 2012 08:56:03 -0800 (PST)
Received: from [192.168.1.13] (abwr173.neoplus.adsl.tpnet.pl. [83.8.241.173])
        by mx.google.com with ESMTPS id ff2sm11048793wib.9.2012.03.08.08.56.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 08:56:02 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7v4ntzf45w.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192618>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> > Junio C Hamano <gitster@pobox.com> writes:
> > ...
> >> Fixes since v1.7.9
> >> ------------------
> >> 
> >> Unless otherwise noted, all the fixes since v1.7.9 in the maintenance
> >> releases are contained in this release (see release notes to them for
> >> details).
> > [...]
> >
> >>  * "gitweb" used to drop warnings in the log file when "heads" view is
> >>    accessed in a repository whose HEAD does not point at a valid
> >>    branch.
> >
> > It looks like fix for fixed-string project search is missing.
> 
> Hasn't it been already fixed in the 1.7.9.x maintenance track?

I don't see it either in 'maint' or in 'master'.

It is surely not in master, otherwise 'stg rebase' would drop the
"gitweb: Fix fixed string (non-regexp) project search" patch.

-- 
Jakub Narebski
Poland
