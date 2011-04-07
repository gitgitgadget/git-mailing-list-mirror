From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/4] Documentation: Add diff.<driver>.* to config
Date: Thu, 7 Apr 2011 08:33:43 +0530
Message-ID: <20110407030341.GA28334@kytes>
References: <1302083854-2448-1-git-send-email-artagnon@gmail.com>
 <1302115611-1950-1-git-send-email-artagnon@gmail.com>
 <1302115611-1950-3-git-send-email-artagnon@gmail.com>
 <7vwrj7i2je.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 05:04:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7fWb-0000aE-Nx
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 05:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437Ab1DGDEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 23:04:41 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38941 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638Ab1DGDEk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 23:04:40 -0400
Received: by iwn34 with SMTP id 34so2045028iwn.19
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 20:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=9+bjgKX+jVzYh8JgSFgk/V0bVq8SgA4CbVvKYWsusLA=;
        b=K2bNzT8TXf3dxO0/m72fH9e/PCrUPyVz/Gg5UmufXcopyP2jz7M/uZPTORHnSeG31I
         FgM8Fj+3JmHGtL2d7gpVWVqJ5NHVrWq9iTV3dFLJc73I4xRjhekAX1V8Ss8sE2aXQTCk
         N91bmg177/YVUl5J1qtxqnkGcY0/ovukEnqTo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TAJqjUGuKqfe/b+RBtGZbUCTrNHNzHkHumnXAsrLb6NWvpgFMqEpQgls7hsvZLMykm
         TYCOWy2Ja1wK9iKemxfgZeMQrQ4qpkMzZD7W+IayjPl204Paerr3w2/PSJ2qbrYSb9Oc
         vLP0dL6XM4pgFKbUIITxhnhO7TwgUpc0noDKg=
Received: by 10.42.229.133 with SMTP id ji5mr501959icb.311.1302145479708;
        Wed, 06 Apr 2011 20:04:39 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id jv9sm723208icb.1.2011.04.06.20.04.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2011 20:04:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vwrj7i2je.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171041>

Hi Junio,

Junio C Hamano writes:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
> 
> > +diff.<driver>.command::
> > +	The custom diff driver command.  See linkgit:gitattributes[5]
> > +	for details.
> 
> This is about "custom", but I thought it was pointed out that ...
> 
> > +diff.<driver>.xfuncname::
> > +	The regular expression that the custom diff driver should use
> > +	to recognize the hunk header.  A built-in pattern may also be
> > +	used.  See linkgit:gitattributes[5] for details.
> > +
> > +diff.<driver>.binary::
> > +	Set this option to true to make the custom diff driver treat
> > +	files as binary.  See linkgit:gitattributes[5] for details.
> 
> ... these two don't have much to do with "custom".  You seem to have
> dropped "custom" from the remaining three, and I think their description
> without "custom" makes more sense.
> 
> It is not a problem for me to just amend these two and lose "custom" when
> I apply this patch (if there is no other glitch in it, of course), but I

Right.  I was a little confused about these two, but yeah- I see now
that dependence on `diff.<driver>.command` is equivalent to saying
that an option applies to a "custom" diff driver.  Please amend to
lose the "custom".

Thanks.

-- Ram
