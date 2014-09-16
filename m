From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 04/35] rollback_lock_file(): exit early if lock is not
 active
Date: Tue, 16 Sep 2014 13:38:26 -0700
Message-ID: <20140916203826.GD29050@google.com>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
 <1410896036-12750-5-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 16 22:38:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTzWE-0005w0-5Q
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 22:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340AbaIPUia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 16:38:30 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:60278 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688AbaIPUi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 16:38:29 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so560845pab.1
        for <git@vger.kernel.org>; Tue, 16 Sep 2014 13:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/vu84TXf+zaM6UGdAH5O6IT1EJBAGyG0jzEmrd/qCGY=;
        b=IpQtKUEZSBmL9uAIcgp4h0FzPYpH6NZ0pMOWQPbRJWXv9LytggtB5yHjZTh5u5CCiB
         No1yEln+lc2vnZH59p+l9VFXJMisdtg8Oq+gKS+BDuJQvUJJDprvtZJTv3F5VbCbhguP
         4sI8QTjdnWzMb7RX7zDLkqZcrz1RLN9fT2cizlloLMWy8+dnEKL2w7M91G+e1FgAH6rQ
         nSXbgQOOVVwnsMVIVb2JQ5wdOU90HTdjj6O+tLTGZ5OvJOQjiMFP+fRIsPgRSqLlj0+J
         1zGR7N+HuUtdHkq5L3eTdCZlzl9yfDrEyQtKxhzVyiWYINblJnArkP076EHjCHFmV3oH
         MScA==
X-Received: by 10.70.140.193 with SMTP id ri1mr58816975pdb.18.1410899909276;
        Tue, 16 Sep 2014 13:38:29 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id je2sm14847280pbd.94.2014.09.16.13.38.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Sep 2014 13:38:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1410896036-12750-5-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257187>

Michael Haggerty wrote:

> Eliminate a layer of nesting.

Oh --- guess I should have been more patient. :)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
