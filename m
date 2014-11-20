From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] refs.c: make ref_transaction_create a wrapper for
 ref_transaction_update
Date: Wed, 19 Nov 2014 17:10:39 -0800
Message-ID: <20141120011038.GB6527@google.com>
References: <1416433224-29763-1-git-send-email-sbeller@google.com>
 <1416433224-29763-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, sahlberg@google.com, git@vger.kernel.org,
	mhagger@alum.mit.edu
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 02:10:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrGGe-0003wn-8q
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 02:10:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756502AbaKTBKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 20:10:36 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:61658 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756278AbaKTBKg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 20:10:36 -0500
Received: by mail-ig0-f178.google.com with SMTP id hl2so1991549igb.11
        for <git@vger.kernel.org>; Wed, 19 Nov 2014 17:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=uN+jQNyZLNLFwaYdvm473csmr1sGJkwbIyxqtV7Eo/w=;
        b=y6HnjvfZcpAkyfv3fxuPwZ88HyUoVikhXFFBssoZC11kqn9IJ58xh/HEY8oPmwnx1N
         /IGOXK3g9dDErz+RUEkhXAw1/EoArC5lfe35wzF7Wq3+zC1As8qJrARDYB49xf2k+OS5
         u+jHXCXBofoIHvq9H8lublKjlm+jb5r2G0CGfFhaojkeLN9+YzywBwTWEmPQIkeaawbG
         3nSZGtU1ciL2z4mhcqbQfyMMNoNSRY6FNXSSiMqBScHelVUaJhBCXIIvlMBiXW7emmv3
         0qd5Wtngf25WV/MuPTTPcObkLZXzQxuvJGFNGI+oKN7fG3IPm8EdV0KoiwALmE9d3w6c
         z7xw==
X-Received: by 10.107.12.34 with SMTP id w34mr14345784ioi.3.1416445835351;
        Wed, 19 Nov 2014 17:10:35 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:31da:72d3:8c17:80bd])
        by mx.google.com with ESMTPSA id ih10sm1734789igb.6.2014.11.19.17.10.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Nov 2014 17:10:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1416433224-29763-2-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> From: Ronnie Sahlberg <sahlberg@google.com>
>
> The ref_transaction_update function can already be used to create refs by
> passing null_sha1 as the old_sha1 parameter. Simplify by replacing
> transaction_create with a thin wrapper.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  refs.c | 27 ++-------------------------
>  1 file changed, 2 insertions(+), 25 deletions(-)

I feel a bit ashamed to have my sign-off peppering all these patches
that I didn't have anything to do with except preparing to send them
to the list once or twice.  I'd be happier if my sign-off weren't
there.

Except for that,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
