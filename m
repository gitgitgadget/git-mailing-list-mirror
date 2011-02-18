From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] Move libgit.a sources into a libgit/ subdirectory
Date: Fri, 18 Feb 2011 11:31:25 +0700
Message-ID: <AANLkTinH8wmxwwMhqNr1YZ-mpQEM1ufQa0AyDxxaR+4c@mail.gmail.com>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org> <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie> <20110218023126.GB23435@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 05:32:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqI0f-0000Rp-Rv
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 05:32:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810Ab1BREb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 23:31:57 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40973 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218Ab1BREb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 23:31:56 -0500
Received: by wwa36 with SMTP id 36so3365260wwa.1
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 20:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=pUAw6ufrpcDgoCfVrEqn5OgtLovQf5UxkJW6eB1RVgU=;
        b=S4Ck+7iqI9DfzPQS1cjfCSmZ+P3WRzb/FQGc8/7vxvHBHeXaxU3clUsqp+t13LpG1W
         rHwPlNrkG8n0Z9FFTBZolpV9wt7uXK7ZmdNhbh06/ynIklW/8JqAiYo0zhEdC2KbNmNr
         vBFv9y9SVamerqTDp8rb4vt4xk8/1t9xsNd+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=TR1CTJJKYTrXH3v2s3UKYtHKNNjdTTVJJpjE1KOPSEa/qjYkd+VPshxjJOuZzOirLd
         hLhvujCtjytrOIxjxMZFQmjRUrJyEtYHPZ4FKHj6iYIBr/ztTs6AJf3k2rLpdPVg09fq
         a/T/Gy4yDDgR0/Hxjh9i3dhRhtoV8QM8HZeM4=
Received: by 10.216.186.144 with SMTP id w16mr207785wem.13.1298003515169; Thu,
 17 Feb 2011 20:31:55 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Thu, 17 Feb 2011 20:31:25 -0800 (PST)
In-Reply-To: <20110218023126.GB23435@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167166>

2011/2/18 Jonathan Nieder <jrnieder@gmail.com>:
> Perhaps some day the libgit/ subdirectory can be managed as an
> independent subproject (for example if it gets merged with libgit2).

Another note. The boundary between libgit and "git" binary is not
perfectly clear. For example transport.c can make fetch_pack() call,
which resides in builtin/fetch-pack.c. But this is a good move anyway.
We can gradually move all shared functionalities to libgit.
-- 
Duy
