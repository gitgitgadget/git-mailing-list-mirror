From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/2] log/ format-patch improvements
Date: Wed, 25 Aug 2010 14:14:21 +0530
Message-ID: <20100825084416.GC3280@kytes>
References: <1282422531-29673-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 25 10:46:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoBct-0003Xl-HJ
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 10:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281Ab0HYIq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 04:46:26 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49322 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145Ab0HYIqY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 04:46:24 -0400
Received: by pwi7 with SMTP id 7so192434pwi.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 01:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=R0LiXH7t51N6u4n/bmbaOtaJvc7uC37GsH2C4WtXSps=;
        b=mBSbGOXlgNv66jPk8pRXnX+4NMiFNWlr9ukw3mrkCy9PcFUzyWK6/deiOSVY464V6E
         RFnN/izkJ+K0PH9ELI6ya/Qeerr6LpnUguPgo4MHswvVU8IYZdR0FlfES2zRn8NI7lYq
         qeWvb1/jrDGz3To2ZFgZFD+V8nNOMuRP4IEqA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=utci1xiJ9SXsbp1wQnwDPDOTOpC62736MK2fDIwKwve7jGOvLfdIq1c8YFlFkwn9Kr
         RF1YPP8+ZNAxX2RHj/5rpyNAloZjR/SGZpRqIBF0gTJF6txyuVnKQQw8EyDDh4RY8XrY
         QsSosXBehu95RVE66dBZOpbS3nmOz+ZpSgWjg=
Received: by 10.142.144.2 with SMTP id r2mr6788946wfd.259.1282725983619;
        Wed, 25 Aug 2010 01:46:23 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id y16sm1220569wff.14.2010.08.25.01.46.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Aug 2010 01:46:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1282422531-29673-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154435>

Hi,

Ramkumar Ramachandra writes:
> The first patch implements Jakub's suggestion. Arguably, it's slightly
> complicated- it took me more than a few minutes to do the math with
> `nr` and `nr_i`.
> 
> The second patch clarifies the meaning of the `-<n>` option. We should
> also probably force the mutual exclusivity of `-<n>` and <revision
> range> to avoid confusion.
> 
> Additionally, thanks to Thomas for drilling into me the fundamental
> difference between -<n> and a revision range (on IRC).
> 
> Ramkumar Ramachandra (2):
>   git-format-patch: Print a diagnostic message when ignoring commits
>   log: Improve description of '-<n>' option in documentation
> 
>  Documentation/git-format-patch.txt |    2 +-
>  Documentation/git-log.txt          |    2 +-
>  builtin/log.c                      |   42 ++++++++++++++++++++++++++---------
>  3 files changed, 33 insertions(+), 13 deletions(-)

Do you see value in this patch or is it just unnecessary baggage?

-- Ram
