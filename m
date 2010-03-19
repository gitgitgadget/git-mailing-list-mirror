From: Michael Witten <mfwitten@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Fri, 19 Mar 2010 06:09:34 -0600
Message-ID: <b4087cc51003190509y6ce7ad9dy992254cfe6ac2fb3@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <4BA338C1.7030803@alum.mit.edu> 
	<b4087cc51003190439x3c9ff269g35d11432bd2a3d60@mail.gmail.com> 
	<alpine.DEB.2.00.1003190441530.3821@asgard.lang.hm> <20100319115445.GA12986@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: david@lang.hm, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Mar 19 13:10:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsb1h-0004ma-0w
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 13:10:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926Ab0CSMJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 08:09:57 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:8682 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607Ab0CSMJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 08:09:57 -0400
Received: by fg-out-1718.google.com with SMTP id l26so424194fgb.1
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 05:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=WxPxUHa39N8lJqwMkYcfQNi0sIkWw1l9y21qa/wcnUw=;
        b=macwuGGPzt6rhuqykHh6nKsLbo8AlyS8xbsUYv52OHgXYNjPZk9yjnFPJnujECJMx9
         vtXZOxO6yGcgJsL/nKmjbiACjczwQupMtcQP3J3vBO/bwH7ZX+FrYPp3eCqHCqjgw25j
         HR50yH0Btt99D9LLzvOxtPeKLUZpZNRfqOqew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=YiXq8NLbAgMTQubkgiDNviG7as4+8svgGe7R/zHSqVCkFeddveXih/yx1CbI1+Yf/v
         OyJVLi/Af9D2O0kOD9YR/gB7LkqL1xG9pV1V2m7ID73tmGH/NSxPG1IP4FeEuJh1A5wO
         N7lSJbXw09p/hc0Syl79iUuPNYiS1YRq/OvoM=
Received: by 10.239.191.194 with SMTP id c2mr1571146hbi.169.1269000595429; 
	Fri, 19 Mar 2010 05:09:55 -0700 (PDT)
In-Reply-To: <20100319115445.GA12986@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142580>

On Fri, Mar 19, 2010 at 05:54, Mike Hommey <mh@glandium.org> wrote:
> While I don't agree with the need for that uuid thing, I'd like to
> pinpoint that people who care can't necessarily make their e-mail
> consistant. For example, Linus used to use an @osdl.org address, and
> he now uses an @linux-foundation.org address. It's still the same Linus,
> but the (name, email) pair has legitimately changed.

Indeed.

This is because the name/email pair (as in the 'name' and 'email'
config variables) CONFLATES the idea of identity and current email
account.
