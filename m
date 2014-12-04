From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 05/23] expire_reflog(): rename "ref" parameter to
 "refname"
Date: Thu, 4 Dec 2014 15:44:22 -0800
Message-ID: <20141204234422.GG16345@google.com>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
 <1417734515-11812-6-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:44:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwg4T-0005eY-QC
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933335AbaLDXo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:44:26 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:40377 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933119AbaLDXoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 18:44:25 -0500
Received: by mail-ie0-f171.google.com with SMTP id rl12so16925161iec.30
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 15:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vkhl0WXJDfErTzX1LJwRDNq9BQqR/2r74AYjwXWg4Fk=;
        b=doTKoWk4SJ6wb1C+83rvCdkSCv8wo7I024sYmBZmyjsQDm07mp5Je1mmf/GhdycyNl
         1EU6yzoXEue4G23yP/4sqFKcRg2BjGvMLNspPEsgadxN64XHRPCjcAMZKgH8NDQ9Alng
         IvHPSv9KkemEiXavG4UIaGPEiHn++nayXDoXffrzj+WC3hwgzqIO7jNJukIEteUlFSmy
         qrmNyKWbTpZS/GZhLN1CAWr5++HYgyHEX01aW3rkBzgEVf2wDYpDGGmpOALJWzeqJ039
         O0LaVZ1jnEcQLdcyxL3boMVGPzigUqdoqyWMe3A+V3h3DXyKY9g3bolme8v6kTVu6rLS
         O+EQ==
X-Received: by 10.50.41.5 with SMTP id b5mr3236272igl.9.1417736664946;
        Thu, 04 Dec 2014 15:44:24 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:5da0:cb9e:66b:e537])
        by mx.google.com with ESMTPSA id rp3sm6511571igb.1.2014.12.04.15.44.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Dec 2014 15:44:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1417734515-11812-6-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260840>

Michael Haggerty wrote:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  builtin/reflog.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
