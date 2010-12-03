From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] Fallback on _NSGetExecutablePath to get the executable path if using argv[0] fails
Date: Thu, 2 Dec 2010 23:50:03 -0800
Message-ID: <CC3783DE-FE16-45E5-B53B-EC8AA133B876@sb.org>
References: <051964C9-0507-4CCB-A111-55CA36652F00@apple.com> <AANLkTimwRJqje1-HhzKj-L-5-2CvhTC0+Pr0Cvj7d_kc@mail.gmail.com> <20101129171211.GL8037@burratino> <7534C13D-A52A-4BA4-B8C5-14E17CFA0351@sb.org> <20101203074259.GB18202@burratino>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Thiago Farina <tfransosi@gmail.com>,
	Jeremy Huddleston <jeremyhu@apple.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 08:50:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POQPI-0004aj-2i
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 08:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756627Ab0LCHuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 02:50:08 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60052 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755846Ab0LCHuI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 02:50:08 -0500
Received: by ywl5 with SMTP id 5so4620215ywl.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 23:50:07 -0800 (PST)
Received: by 10.146.167.13 with SMTP id p13mr530964yae.1.1291362607388;
        Thu, 02 Dec 2010 23:50:07 -0800 (PST)
Received: from [10.0.1.14] ([24.130.32.253])
        by mx.google.com with ESMTPS id x42sm914908yhc.18.2010.12.02.23.50.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Dec 2010 23:50:06 -0800 (PST)
In-Reply-To: <20101203074259.GB18202@burratino>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162766>

On Dec 2, 2010, at 11:42 PM, Jonathan Nieder wrote:

> Kevin Ballard wrote:
>> On Nov 29, 2010, at 9:12 AM, Jonathan Nieder wrote:
> 
>>> The section "2) #ifdefs are ugly" of
>>> linux-2.6/Documentation/SubmittingPatches explains the rationale.
>> 
>> Might this be worth pulling into git.git/Documentation/CodingGuidelines?
> 
> Yes, the example there includes good advice I wish I had received
> sooner, and Documentation/CodingGuidelines seems like a good place to
> help people find it.  Do you have some wording in mind?

Not particularly. It just seems that if we're going to point people at the
linux-2.6 documentation, then what we're referencing should be pulled into
our own docs. It's not reasonable to expect people to read the documentation
from another project to find out what they should do in this one.

-Kevin Ballard
