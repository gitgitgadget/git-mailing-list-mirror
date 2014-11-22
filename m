From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/6] prune_remote(): rename local variable
Date: Sat, 22 Nov 2014 13:18:05 -0800
Message-ID: <20141122211805.GE15320@google.com>
References: <1416423000-4323-1-git-send-email-sbeller@google.com>
 <1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>
 <1416578950-23210-6-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Nov 22 22:18:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsI4C-0003Fl-E7
	for gcvg-git-2@plane.gmane.org; Sat, 22 Nov 2014 22:18:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681AbaKVVR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Nov 2014 16:17:59 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:34888 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602AbaKVVR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Nov 2014 16:17:59 -0500
Received: by mail-ie0-f176.google.com with SMTP id ar1so6907395iec.21
        for <git@vger.kernel.org>; Sat, 22 Nov 2014 13:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0EjaF14PK3s+4QXtHod1ccSSYln+xIPWEZENvWVquF4=;
        b=tytpXY+HzBocCbiand4RXqD2nIhRRNgeTzumr2jtw2mf/m/UUsYWe+PGPizKkgnux8
         X+zTAYXYSV01bsV7yVjzta6p0rW4XhlQ2Q6WB6RhUUE52+wa7FuGPFxJ6ud4yyZeCut8
         IzIR0bajO3QHnSbuYX5cy3hI6yRHQO/2pjc0fnfIuLNy+mL32M5s++r/HLCPAoQCtSS9
         nlCxOaoEhH22zM3YW6ZTxoKEDUydUdLqcL2NHITK8r4UyyeA5uwICtFc4e8YACDtecdK
         E5V+8ULpdF9W5JEEN12BdfyYSvb4UvIrLqsThPRbh1wuzKYHx5HSm+O3LXCsiOK6HCLt
         jIJw==
X-Received: by 10.43.141.67 with SMTP id jd3mr18682901icc.24.1416691078671;
        Sat, 22 Nov 2014 13:17:58 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:8d62:add2:ab4d:c706])
        by mx.google.com with ESMTPSA id a4sm1889345igx.10.2014.11.22.13.17.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 22 Nov 2014 13:17:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1416578950-23210-6-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260079>

Michael Haggerty wrote:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  builtin/remote.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
