From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/6] prune_remote(): sort delete_refs_list references en
 masse
Date: Sat, 22 Nov 2014 13:08:24 -0800
Message-ID: <20141122210824.GC15320@google.com>
References: <1416423000-4323-1-git-send-email-sbeller@google.com>
 <1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>
 <1416578950-23210-4-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Nov 22 22:08:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsHuo-0004RK-Vm
	for gcvg-git-2@plane.gmane.org; Sat, 22 Nov 2014 22:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbaKVVIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Nov 2014 16:08:18 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:61829 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688AbaKVVIR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Nov 2014 16:08:17 -0500
Received: by mail-ig0-f181.google.com with SMTP id l13so1476255iga.14
        for <git@vger.kernel.org>; Sat, 22 Nov 2014 13:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=e1n+NW5iIVHZhXp4tUNgFQANLXXsi7YO5UXHV8dTPTQ=;
        b=aYAvXw330Ik1nqqa9ec8seGvL9oPClnVaIarpVq8F/dMeDBCigEHWOAkLbn6troT0f
         bIQGPqCvx4/MDnuEufoxWex196ceq7hpgHyMjkiF9yfbExwmMKdWq2h854NrJNhZVAzw
         z8z3gx+mLhASjlSiQn5O+Qvl/IjK35vuI8AlfSQ9F4rSEnzdMwIO6txacMG9EWDG8+Fi
         dM9mfR6h5mfBbPaLHmLFA6aqoyTG/iJaleZRqDkeYGt+WBO1LWE6MD5FXjGPkfd3qEDY
         pajE9x1PQjJDPvPXkqY2SskpgY6TczIDoegMp7hqdX/u0IyjJyjYZmBVTnwbDk03CJyc
         z4Bw==
X-Received: by 10.107.151.145 with SMTP id z139mr11073734iod.24.1416690497466;
        Sat, 22 Nov 2014 13:08:17 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:8d62:add2:ab4d:c706])
        by mx.google.com with ESMTPSA id ro6sm1886233igb.3.2014.11.22.13.08.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 22 Nov 2014 13:08:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1416578950-23210-4-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260077>

Michael Haggerty wrote:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  builtin/remote.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

This and 2/6 are also

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
