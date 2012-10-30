From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 4/4] fast-export: make sure refs are updated properly
Date: Tue, 30 Oct 2012 14:38:28 -0700
Message-ID: <20121030213827.GM15167@elie.Belkin>
References: <1351617089-13036-1-git-send-email-felipe.contreras@gmail.com>
 <1351617089-13036-5-git-send-email-felipe.contreras@gmail.com>
 <CAGdFq_j1RROOwxDi1FfJZJ6wiP9y9FWzSpc7MXVSvRmgk0sF9A@mail.gmail.com>
 <CAMP44s3MHrG_XeZEodnxemrW-V18+NHnFvi7koyx9mH8XuHc6w@mail.gmail.com>
 <CAGdFq_jJwZMLq=3co13hs7gas6y9kZRTKwcT+CP=n6-24Uv5Og@mail.gmail.com>
 <CAMP44s2QwdZKqJq0BZ5HOtZYiCMxCxycui9EmxxfL+Sa6M_6+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, ">" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 22:38:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTJWJ-0003GG-6H
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 22:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934700Ab2J3Vie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 17:38:34 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:54637 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab2J3Vid (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 17:38:33 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so456579pad.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 14:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=g1/CxnjxPcULw/8G5WHJeZEEtZJ1s/dXZUC9z+n95CI=;
        b=EeyCfHXqi1kjQQraJ/mbYvk4AXigzoLVnAicN42S79opV1GCXgzk6D5nVkQKzzdkPO
         uqP8pAuFEh/r9gDmnBSkzJiC6arZBFLEmUXApAEwz332DBP/ZiqHYconlTsg/AiNlNH9
         5q2nmWcmg750L3D6rrsyLIC3qZ9tEQZtjos0uNXt4tJcT3qOAH5wdaD+MT4jisbbPS95
         Fggvx0Nr/qhEJxiOXAqYo3i5LfRCbcZL+h081llb4HyVN0THPk1rGCcbkgfomSxPfJj/
         KVaLj5305wooMCq5401Ycbm6qW4KzuEeXySL5blBLWnyKNHdpyF26JRNYTtMhTTqxW0v
         ELcQ==
Received: by 10.68.200.193 with SMTP id ju1mr48560127pbc.53.1351633113398;
        Tue, 30 Oct 2012 14:38:33 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id wg3sm1109300pbc.28.2012.10.30.14.38.31
        (version=SSLv3 cipher=OTHER);
        Tue, 30 Oct 2012 14:38:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s2QwdZKqJq0BZ5HOtZYiCMxCxycui9EmxxfL+Sa6M_6+g@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208746>

Felipe Contreras wrote:

> % git fast-export $marks_args one
> % git fast-export $marks_args one two
>
> Then yeah, 'one' will be updated once again in the second command,

That's probably worth a mention in the commit message and tests
(test_expect_failure), to save future readers from some confusion.

Thanks,
Jonathan
