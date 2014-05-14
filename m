From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v6 06/42] refs.c: make update_ref_write update a strbuf
 on failure
Date: Wed, 14 May 2014 16:04:24 -0700
Message-ID: <20140514230424.GC9218@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
 <1398976662-6962-7-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 15 01:04:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkiDw-0007RI-3A
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 01:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057AbaENXE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 19:04:28 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:65045 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbaENXE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 19:04:27 -0400
Received: by mail-pa0-f54.google.com with SMTP id bj1so214020pad.13
        for <git@vger.kernel.org>; Wed, 14 May 2014 16:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=RCPjiR9WeTl36d8116DKYSfIptBMNyx+ltlCiLcNKCs=;
        b=xcvF0f52Rsz7HRIp6/DDZwdOt8KulkX2nKpNjY5SaOaLHIIBYcIPc26fSgLpDwmxrX
         lB/AJxdiTcrc8oU6+q0opE1sXu3rPf7cBFmDSRg6TFftp9DFJZm6IKc8jwsJFA0DuYxh
         A57DKFDEFLFoO42HHyj793WaaWIMiCumHNsoV23Na4D9RG8kwQ0CSDprKiAXTNVg3lhq
         3N3AZb4QWxbleAyTodiRMY4kreyZFRmHjaflGEbbg97dpn7G9aRf5ctyZPQnUVfXx9Ck
         ODNimij1kk9mdxnTMEA66NegGzl0UTiiIZcmZzOSAJPBLk9if9A7O6vk3tgYXUV/edcq
         5Jbw==
X-Received: by 10.68.178.131 with SMTP id cy3mr7874851pbc.146.1400108667323;
        Wed, 14 May 2014 16:04:27 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id wp3sm5438367pbc.67.2014.05.14.16.04.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 May 2014 16:04:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398976662-6962-7-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249046>

Ronnie Sahlberg wrote:

> Change update_ref_write to also update an error strbuf on failure.
> This makes the error available to ref_transaction_commit callers if the
> transaction failed due to update_ref_sha1/write_ref_sha1 failures.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
