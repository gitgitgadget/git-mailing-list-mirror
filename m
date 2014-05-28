From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH 01/15] builtin/add.c: rearrange xcalloc arguments
Date: Tue, 27 May 2014 22:14:11 -0700
Message-ID: <20140528051411.GA3095@hudson.localdomain>
References: <1401118436-66090-1-git-send-email-modocache@gmail.com>
 <1401118436-66090-2-git-send-email-modocache@gmail.com>
 <CAPig+cRE0LUaNLTJARBCmoDn7cR1bbgi8At0ChgSDWBjDPaNjg@mail.gmail.com>
 <CAN7MxmXVDTiQv5J9cU2E8iS=BNROw3q9NVaBuG7aQP-7=Qo_ZQ@mail.gmail.com>
 <CAPig+cTmyBzroDOnqEb_GWqhcbgbK27pT3=3VCVOnj13=C4CfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed May 28 07:14:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpWBw-0003Rx-Sj
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 07:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752971AbaE1FOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 01:14:16 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:52638 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbaE1FOP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 01:14:15 -0400
Received: by mail-pa0-f47.google.com with SMTP id lf10so10368029pab.34
        for <git@vger.kernel.org>; Tue, 27 May 2014 22:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=mv9P+dWd8iRcVeTvIDX3cz89MA4YhDk1hDSzmcbUNHE=;
        b=Vm6MJWd0ATvAJAGW1IUyshloZJK8aRbHBYt7MF8qS5qSe4ZsDRtvT1Mytgsf8iAlhM
         z869yzEzzHlIckKtKBeNwM4JMKajPdVu4+Rj3wEoyKrUEGkEIoCfx7nXIYSXaOacb480
         FFgxHlDeUB668xL080I4JbUhEL8cs+F+ul/K5T+qDhYxpwGG0CwSaiESC86/izVmVKe7
         i3W4uvGcA2SOYKADrRW06zE5UxJeAs9Z/T7M+XeqEKaQInXMI8FrkdV1RUfLG2FTuKRj
         kZ554TezbS7nbSQ+6pUCMczjJwLdYsvd+UUyT6YF9G8w/r2+choZlro/Tc39p0XlH3FI
         ePRg==
X-Received: by 10.68.233.37 with SMTP id tt5mr42767310pbc.154.1401254055435;
        Tue, 27 May 2014 22:14:15 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id iq10sm26179852pbc.14.2014.05.27.22.14.12
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 27 May 2014 22:14:14 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Tue, 27 May 2014 22:14:11 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CAPig+cTmyBzroDOnqEb_GWqhcbgbK27pT3=3VCVOnj13=C4CfA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250260>

On Tue, May 27, 2014 at 05:35:29PM -0400, Eric Sunshine wrote:
> On Tue, May 27, 2014 at 7:32 AM, Brian Gesiak <modocache@gmail.com> wrote:
> > Oomph, how embarrassing. Thanks for pointing that out!
> 
> Etiquette on this list is to avoid top-posting [1].
> 
> [1]: https://lkml.org/lkml/2005/1/11/111
> 

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

That is the funniest post I have ever seen by Kroah.

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
