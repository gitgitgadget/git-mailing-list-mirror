From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 4/4] fast-export: make sure refs are updated properly
Date: Tue, 30 Oct 2012 23:05:29 -0700
Message-ID: <20121031060529.GA30432@elie.Belkin>
References: <1351623987-21012-1-git-send-email-felipe.contreras@gmail.com>
 <1351623987-21012-5-git-send-email-felipe.contreras@gmail.com>
 <20121031003721.GV15167@elie.Belkin>
 <CAGdFq_jNM_48muXJ0BX2ehC=k8T9GLui_QtRO8D8C7h6b5jyHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 07:05:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTRR1-0007as-4C
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 07:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822Ab2JaGFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 02:05:39 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39254 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194Ab2JaGFi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 02:05:38 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so734147pbb.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 23:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=iH94dqpzuJrEn22G9/yvjLx6LN0SxIJOZxt0Bt0gHuQ=;
        b=aN8ssDlIVAS+MoHVsggpBVfm3Z50Xi3Tv4pQH5UyNtUo9JU63oJby5zxLY1y9gkkxD
         b3+iWSdt1fHw5usAoVKHct8Fnrhcgz/sXXL9lRyLBjT76N6LO6tiwcLdGUYE8u/8rMSi
         DgNrxv3x7e2Z+A5zgA87cKsIqOZPwhdGMDPI/qZmee5m5E54QO1PXGKdJ5fEeIyDZe5v
         o0nvJ92OtJwqOtNvm1LBCv9WzxUrv0y/YX1BgwDrfDN9Yez+B4qkiJ8RNvC8csQxoy/D
         ufdEsQzK+7LNLTQKIfX9eCkMRrAZFkXqRTiRrQ/i0hY7t4tgJ09cBtvh/Gv9EkbyNAM4
         P6tw==
Received: by 10.68.226.167 with SMTP id rt7mr110435079pbc.94.1351663537619;
        Tue, 30 Oct 2012 23:05:37 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id c7sm1656405pay.10.2012.10.30.23.05.35
        (version=SSLv3 cipher=OTHER);
        Tue, 30 Oct 2012 23:05:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAGdFq_jNM_48muXJ0BX2ehC=k8T9GLui_QtRO8D8C7h6b5jyHg@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208796>

Sverre Rabbelier wrote:

> Thanks for the thorough explanation. Perhaps some of that could make
> it's way into the commit message?

It's fine with me if it doesn't, since the original commit message
covers the basics (current behavior and intent of the change) in its
first two paragraphs and anyone wanting more detail can use

	GIT_NOTES_REF=refs/remotes/charon/notes/full \
	git show --show-notes <commit>

to find more details.

Thanks,
Jonathan
