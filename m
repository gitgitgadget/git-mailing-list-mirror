From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 21/35] dump_marks(): remove a redundant call to
 rollback_lock_file()
Date: Tue, 16 Sep 2014 15:24:36 -0700
Message-ID: <20140916222436.GU29050@google.com>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
 <1410896036-12750-22-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Sep 17 00:24:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XU1Ay-0001Ie-0M
	for gcvg-git-2@plane.gmane.org; Wed, 17 Sep 2014 00:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534AbaIPWYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 18:24:40 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:51283 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752975AbaIPWYj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 18:24:39 -0400
Received: by mail-pa0-f50.google.com with SMTP id bj1so692105pad.23
        for <git@vger.kernel.org>; Tue, 16 Sep 2014 15:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=BNn41SBz+1h2jiwLSqPF3E36n2r4wEnuGoWpGB5ic4w=;
        b=XO3TFwFaMlngx3IZBDW9idZXc0zILNQ7cIoa6yEEMc91yDkRzH6DmXvRfir2hLZCxA
         FuWeBKDy+7mBvQNysSKP+GXHp42Y8dgdrcJbCXOVn5gjtx7Em5TSMPWLLDaT/emaw3N3
         gDOdV7sscqPwFiq/jzD5RpGg/zzcjicFMY1ym4V9VYrpzvc/rxUsz1zYWZvra+sui20U
         6eGl0AGrjALtBY6RsDxehKF3aHIzk67kUX8LUlwG8dq8GFBO+bUWp7LHzZc1LIACbKIT
         c9aH3z3ut117AoGIhs8lV34PEY7Q8r94tGFqGNz+gqodxVu7183AMLew5WvZRPmKhYn0
         jtnA==
X-Received: by 10.70.128.137 with SMTP id no9mr25965397pdb.143.1410906279360;
        Tue, 16 Sep 2014 15:24:39 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id qc3sm15523534pab.48.2014.09.16.15.24.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Sep 2014 15:24:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1410896036-12750-22-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257205>

Michael Haggerty wrote:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  fast-import.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
