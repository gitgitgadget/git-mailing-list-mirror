From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3 06/11] Makefile: split GIT_USER_AGENT from GIT-CFLAGS
Date: Wed, 20 Jun 2012 16:21:35 -0500
Message-ID: <20120620212135.GE6142@burratino>
References: <20120620182855.GA26948@sigill.intra.peff.net>
 <20120620183151.GF30995@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 20 23:21:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShSLR-00061l-Q3
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 23:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758096Ab2FTVVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 17:21:42 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:55452 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754629Ab2FTVVl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 17:21:41 -0400
Received: by ghrr11 with SMTP id r11so6090370ghr.19
        for <git@vger.kernel.org>; Wed, 20 Jun 2012 14:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=mITrxqbb5PCRcntqXZnSdMEHaMgZafJbCJHmVNAbNFk=;
        b=la0X2XPiAQoH8Q7A7IPgjIcMGLRBNN3qm6gxfnDTchH61UVomuoXgFtL72h6ye8i5T
         erBBr+AHJXy1VFBURbBO1y3jdB+lJ3hdNrNlHk6PH/+Qr2BuwhO6axFhbsy0lcTwIKCR
         w8g+XchQr04VlcYNZz2xRvs77+laQg+uzAqK7+Vg39+w9kYXs8j8OkJ2yD4paeNexpio
         K3SwS5DM5JJ4QXkoDa73qmBVMFmVfwcgVOF1Zj26kSS0UiHcObx3oWUb2mJhIHLL6X3T
         tmyCKomjd/jAceQI6XkrvHjYL20h6+CK20SuMJmvNgzNgJE61ruEd5wPhrtJhpExI2Kq
         lFlg==
Received: by 10.100.244.19 with SMTP id r19mr9219961anh.48.1340227300757;
        Wed, 20 Jun 2012 14:21:40 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id a34sm99022308yhh.0.2012.06.20.14.21.39
        (version=SSLv3 cipher=OTHER);
        Wed, 20 Jun 2012 14:21:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120620183151.GF30995@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200365>

Jeff King wrote:

> +	@if test x'$(GIT_USER_AGENT_SQ)' != x"`cat GIT-USER-AGENT 2>/dev/null`"; then \
> +		echo >&2 "    * new user-agent flag"; \

Micronit: the term "new user-agent string" would be clearer.

Re the lack of _HTTP: interesting.  Is the plan to use this for
other protocols, too?

Looks good.
Jonathan
