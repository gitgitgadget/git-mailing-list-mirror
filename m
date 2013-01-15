From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 00/14] Remove unused code from imap-send.c
Date: Tue, 15 Jan 2013 12:49:32 -0800
Message-ID: <20130115204932.GB12524@google.com>
References: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jan 15 21:50:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvDSH-0000zC-W4
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 21:49:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756559Ab3AOUti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 15:49:38 -0500
Received: from mail-pb0-f41.google.com ([209.85.160.41]:57741 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755989Ab3AOUth (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 15:49:37 -0500
Received: by mail-pb0-f41.google.com with SMTP id xa7so273963pbc.0
        for <git@vger.kernel.org>; Tue, 15 Jan 2013 12:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=iv6zG4bLTvZud38xyiQcXQ+7filDupi6a+Y5xWsJEL8=;
        b=baHnjAjeoVEu0SEeAFbcYHDivHqFdrkDXnrUydEvYcEJ8GzLoTKoY/YnExjajAkzcH
         2GFb+hEJwF31iqBLaluwQfuLigeA6FJa8pw8Mx+4KyBtgKzhxeRVbgdKXBOS0EENGsMt
         IaSRXof4OInDYeHn6gptF9V2Wo1+P3izZH0qFFUPF+i4G7GVDG9iNqOLpAE7tAByxa2h
         gJ68WC1reEXv+kBy04EyC/4ga82arQ0MDezXYXeAtpShuJEIUQBSoY2eKg8pBsTAnM+K
         2XSW8pghhj03D3aYuRXHV3J2ar6ZjJdjCYSUIRotlr83b9dHp+ETO7i9CFFwukOadNxN
         t76w==
X-Received: by 10.68.242.3 with SMTP id wm3mr269437897pbc.44.1358282977191;
        Tue, 15 Jan 2013 12:49:37 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id i5sm11462931pax.13.2013.01.15.12.49.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 15 Jan 2013 12:49:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213675>

Michael Haggerty wrote:

>  imap-send.c | 308 +++++++++++-------------------------------------------------
>  1 file changed, 55 insertions(+), 253 deletions(-)

Patch 14 is lovely.  Except for patch 6, for what it's worth these are
all

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Nicely done.
