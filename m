From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH (REVISED)] Add core.editor configuration variable
Date: Thu, 19 Jul 2007 15:52:36 +0100
Message-ID: <200707191552.37825.andyparkins@gmail.com>
References: <11848281302504-git-send-email-aroben@apple.com> <200707190848.54655.andyparkins@gmail.com> <95E642DA-F848-4398-9D9D-52B03A235887@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Adam Roben <aroben@apple.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 16:53:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBXNB-0002hk-DD
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 16:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758539AbXGSOws (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 10:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938784AbXGSOwr
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 10:52:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:39660 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S938777AbXGSOwo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 10:52:44 -0400
Received: by ug-out-1314.google.com with SMTP id j3so423508ugf
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 07:52:43 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=isXWJPvQB6z4gHDM+xx/vhYO1Llhkt5KO7JVa1iaFJYwUjPvxlyT4pOEL4xgMy2nGXPW6CztOOWt64jeAdMcwlawSYaUFvdneVxMQ8HWESerNsS43hWDoGWRPhjDiPRe+f0Psah1S6XDxmD0DfWGwpyk+9FhdTPTMH+RDg9bZVM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qcuTTlEqYNB4ob+7ZB2jWrb4Acumcs/ZJFy0Mf71xXWZymtYyqOp+RnwoxovjxkJL9NjZT2OZfqMAm8GNmQHJ2JTAPC39sabz77NSmEHmav3QkdS2PhiaCmU8Pkr3oUodRm9iqEd111CgAtJBkKf6JioGnp6V4w7hI8z30wYJv4=
Received: by 10.66.225.1 with SMTP id x1mr1236450ugg.1184856763378;
        Thu, 19 Jul 2007 07:52:43 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id c24sm3962041ika.2007.07.19.07.52.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Jul 2007 07:52:42 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <95E642DA-F848-4398-9D9D-52B03A235887@silverinsanity.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52996>

On Thursday 2007 July 19, Brian Gernhardt wrote:

> As far as [core] being only for plumbing, I disagree with that
> premise as well.  Any option that is used across many of the git
> commands is a core (meaning central) option.

Fair enough.  With the definition core != plumbing; my argument has no weight.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
