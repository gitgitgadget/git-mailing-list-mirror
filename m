From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v6 10/42] refs.c: ref_transaction_delete to check for
 error and return status
Date: Wed, 14 May 2014 17:19:04 -0700
Message-ID: <20140515001904.GG9218@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
 <1398976662-6962-11-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 15 02:19:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkjOC-0000gR-Qv
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 02:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbaEOATI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 20:19:08 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:40656 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbaEOATH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 20:19:07 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz1so281435pad.30
        for <git@vger.kernel.org>; Wed, 14 May 2014 17:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=3qonWkxQZjzqOSRYy7GRz9svE549TgvLs4SfDsBh+uo=;
        b=JXfT1FgBxPOYPh5etb1V24n6LcGx8ECKXEyRLMoXR/b/RTF4mVaJJyzFl19c9Guc+1
         eklUl6lN48FXdHYwAldX9kRJVdw3L33fwsMsbbQR1utq6iWyaed7+TFCKmWUDjQbfjz+
         5jbz6k2z7pMDuiytOWQxQzVwD92O7iXhzJdLUZFvErEWsEQDERpHgcMhMYkCkm1myxm8
         yQzjWw5M6dSA7lNk/FVAka6tFRqxKI19T6t+c2EtmRmIjKjZsQyYl2wh+8V+/4VCZOlf
         a81vEo7Aj/i5r/dUfcXiOiWPM6LKcB7FB6897fk8+MYtWi3hETM0JMRgOBASn/ocR7jR
         e40w==
X-Received: by 10.68.106.36 with SMTP id gr4mr8202256pbb.64.1400113146818;
        Wed, 14 May 2014 17:19:06 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ja8sm5648866pbd.3.2014.05.14.17.19.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 May 2014 17:19:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398976662-6962-11-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249053>

Ronnie Sahlberg wrote:

> Change ref_transaction_delete() to do basic error checking and return
> status. Update all callers to check the return for ref_transaction_delete()
> There are currently no conditions in _delete that will return error but there
> will be in the future.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>

Same comments as _delete and _update. :)
