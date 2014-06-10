From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v14 26/40] walker.c: use ref transaction for ref updates
Date: Tue, 10 Jun 2014 16:23:08 -0700
Message-ID: <20140610232308.GE8557@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
 <1402093758-3162-27-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 01:23:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuVNs-0007VY-Ae
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 01:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685AbaFJXXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 19:23:12 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:48364 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbaFJXXM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 19:23:12 -0400
Received: by mail-pd0-f177.google.com with SMTP id g10so6548561pdj.22
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 16:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=2cgGfwBee+QX06fNfapYG54vLYNlssoDlBjCc+jiajo=;
        b=BT4nKTIVRXwC9EPP3o5wGviwkT6uEkRMU8K7D5C3r9J867b3Q0Ny9gcMVYYolnSnZF
         VvVwdQCVrH6cYq2/gzWepRHWEUTEr2sY9QZrqmi/JBpe+6escjIyBh70KeNGEJAUL31z
         8kJiE3jM0q1lyz+TqtIignrCeX86mF2fCHseG5cVo+j1pbCjwraMT5hT/xgwJ8rz4QGv
         ZRK/882/WsAle0l8lKhnppRQxQkW6P1+VTLH7BDNrFT+cjpOi4hieuhcD9SWr28DgZJ7
         ZRFPn2Rbu81uOVmgXcVFcCALj9wqTVGoQQwlIN1gSNMPbLkMIEMNSkb2AMkdNCLLBWqI
         UpMw==
X-Received: by 10.66.65.225 with SMTP id a1mr8741822pat.139.1402442591597;
        Tue, 10 Jun 2014 16:23:11 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id qj3sm71402270pbc.91.2014.06.10.16.23.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 10 Jun 2014 16:23:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1402093758-3162-27-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251323>

Ronnie Sahlberg wrote:

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  walker.c | 59 +++++++++++++++++++++++++++++++++++------------------------
>  1 file changed, 35 insertions(+), 24 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
