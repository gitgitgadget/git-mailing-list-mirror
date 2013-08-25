From: Thomas Ackermann <th.acker@arcor.de>
Subject: Aw: Re: [PATCH 02/13] Use current "detached HEAD" message
Date: Sun, 25 Aug 2013 10:10:40 +0200 (CEST)
Message-ID: <1764880917.480568.1377418240632.JavaMail.ngmail@webmail16.arcor-online.net>
References: <20130825034916.GB2882@elie.Belkin> <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
 <1667680014.1090850.1377329140347.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, wking@tremily.us
To: jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Sun Aug 25 10:10:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDVPW-0000wU-Iu
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 10:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756071Ab3HYIKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 04:10:52 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:53632 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756092Ab3HYIKl (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Aug 2013 04:10:41 -0400
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mx.arcor.de (Postfix) with ESMTP id 9C75C3AE4BF;
	Sun, 25 Aug 2013 10:10:40 +0200 (CEST)
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net [151.189.21.48])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id 96B7A116018;
	Sun, 25 Aug 2013 10:10:40 +0200 (CEST)
Received: from webmail16.arcor-online.net (webmail16.arcor-online.net [151.189.8.70])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id 95F993AE496;
	Sun, 25 Aug 2013 10:10:40 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-08.arcor-online.net 95F993AE496
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1377418240; bh=GLaIcs7u8jHUNBYfpU+0haDFGOMw+ze8vGRkkrIIN/4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=uENDGW/VKA4HFf+nFVIBch5fH4mTITKM520NMq5Z9/TIzaoOJmidouOUo9DI6O3d7
	 LCdSnUx9QTbeMslcUkHNb5V0qsbt0/h5/tqhqbdh4Fd1Pt8esTyIzDHgPokWzUsf2t
	 SdOa/JMQsA87cHyuHN/yiM5Hh+aRu5Kp04sFnJZQ=
Received: from [178.7.23.208] by webmail16.arcor-online.net (151.189.8.70) with HTTP (Arcor Webmail); Sun, 25 Aug 2013 10:10:40 +0200 (CEST)
In-Reply-To: <20130825034916.GB2882@elie.Belkin>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.23.208
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232936>

 
> 
> I wonder if this longer wall of text (added in 13be3e31, 2010-01-29)
> is too aggressive.
> 
> It is the only piece of advice that I explicitly disable in
> ~/.gitconfig, so I haven't looked at it again for a while.  Since
> then, the usual stream of questions about how to recover from people
> who accidentally detached HEAD has still been showing up in #git, so I
> don't think the message succeeded in its purpose.
> 

I like the message :-) But of course without really knowing how a
"detached HEAD" looks like in the object store, people might feel
unsure about what to do next.

> 
> 	grep "no branch" Documentation/user-manual.txt
> 
> finds two other instances of that message, which this branch doesn't
> touch.  One is about a bisection, where (no branch) is pretty close
> to the actual message ('(no branch, bisect started on master)').
> The other is about submodules.  Here's a patch for potential squashing
> in that corrects it.
> 

Thanks for spotting this!


---
Thomas
