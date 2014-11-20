From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] refs.c: make ref_transaction_delete a wrapper for
 ref_transaction_update
Date: Wed, 19 Nov 2014 17:11:36 -0800
Message-ID: <20141120011136.GC6527@google.com>
References: <1416433224-29763-1-git-send-email-sbeller@google.com>
 <1416433224-29763-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, sahlberg@google.com, git@vger.kernel.org,
	mhagger@alum.mit.edu
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 02:11:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrGHZ-0004Ex-Tl
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 02:11:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756246AbaKTBLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 20:11:34 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:43985 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755145AbaKTBLd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 20:11:33 -0500
Received: by mail-ie0-f173.google.com with SMTP id y20so1815439ier.32
        for <git@vger.kernel.org>; Wed, 19 Nov 2014 17:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=XU57oR6t0oHzrtI7TDv58cn747MgcH5gq5NCnG8sm0M=;
        b=KPT95n+pL0PiOhWKRVEsGvtwIkXYoZIYEbWoreCE+QI/VGv1GEcWaNVL7xLoR05M0E
         MHRxTxL9sTzOFWnfaAc+6et/Ay9pOqq1opzs2LvQo0KLUcxwJluquW9C4VMdJyzCeRTR
         9T9fFZEINLwAXdyDSLFLWGSvO8ICyPeZrjevLnmVDsHD3gElhp+iapeKDJv/tXMwteLw
         SMQXBjoInd/6Um0EWVUf04fYFXyV638akJHdK67pJqpFcwr2aqVBTkxwWHRLBSuKo60R
         R19LlTxOIID0vBm+ImXQbXoz49i6jzYza3EA1SYy5PYJBhzmhjpHftXPCBeWTZYZP9yj
         CBOg==
X-Received: by 10.107.162.130 with SMTP id l124mr4356483ioe.54.1416445893142;
        Wed, 19 Nov 2014 17:11:33 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:31da:72d3:8c17:80bd])
        by mx.google.com with ESMTPSA id k191sm489630iok.7.2014.11.19.17.11.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Nov 2014 17:11:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1416433224-29763-3-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

>  refs.c | 22 ++--------------------
>  refs.h |  2 +-
>  2 files changed, 3 insertions(+), 21 deletions(-)

Likewise:

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

but this shouldn't have had my sign-off.
