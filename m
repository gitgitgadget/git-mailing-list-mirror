From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 06/19] refs.c: make update_ref_write to return error
 string on failure
Date: Fri, 25 Apr 2014 15:45:07 -0700
Message-ID: <20140425224507.GE9218@google.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
 <1398442494-23438-7-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 00:46:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdotQ-0001lA-Ri
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 00:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbaDYWpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 18:45:14 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:56849 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229AbaDYWpL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 18:45:11 -0400
Received: by mail-pd0-f179.google.com with SMTP id g10so3622040pdj.10
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 15:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=tMvMvpi6VUXQ122+ZEomMrCd0Q7IPoZgppZIP+zob+s=;
        b=Sf1bviNdMnXRw//1lyltRWQP1peHLzC6+Z5aWIdfH2XxbH7IdT9doeAuSLWUq8w0A2
         6O9wvynfDp2skTNkvlJ1AIE+l3xxBCzP1zSU5ezqBH13vCIs2dutMuFmHsuC8o4FKUOM
         gsK7pAcSqOfhji1IjzIzHtK62ht0nXI2q/AVnbtjovqrfnNZbTpQSrGPzr7C2d5GWTO1
         6Q8V3t0ammKLlHwpZgOwwmmbxwXyqJtETpr/vg+DThOhQ+F4iCQdEFet3NBJMqmCsmAo
         GtyXmIEIrZx8XCjMcVjzxTSzqRHdZmORBqFmtwNu+ZSRzRqoTA/eZtDQaTLI3c8xQwip
         eCRA==
X-Received: by 10.68.184.66 with SMTP id es2mr14298492pbc.19.1398465910379;
        Fri, 25 Apr 2014 15:45:10 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id x5sm18335655pbw.26.2014.04.25.15.45.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 25 Apr 2014 15:45:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398442494-23438-7-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247122>

Ronnie Sahlberg wrote:

> Change update_ref_write to also return an error string on failure.
> This makes the error avaialbel to ref_transaction_commit callers if the
> transaction failed dur to update_ref_sha1/write_ref_sha1 failures.

Nits:

 * available
 * during

Probably should come right after or before patch 3.  Same nit as patch
3 about using asprintf or passing in a pointer to strbuf.
