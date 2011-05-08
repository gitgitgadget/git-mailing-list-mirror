From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 1/2] commit: do not cleanup template
Date: Sun, 08 May 2011 10:47:04 +0200
Message-ID: <4DC65888.7090309@gmail.com>
References: <1304783624-9919-1-git-send-email-billiob@gmail.com> <7vwri2uv4m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Boris Faure <billiob@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 08 10:47:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIzdz-0004JS-88
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 10:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161Ab1EHIrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 04:47:11 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65533 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123Ab1EHIrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 04:47:09 -0400
Received: by fxm17 with SMTP id 17so3085578fxm.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 01:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version
         :newsgroups:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=uKI7xQqJcIOFVTmjdVUV6L4Jt4dzpnRF7iIp69ozJ4U=;
        b=iXDuKUzmYFYlQoJEmSLV/mSf7Qsl/cKaE7tigYiOsFRZrLRUImJu4Zq4uzwn07Vu4H
         FL8FNaihs1Ii0jbQrnLleH0NVtplidGHCCKZq0NXEILMhh/LgWehV6RBl5rZ12lOkj0z
         8cX/T2MUHLPjEOkmOdqqvsAlJqamLPywDE+gQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=xl2I1Ma26J/8AZVn6xOaPngMnK2tdODGvwU6xCwzzzp5Sr+I3dUbESKSl531lJ9dJX
         E9Ax92WCy+2kwwsmG+oyUN0bH/gQ0929GYrIfcH0uLyCUCR3Rs2j3eaJ10NTxi4Giiu4
         HE+e0bZDIZQjd7RvqS9m0jDY+ZfXSxFVWndeY=
Received: by 10.223.86.130 with SMTP id s2mr3735235fal.115.1304844428263;
        Sun, 08 May 2011 01:47:08 -0700 (PDT)
Received: from [192.168.178.23] (p5DDB0006.dip0.t-ipconnect.de [93.219.0.6])
        by mx.google.com with ESMTPS id b17sm1444702fab.47.2011.05.08.01.47.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 May 2011 01:47:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7vwri2uv4m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173080>

On 07.05.2011 22:13, Junio C Hamano wrote:

> These two commits change the longstanding behaviour. It is hard to tell if
> the existing behaviour is something people who use commit log message
> templates have relied on (in which case your patch will be a regression to
> them) or they all shared the sense of annoyance and have been wishing to
> be improved (in which case nobody will be inconvenienced with your patch).
> They need to be explained a bit better why these changes are needed.

I forgot this in my first mail: Being one of the poeple that in general 
shares Boris' sense of annoyance, I'm voting in favor of his patch [1/2] 
(or mine, if it is any better), but not [2/2].

For any poeple that might be inconvenienced by the patch there is a 
trivial one-time fix: Strip whitespaces from their template. Because of 
this, I believe it is OK to change the long-standing behavior in this case.

-- 
Sebastian Schuberth
