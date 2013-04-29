From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] mingw: rename WIN32 cpp macro to GIT_NATIVE_WINDOWS
Date: Sun, 28 Apr 2013 22:11:00 -0700
Message-ID: <20130429051059.GC8031@elie.Belkin>
References: <517C29BE.6050002@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Apr 29 07:11:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWgMu-0000MM-5q
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 07:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062Ab3D2FLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 01:11:08 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:56346 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038Ab3D2FLH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 01:11:07 -0400
Received: by mail-pa0-f48.google.com with SMTP id lb1so1541640pab.21
        for <git@vger.kernel.org>; Sun, 28 Apr 2013 22:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=gX6opvgjxYDSLI5TFZgbBxtoeiQng2hp1zwfF8g7CZE=;
        b=C7e8TeWLcR1G/7n3gx9z50FmCDvsES69vhYyUgi+WG2Gth36wKLFK75Li5uZ6oKdDd
         5JOGv+IeRfxSqw1NFaE55mZNbK0QCeAdRmSS8tNzKERigBYUzEMB1s92qFr+EqYV6QJ4
         dCtCsAR9tmkMeWk0S5IyGLkQb9IH/iVvVF9nyTPeSRO2TQX1eHeUNId65e27emBa4SAf
         I3qjJtSADnyi+XaAP8mNpcY0PEQ6/QFTbWu7P5uDjCMhNFjiqC02uwtKgf30NSX5WCvz
         ljv2l4z0RQMrRtkJ3/xvfJOT8I4cqo/5HcRPXWdEBb+3FCdRmDjZKXXPJy3xF4ITyBbz
         tW7w==
X-Received: by 10.68.245.6 with SMTP id xk6mr69397546pbc.41.1367212265840;
        Sun, 28 Apr 2013 22:11:05 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id kd7sm22441707pbb.34.2013.04.28.22.11.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 28 Apr 2013 22:11:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <517C29BE.6050002@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222768>

Ramsay Jones wrote:

> After this change, it should be possible to drop the
> CYGWIN_V15_WIN32API setting without any negative effect.
>
> [rj: %s/NATIVE_WINDOWS/GIT_NATIVE_WINDOWS/g ]
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

Yay!  Thanks for finishing it.

For what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
