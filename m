From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 1/4] completion: be nicer with zsh
Date: Thu, 2 Feb 2012 04:50:06 -0600
Message-ID: <20120202105006.GH3823@burratino>
References: <1328145320-14071-1-git-send-email-felipe.contreras@gmail.com>
 <20120202084859.GC3823@burratino>
 <CAMP44s0w1eXWWaMT3WAfLxFHPQvc9dp33cyJ=T2im6g7rsrKhw@mail.gmail.com>
 <8739at8qw6.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Feb 02 11:50:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsuFL-0003lI-Km
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 11:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282Ab2BBKu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 05:50:26 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63487 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131Ab2BBKu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 05:50:26 -0500
Received: by iacb35 with SMTP id b35so2972250iac.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 02:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=sTUMQJ2AOX7gtja4V7DGeWa+EaZ/OjPHd6pscLap6C0=;
        b=Qfx9Gl2XdsJm8tvxZ0yv3GYdmPbGkrMN6D6kqyCCwShHxRKREl1XuQgCGck4qAcdlk
         Vr49f8p2zZTf/gOFK6bZIopkM2dnHwyuz2O3KrX4tAIUB29ulYVc1/ZM+kd/yZT5gRmB
         mYw+7XJ1W3ibbst5paGjerWoR9WPQx5MnlToA=
Received: by 10.50.45.195 with SMTP id p3mr11582050igm.2.1328179825394;
        Thu, 02 Feb 2012 02:50:25 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id or2sm19097755igc.5.2012.02.02.02.50.23
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 02:50:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <8739at8qw6.fsf@thomas.inf.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189619>

Thomas Rast wrote:

> Perhaps you could compromise on
>
>   completion: work around zsh word splitting bug in : ${foo:=$(bar)}

Thanks, that looks like a good subject line to me.  It gives a hint of
what the patch is trying to do, and it does not try to fool me into
thinking that if I use bash the patch does not affect me.

Felipe, I'm not going to respond to the rest of your message.  Perhaps
someone more patient than I am will, or if someone has specific
questions for me, I'll be glad to help.
