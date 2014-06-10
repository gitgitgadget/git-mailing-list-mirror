From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v14 16/40] refs.c: add transaction.status and track
 OPEN/CLOSED/ERROR
Date: Tue, 10 Jun 2014 15:53:27 -0700
Message-ID: <20140610225327.GB8557@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
 <1402093758-3162-17-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 00:53:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUv8-0008Lv-Fx
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698AbaFJWxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:53:30 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:35269 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbaFJWx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:53:29 -0400
Received: by mail-pb0-f52.google.com with SMTP id rr13so6754221pbb.39
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=v4rhnG7SSz2yCzEbwwjNNU3xh+ZT3aV+Z/mHAdGmC0A=;
        b=Hz4nspgnBIpNN4E10oBvxAQd+5mhvOAeoJEc9UebD8QSUYHVcLHMVf+qhY07joKYGC
         XzQgCzQQY7KpXa165prrIWCR/6ZkQFDR7yvUEJCDaFqVtfsTKY1ddQi9aqoff7cDvOQX
         cV7gpX1Ilj9lYmZKe1yWAk/CFUeSFLtGpo92Pf0wSRgEhBWpyAyK4pdLxv1X4W+vskp9
         m4wFzWkJf4HgrgSZsgU+gdcA+8nlUC5S/A2PAHWuDMEWRfEG1qK8+KqqLTGq4hVhgsht
         OMHQe58bW4p4PNuLDnVbZRbfzrQk+b/6u4CDzZGuiD0tkuXb4pbzJbZeq/8C4tn1fO3Z
         5bEQ==
X-Received: by 10.68.231.196 with SMTP id ti4mr203436pbc.48.1402440809511;
        Tue, 10 Jun 2014 15:53:29 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id oa3sm71435579pbb.15.2014.06.10.15.53.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 10 Jun 2014 15:53:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1402093758-3162-17-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251320>

Ronnie Sahlberg wrote:

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

This makes the API pretty strict, which should make it easier to
experiment later if operations on closed transactions turn out to be
useful.
