From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: questions / suggestions about history simplification
Date: Thu, 19 Dec 2013 11:10:44 -0800
Message-ID: <20131219191044.GA20443@google.com>
References: <20131219183645.GD23496@pacific.linksys.moosehall>
 <20131219190333.GE23496@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Thu Dec 19 20:11:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vtizr-0002BI-Jv
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 20:10:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754249Ab3LSTK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 14:10:56 -0500
Received: from mail-yh0-f43.google.com ([209.85.213.43]:55509 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926Ab3LSTKz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 14:10:55 -0500
Received: by mail-yh0-f43.google.com with SMTP id a41so411606yho.2
        for <git@vger.kernel.org>; Thu, 19 Dec 2013 11:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GEk4WwmbociQg6I2H8kn+QSh0vmeTbwwQSh9dVY9bfo=;
        b=0JCU3fjti2z3DiF4RrQN4zN9Gd82n9WTr941jAw9tOWKXBYSI5pXZ2hBTZOvb9g40G
         s6TpXUB6xIO6Ojst3S6hjy0qmNirL6KxfaS3kPVpA7xgad6tiMuQ9n2Ax0ZMNy15v03v
         LEbdlEv/PVP2rZoNg3FVM0tr2VNOzp2uEeUQdd24k/BhsNSV9oOzrHFa9YWbXjUk/qp/
         OI4UmKUgc9NtMNDFphBYsRS7pOJoLYpnQ3kiCrcCzYyBdltOQXHAfMdZBc2noGEsz37/
         u+HzL0uxHVJlGUcPE+8KyCqeSpSSAjM70TCQGPUDJst4BsCBXdEclaiuTCtfZhFnS7am
         2p8w==
X-Received: by 10.236.231.84 with SMTP id k80mr2628610yhq.33.1387480252856;
        Thu, 19 Dec 2013 11:10:52 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id x9sm7460210yhd.13.2013.12.19.11.10.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 19 Dec 2013 11:10:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131219190333.GE23496@pacific.linksys.moosehall>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239535>

Adam Spiers wrote:

> Hmm, another related option would be to add a new test case which
> tests that git log behaves in the way the man page says it does, in
> this case.

Yes, please!  If you have a rough patch in that direction, that
would be welcome.

Thanks,
Jonathan
