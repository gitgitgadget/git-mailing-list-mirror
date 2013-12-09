From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] diff: don't read index when --no-index is given
Date: Mon, 9 Dec 2013 11:20:00 -0800
Message-ID: <20131209192000.GS29959@google.com>
References: <1386590745-4412-1-git-send-email-t.gummerer@gmail.com>
 <20131209151609.GA14841@google.com>
 <87siu1n8g6.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexey Borzenkov <snaury@gmail.com>,
	Ren?? Scharfe <l.s.r@web.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Tim Henigan <tim.henigan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Bobby Powers <bobbypowers@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 09 20:20:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq6NF-0002fO-KD
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 20:20:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932653Ab3LITUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 14:20:05 -0500
Received: from mail-yh0-f48.google.com ([209.85.213.48]:35731 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755939Ab3LITUE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 14:20:04 -0500
Received: by mail-yh0-f48.google.com with SMTP id f73so3054629yha.35
        for <git@vger.kernel.org>; Mon, 09 Dec 2013 11:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7yV2QJ1vJ2R3WTEuB2qto5WhFrw08v8U7L/hdcNGA1c=;
        b=dGLa28+RvP9taXAJtUszI9C/y0/sIHpgPOEC7HrkmikBDCkD0A3gn0iJQx/vUMS2c+
         pKdvXUOwuMAfV/xDIy1rvU1kUrXfg1wIrNYUfQHemu9Nk5pHYCa4yqyZ2vMs6kccLLj9
         8yGrNlDVzE2nuRQzHAfOvxtJeVzSkpRQPWbv+w1l/v7uR0Nf6M/hdF4vUBlca/Zrq9HU
         5OHkzFmWCPMzMbIrt2lekwGGU135TXWsyPnVx5784TKNbZhvnV54tl9AfYTHfZR8sEC0
         n7dcXofYuDq+/hhyut2E/Nl+MGudEAo5Ngnogc9ZJUymzZCcZ6NZdhcljfLdaPhVoWVj
         Rf3g==
X-Received: by 10.236.129.135 with SMTP id h7mr4275800yhi.75.1386616803907;
        Mon, 09 Dec 2013 11:20:03 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id q44sm18048225yhg.10.2013.12.09.11.20.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 09 Dec 2013 11:20:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87siu1n8g6.fsf@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239080>

Thomas Gummerer wrote:

>                                          For example I would take one
> version, use test-dump-cache-tree to dump the cache tree to a file,
> change the format slightly, use test-dump-cache-tree again, and check
> the difference with "git diff --no-index".

Makes a lot of sense.  Thanks for explaining.

Regards,
Jonathan
