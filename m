From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2009, #07; Wed, 28)
Date: Thu, 29 Jan 2009 12:45:23 +0100
Message-ID: <bd6139dc0901290345u4962f747gbe93c945ab35c9cb@mail.gmail.com>
References: <7vwscej26i.fsf@gitster.siamese.dyndns.org>
	 <20090129035138.GC11836@coredump.intra.peff.net>
	 <bd6139dc0901290327u572cc30ci9dc719c912fbf875@mail.gmail.com>
	 <20090129113735.GA6505@coredump.intra.peff.net>
	 <351A6988-32EB-473F-B6E5-8FBB38D91F88@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Thu Jan 29 12:46:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSVMC-0005bf-0u
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 12:46:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753732AbZA2Lp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 06:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751717AbZA2Lp0
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 06:45:26 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:41324 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbZA2LpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 06:45:25 -0500
Received: by yw-out-2324.google.com with SMTP id 9so3188977ywe.1
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 03:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=jbeZ+DxmTpkW/X9p1OHNO1jEXa4Nl8VmpOAMd1ZHRV4=;
        b=kbcCRH8oIYwC+413uJOViPGcRypB5w/ED1VfwulrTDF27ljzc8lzoZdMo1kAeThwii
         ODu8Z8aWOjsyVPy22PQklC4HCBZWMrNGGLO9gV7Ja+db0vS4+MyfLmN7ZQ2UQ3zhnaU8
         2WEreqY1OIMTofvU234rOVwouJByCqZThSs/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=CWXsR0j3Oyx9V4ewGiujbf+dUFkcQ8B0rFYuk6muceIuMc8u7C8sRTnxcBSJJWP7pq
         x/Xr2HLDcJDCN1nyy5ODfGPklXluje86NtwOwWFnCDEsfcVJ5YJnM/nT4krZ3EIv3T1a
         dyzFubzfhM+LmgtJivrVRtK6/dbTWO/qadGc0=
Received: by 10.150.181.7 with SMTP id d7mr53307ybf.73.1233229523395; Thu, 29 
	Jan 2009 03:45:23 -0800 (PST)
In-Reply-To: <351A6988-32EB-473F-B6E5-8FBB38D91F88@ai.rug.nl>
X-Google-Sender-Auth: b1113838709c51e3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107660>

On Thu, Jan 29, 2009 at 12:40, Pieter de Bie <pdebie@ai.rug.nl> wrote:
> This is true in all cases. If you create a new branch in any repository,
> push that, and later do a 'git pull', you get that message. I agree it's
> not the nicest way to handle things, but this is not an issue with the
> clone, it's an issue of pushing new branches in general.

Mhhh, so maybe we want a way to set up tracking branches when pushing,
yes? From what I've seen a patch to do that shouldn't be too hard, so
if there's interest in that I could look into that.

-- 
Cheers,

Sverre Rabbelier
