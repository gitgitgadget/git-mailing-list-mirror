From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] document string_list_clear
Date: Fri, 12 Dec 2014 11:35:52 -0800
Message-ID: <20141212193552.GB29365@google.com>
References: <xmqq7fy0mx70.fsf@gitster.dls.corp.google.com>
 <CAGZ79kbk4SXEXKzn-V8c4zCQU8m8ub+VkKhmub-bFoLZT1WWpA@mail.gmail.com>
 <20141209201713.GY16345@google.com>
 <20141209202738.GC12001@peff.net>
 <20141209222337.GA16345@google.com>
 <20141210084351.GA29776@peff.net>
 <20141210091815.GA18372@google.com>
 <20141212091625.GA9049@peff.net>
 <20141212183114.GA29365@google.com>
 <20141212192417.GA21132@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 12 20:36:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzW0O-0001GJ-K9
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 20:36:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965383AbaLLTf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 14:35:57 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:54055 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756404AbaLLTf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 14:35:56 -0500
Received: by mail-ie0-f171.google.com with SMTP id rl12so7487032iec.16
        for <git@vger.kernel.org>; Fri, 12 Dec 2014 11:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NGtm6ZQ1qL9P9SP0OqWydfICm1mW20FkKKuiVcEOt9M=;
        b=lCHBrXcs17x0dlAfa3ww5evuuz7gnHf4VNi61M25QEwdw3yhkL4sd7n5Mz+t2JBVQF
         HN+QwYxOFICK7ddNhumf/+DQPavGR55a90+fdA3bTT0vUxdtUDL85x0cPBBMXd+6M1xI
         FvI00artVi7WPGlK0XSS2lJAXlNbcnNoHplg69m4KwFpMGJNSt+lCqKLm5E/UFLHYGGb
         yXBns3Rf7EmuhwLBcEpskrtifNxLLcjXgFHq7v3Q4Gam/QHHlC3GtpbhqfjZz3i7aoyH
         5vRLNmMqPaBjgg5uxNswg0rIDXWOwyudLVazSxMMLB268snHV6JpNakFIfUdzyPOWylh
         w/fQ==
X-Received: by 10.42.130.7 with SMTP id t7mr17299926ics.25.1418412955591;
        Fri, 12 Dec 2014 11:35:55 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:88f6:7c4b:61b7:9a92])
        by mx.google.com with ESMTPSA id w7sm1059328iod.8.2014.12.12.11.35.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Dec 2014 11:35:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141212192417.GA21132@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261364>

Jeff King wrote:

> I agree there are some formatting problems in the strbuf.h patch I sent
> earlier. I'm happy to fix them and resend, but I'm not 100% sure that
> fixing all the problems I see will not leave problems for you. I can fix
> them and you can review if you want. Or alternatively, if you have more
> drastic formatting or wording changes in mind, maybe it would make sense
> for you to take a pass?

For the sake of reviewability, I think the less that happens in a
single working patch, the better. :)

If I were doing it, I would first de-asciidoc within technical/ and
then move into the header in a separate patch.  Or first move with
asciidoc intact and then de-asciidoc in a separate patch.  Combining
the two into a single patch is also fine.  Please don't change wording
at the same time.

> I _don't_ want to commit to moving all of api-* into headers myself.

Yeah, I think that's fine.  Moving one at a time when people want to
do it doesn't hurt consistency at all relative to the status quo.

Jonathan
