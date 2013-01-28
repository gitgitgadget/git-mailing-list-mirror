From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 02/11] commit, cherry-pick -s: remove broken support
 for multiline rfc2822 fields
Date: Sun, 27 Jan 2013 17:29:54 -0800
Message-ID: <20130128012954.GE8206@elie.Belkin>
References: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
 <1359335515-13818-3-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 02:30:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzdYG-00035a-14
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 02:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756977Ab3A1BaC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 20:30:02 -0500
Received: from mail-da0-f41.google.com ([209.85.210.41]:42553 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755670Ab3A1BaA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 20:30:00 -0500
Received: by mail-da0-f41.google.com with SMTP id e20so986288dak.14
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 17:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=/EST7xwH7WhWu5+eflTa1h5NjASB44TxSBbCIpSsx8Y=;
        b=hu1tzjN6b2urJ6krWTqOQXgDm/rxhnzV3gJuQ4E3cQnGQkBtx71Dg9Y+1a6bI+ZopD
         YMyA+cc/ejucAElMhrXh61KOKIp0zu9mBvFg2EotyYc8CTLhwkGMafAFTSH/pxn+WoFn
         vs2PgK3gTg2FU9liFb3aL1hPdTjQLF+mWtZQaCDq8jBhoLCx+6mo30aOUsugvKaXPD16
         1s9ARenstHi94+0G8QukEfQgp7aQdVLoC5H2Br8ARR1Lv02XRi+MXBhXNfS6YJbpWFeA
         Saq0A6g8pRxhykaek4U3qGqZKqt2H03nSvyQngFIrBQNKc+KSMs4oGwM1qX1HwJubLL8
         ty9A==
X-Received: by 10.68.227.41 with SMTP id rx9mr33378530pbc.121.1359336600267;
        Sun, 27 Jan 2013 17:30:00 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id t7sm5640442pax.17.2013.01.27.17.29.58
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 17:29:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1359335515-13818-3-git-send-email-drafnel@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214782>

Brandon Casey wrote:

>  sequencer.c | 6 ------
>  1 file changed, 6 deletions(-)

Nice simplification.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
