From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 06/35] lockfile: unlock file if lockfile permissions
 cannot be adjusted
Date: Tue, 16 Sep 2014 13:42:10 -0700
Message-ID: <20140916204210.GG29050@google.com>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
 <1410896036-12750-7-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 16 22:42:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTzZt-000852-If
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 22:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755312AbaIPUmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 16:42:16 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:44509 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755298AbaIPUmN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 16:42:13 -0400
Received: by mail-pd0-f176.google.com with SMTP id y13so550133pdi.21
        for <git@vger.kernel.org>; Tue, 16 Sep 2014 13:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=weQHhUVdzOYS3rnlgbYeYh9KdmCY1H2Q2lxtX+de4EA=;
        b=ijHWZaibblTmeVgjKDvI15WCJtgjAbynLT7xs7pdaaBBPi+8Jfl2JQ8K5YeMoE+dn9
         3jYxt9bdFzVlCQlO+xb4zaYdLUKaihfzT9XrJDnjiMuSL8tW2lAmrmIWkUG+VkQgQ8xQ
         yu9EqF3iYNAlJZlrsYdsxxwPF9goVB9NH1+ETIrdmPabosAgxo1KTU/t3j/52WjWbaym
         zcxXh2vjwhN01hWXln8mIwf+vrWSSHd0snrH11LznyxailB/3AoR4F0KJwIlVconWTpx
         AjkYKiVIkDg3KNLigVEjpBNMyez/SrmRJJGTLQHHps0cj6xvHUA2VSJDJjTm9hrP8GhX
         vEbQ==
X-Received: by 10.70.132.37 with SMTP id or5mr21066936pdb.149.1410900132600;
        Tue, 16 Sep 2014 13:42:12 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id jc3sm14904505pbd.59.2014.09.16.13.42.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Sep 2014 13:42:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1410896036-12750-7-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257190>

Michael Haggerty wrote:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  lockfile.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
