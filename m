From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: [PATCH] Add the DEFAULT_HELP_FORMAT option to Makefile
Date: Wed, 06 Jun 2012 22:25:00 +0200
Message-ID: <4FCFBC9C.6010501@lyx.org>
References: <20120606135353.GD2597@sigill.intra.peff.net> <1339008702-704-1-git-send-email-vfr@lyx.org> <7vzk8gl0p0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 22:25:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScMn3-0000tE-Mb
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 22:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757537Ab2FFUZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 16:25:07 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:56674 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133Ab2FFUZF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 16:25:05 -0400
Received: by eeit10 with SMTP id t10so2486637eei.19
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 13:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=T8JzT7ij9U2HvHhU49UC5uUpGZvAXsinOfLaMXWDOLI=;
        b=NmbE+oshgQgLi0XRPV7LpGnUEvh/P/aVQEOsi4GQJ4k4dvImIplUoVc/G94RYhIxq9
         j7hZlWz1mp+vZFrJMvPCwNzIJs+Zu4g9Cy+zijj4g8DijnFUvZ44MhXPtRHxtA7J/hRG
         PLp1r9fMmDwKHC1VvQx1FHV6gcljFSvkGwforjiAST6P6LPywwjm0ipn2zUevl/20uEO
         SIc2MuH1Yv6Mr/LeZU45m19ZeUpOQrw8QM/Y7fIKE7E8rlhl24vPVPIvvBoQF7SuGzb7
         xCnpTX681kgE6tyqjDhZYa2Ix2H5vuuIN26CRf1baDWVbbS+LmnX0xA1KTKd5T0DRx/F
         k7Lg==
Received: by 10.14.98.205 with SMTP id v53mr10878052eef.138.1339014303475;
        Wed, 06 Jun 2012 13:25:03 -0700 (PDT)
Received: from [192.168.1.4] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id t3sm3085994eeb.15.2012.06.06.13.25.01
        (version=SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 13:25:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <7vzk8gl0p0.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQkJQRzKRdyjElgXFhmIxma7PT7HLTHU9Ie0bpCEKCmSkUcjDJRzO34k2Mm1L3aVnSntzyo2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199350>

Op 6-6-2012 21:06, Junio C Hamano schreef:
> I think the choices of PAGER and EDITOR share the same problem, but
> shouldn't this choice recorded in GIT-BUILD-OPTIONS in some way?

I don't know. The only place I know where GIT-BUILD-OPTIONS  is used is 
in the test suite. The test suite runs fine with the patches.

Vincent
