From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v3 2/6] fn_out_diff_words_aux: Use short variable name
Date: Mon, 5 May 2008 00:39:22 +0800
Message-ID: <46dff0320805040939t6290ed1dsad79d8de99c7cdde@mail.gmail.com>
References: <1209815828-6548-1-git-send-email-pkufranky@gmail.com>
	 <1209874815-14411-1-git-send-email-pkufranky@gmail.com>
	 <1209874815-14411-2-git-send-email-pkufranky@gmail.com>
	 <1209874815-14411-3-git-send-email-pkufranky@gmail.com>
	 <alpine.DEB.1.00.0805041047220.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 04 18:40:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JshG1-0000y4-6x
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 18:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534AbYEDQjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 12:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753597AbYEDQjZ
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 12:39:25 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:3909 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365AbYEDQjY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 12:39:24 -0400
Received: by an-out-0708.google.com with SMTP id d40so471209and.103
        for <git@vger.kernel.org>; Sun, 04 May 2008 09:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=HUrCeL9DsvsFr0CD6n4VPkc79XiEp5CQXLKXz3vwdLk=;
        b=q345dr3i8s7GHFrjQNAffGsaUb0V+O5IZtrM7lhUaFCeDYMq+Be0E9Z8gBZ+W7zZxosGFwI+CwWyJto1etFfKxi0ynkcYYbBBrtBcC/hhhoZdOEEakM9Wt95Z698UUqdEC1UpaJPgYsA7nofOfkLIlD4F+7QL/aV9nMjh0kL34w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n3c6+WHKHlQs5F6BGbk3dXSD8sjs9bWw+2IaJRqM+wvrqWbWosurim0gRXdJYR129AMTIth6bNSU3IOGsP8xYC50OYULHEEyexR+P+lp1uadritmqtwF7jTz1bQyUbEc/Hf1ur5uWVQvX9BCAZYOR3KHvebTD35myBP09/cq0hA=
Received: by 10.100.47.13 with SMTP id u13mr6712502anu.125.1209919162876;
        Sun, 04 May 2008 09:39:22 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Sun, 4 May 2008 09:39:22 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805041047220.30431@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81186>

On Sun, May 4, 2008 at 5:47 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>  the use of this patch evades me.  Care to defend why it is necessary?
>  Preferably in the commit message?
>

In fn_out_diff_words_aux, we use diff_words->plus in so many places.
So just use shorter name to save typing and avoid typo.

-- 
Ping Yin
