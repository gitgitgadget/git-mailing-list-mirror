From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v14 25/40] fast-import.c: use a ref transaction when
 dumping tags
Date: Tue, 10 Jun 2014 16:22:09 -0700
Message-ID: <20140610232209.GD8557@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
 <1402093758-3162-26-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 01:22:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuVMu-0006hP-HM
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 01:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbaFJXWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 19:22:13 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:62538 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbaFJXWM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 19:22:12 -0400
Received: by mail-pa0-f54.google.com with SMTP id rd3so1197489pab.41
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 16:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=tySQF9sMv7rTutLxdZYuakkTLHqViz+a32OXKm5gDL0=;
        b=0BTVbcUhD6bubu4FHPUeLoAnyPLVF4S6jkk3uN3wMlmdHmlo4tCne1QZ3LsLd5MM1M
         bo98Jqg03feIrfvm2G4nfFDlglg4foS1PgDES/0ACDnnOIvCOIWdyhVnFwn/zr/lyvam
         FakkHzjTitNs34NkAwIH1AJiU34v5rKzUGoG+sOwudfjHhdEUSmwJq1kdWafXrDNs7tX
         eFe5wbhs0+4MNlUeCglSGVRn0Xo8oPabiaf6L8ZNIQ7EurixIxvNsSIVwGjSNBHfcnvq
         P3qBk7LYh9JgTmA2TRk0wOXYK9iLBUYrqvNqgA66IvVJwCrK7tipFrPhQhFcjWRtEVRU
         7+hw==
X-Received: by 10.66.233.73 with SMTP id tu9mr8849498pac.78.1402442531853;
        Tue, 10 Jun 2014 16:22:11 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id av2sm71504797pbc.16.2014.06.10.16.22.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 10 Jun 2014 16:22:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1402093758-3162-26-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251322>

Ronnie Sahlberg wrote:

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  fast-import.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
