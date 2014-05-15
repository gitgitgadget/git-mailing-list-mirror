From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 01/44] refs.c: constify the sha arguments for
 ref_transaction_create|delete|update
Date: Thu, 15 May 2014 11:10:36 -0700
Message-ID: <20140515181035.GB26471@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-2-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 15 20:10:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl079-0001CF-9T
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 20:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231AbaEOSKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 14:10:39 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:56010 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754992AbaEOSKj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 14:10:39 -0400
Received: by mail-pb0-f53.google.com with SMTP id md12so1416266pbc.12
        for <git@vger.kernel.org>; Thu, 15 May 2014 11:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=e/WestBNX9k3dBrs2/oyZgTgEN6hxPPb+l9mJSeGwiw=;
        b=hX6KY3F+1f80G7D/j20IhEsyQVw8k/2JB59pnQqK4GaSSfbgGe08sgWz7TRPBxF4ND
         J5Bnounmr8Hy9Z7xIwhgLrgU5YwReZ2tOk9SHNCy5SBGweRAXXw62AQNYcpx2puMGtZo
         C5cxFur6necPVHf9a29Wl3A3hy16risIWt8paq4b71ZoK/sXEMR0Sc1Z4DBkmVeru71p
         W9DTnJRTfvxyh3i9evGp7Wkv2pp7pE+DQGtzdz0wZ4HH20cjoXKTRUTOhpsm9TQoyNeW
         4FYkMXnKTnrnNA+g5WfUJzyWI3/ajj5TJOcrTUAdJCOHij3Cnt0RlImqDgr0cSVS8kJO
         RwIg==
X-Received: by 10.66.102.4 with SMTP id fk4mr14275826pab.59.1400177438590;
        Thu, 15 May 2014 11:10:38 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id g6sm23990442pat.2.2014.05.15.11.10.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 May 2014 11:10:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-2-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249174>

Ronnie Sahlberg wrote:

> ref_transaction_create|delete|update has no need to modify the sha1
> arguments passed to it so it should use const unsigned char* instead
> of unsigned char*.

Obviously good.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
