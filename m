From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/6] prune_remote(): iterate using
 for_each_string_list_item()
Date: Sat, 22 Nov 2014 13:19:10 -0800
Message-ID: <20141122211910.GF15320@google.com>
References: <1416423000-4323-1-git-send-email-sbeller@google.com>
 <1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>
 <1416578950-23210-7-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Nov 22 22:19:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsI5G-0003mY-MJ
	for gcvg-git-2@plane.gmane.org; Sat, 22 Nov 2014 22:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718AbaKVVTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Nov 2014 16:19:06 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:40113 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602AbaKVVTF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Nov 2014 16:19:05 -0500
Received: by mail-ie0-f175.google.com with SMTP id at20so6746962iec.6
        for <git@vger.kernel.org>; Sat, 22 Nov 2014 13:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UMUzKdzyNsqfTrnZJ2oBXCNs4u+hahWCd97+Oz+UxyM=;
        b=dlL6YUrwCJ5sqkP0SmLwhLJK8ZS7BLipgVmwlSM2ycuk8zxQvoFI92Yc0KC09DRVDy
         9UBlLhxDWjv7p+gW0SNG/wPDEGitG+xVvomqLz8zqdPbOuSXvR3wqc5gVe0V4r6nyy1A
         WRrV+VEZmufeS2xEK7TGEpR2qqKxpCybVi7FNpXRRjcBJkzcqr/Je8+cwVDh+AhHGxgs
         gtF0noP/EYCSwT4oVxCfbswxdpZuae6n8hWfBdbzCQjaDNZjGuiLJI285QtJU0tJ48Fs
         D59V3KRbcLRuuYEzjU2ayWADJhHbMXkm4QsFOOInZpHuS7WWaNkSaMEsKuuvgu+JwkVf
         ArKQ==
X-Received: by 10.107.132.78 with SMTP id g75mr10938716iod.21.1416691143919;
        Sat, 22 Nov 2014 13:19:03 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:8d62:add2:ab4d:c706])
        by mx.google.com with ESMTPSA id vf6sm1898227igb.6.2014.11.22.13.19.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 22 Nov 2014 13:19:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1416578950-23210-7-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260080>

Michael Haggerty wrote:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  builtin/remote.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

(That makes 6/6. :))

Thanks for your thoughtfulness in putting these together.  They were
pleasant to read.
