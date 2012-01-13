From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC][PATCH v3] git on Mac OS and precomposed unicode
Date: Fri, 13 Jan 2012 16:56:00 -0600
Message-ID: <20120113225559.GA7343@burratino>
References: <201201132253.00799.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: tb <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Jan 13 23:56:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rlq2e-0005i4-Sw
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 23:56:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932977Ab2AMW4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jan 2012 17:56:09 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37072 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932936Ab2AMW4I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 17:56:08 -0500
Received: by iabz25 with SMTP id z25so4978299iab.19
        for <git@vger.kernel.org>; Fri, 13 Jan 2012 14:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=sK8OBWiNxHP6mwO1tC9oukJjy4f26VyiGcdzyiC1Xck=;
        b=MKONn2UTUpx4sN10cASI1K39dTPx9J2TyBMcnrt5AuWup/kI599kyYaUxsy4/N2Q5w
         5y+4fcRK1/cH7sqAMEv2wUSg9LiLLjQ1Rtlx1lgxBXwDtrCPpCgzD9b5/ywCngCSyX8O
         rjhdC35GJMZDr1nbHYCSf+fN60PXT0cJ+Yap4=
Received: by 10.43.47.135 with SMTP id us7mr2144775icb.31.1326495367619;
        Fri, 13 Jan 2012 14:56:07 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id he16sm33564200ibb.9.2012.01.13.14.56.06
        (version=SSLv3 cipher=OTHER);
        Fri, 13 Jan 2012 14:56:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201201132253.00799.tboegi@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188542>

Hi,

tb wrote:

> Purpose:
[...]
> Runtime configuration:
[...]
> Implementation:
[...]
> Compile time configuration:
[...]
> Implementation details:
[....]
> Thread safety:
[...]
> Auto sensing:
[...]
> New test case:

This information, to the extent that it is useful at all, belongs in
the commit log.  That is, the commit message should concisely say
everything a person would want to know when reading a patch, whether
reading it to review it for inclusion, to make sure it still works
when making a related change, to consider whether it is safe to
upgrade to a version including the change, to understand what is
happening when a bug is tracked down to be caused by that commit, or
for some other reason.

So please do not use a cover letter that separates this information
when sending a single patch.

> Changes since [...]

This kind of information that does not belong in the commit message
can go after the "---" in the same message as the patch.

I haven't read the patch yet, except to glance at it and see some
nitpicks I can mention later (e.g., source files should not #include
anything else before git-compat-util.h or cache.h), and the approach
seems likely to be sane; I'm mentioning this to help you present the
information in a way that can save myself and other reviewers some
trouble for the next round.

Thanks much for your work, and hope that helps.

Regards,
Jonathan
