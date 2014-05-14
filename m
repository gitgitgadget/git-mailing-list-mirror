From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v6 07/42] refs.c: remove the onerr argument to
 ref_transaction_commit
Date: Wed, 14 May 2014 16:06:04 -0700
Message-ID: <20140514230604.GD9218@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
 <1398976662-6962-8-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 15 01:06:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkiFY-0002rl-Nd
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 01:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbaENXGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 19:06:09 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33365 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473AbaENXGI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 19:06:08 -0400
Received: by mail-pa0-f48.google.com with SMTP id rd3so213509pab.21
        for <git@vger.kernel.org>; Wed, 14 May 2014 16:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=G8m6B595w0SZT/O7XoxShCjXfzflL+8wj+C6nLAlh5Y=;
        b=ODyNcxToUPAvRvGl/ooLVBwnU+nD+xB+3PdTP52hHlOat0pN2QF8L4m0o5UKj/L3P/
         EadLaphYA0g2OyvkJxXfUFvs8atXSQXEgnu3m92uivtokhtzDm7dCNP43NRhD427aWTv
         d7JvDQdfBKO1bKzBOAFEpU2kA+LrMpS3ME2FALapJx5J1prUzJZmjjLM+rlmoN5FZfN9
         VR4kVJFuG0VXAB4uk7LRNEzfw/IlHYwhcrce4WmOlUvvHQqDSX1B1xz8aXrQcfwRL3Q/
         HGE5gioEwzGaLRK+/uYu3OsAKPOsVaJgHgVsRZO1V/UqMIKsMaXfsZgcs8TMxq88DbFj
         Y+Mg==
X-Received: by 10.66.146.199 with SMTP id te7mr7956606pab.106.1400108767006;
        Wed, 14 May 2014 16:06:07 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ph1sm13118401pac.14.2014.05.14.16.06.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 May 2014 16:06:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398976662-6962-8-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249047>

Ronnie Sahlberg wrote:

> Since all callers now use QUIET_ON_ERR we no longer need to provide an onerr
> argument any more. Remove the onerr argument from the ref_transaction_commit
> signature.

Nice, and obviously correct.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
