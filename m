From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC/PATCH 1/2] Add a useful return value to git-check-attr
Date: Tue, 17 Apr 2007 11:24:37 +0100
Message-ID: <200704171124.39140.andyparkins@gmail.com>
References: <200704171010.49168.andyparkins@gmail.com> <7vzm57pcxp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 12:24:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdkrh-0006At-3o
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 12:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250AbXDQKYp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 06:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753309AbXDQKYp
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 06:24:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:16440 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250AbXDQKYo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 06:24:44 -0400
Received: by ug-out-1314.google.com with SMTP id 44so131405uga
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 03:24:43 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kF7249qeBEkdpk8HZftglese2Ms75Du36VbYfJJ73LFJrji0XiXtphP1UppAZBAGYqx+C200H+rvsc6kVSautVL0oMy5Z9nvg0muASlhYMnEOx5MuEcz2E2jqtpQdvuEUeGqv/Yf8b46UA3Ejo+p3df+t+hQnRJogx9cRRyLwM4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=udEA59hZ/RXeJcS0KDCAFEzAQw+UQB+h/f14FH1sdZVFMAYyPRdwbCX6geJ6uK3mphZgD8uJAMv2EsGljgmTwNQPAMz7K0jPB9SnoPeYzsn6k0o+3of0wYkuh7NRlUzVg9HQfC18xjJYnHMVdanBLmGhZO5TJaUYaWXdMXTaoPc=
Received: by 10.66.249.16 with SMTP id w16mr411728ugh.1176805483544;
        Tue, 17 Apr 2007 03:24:43 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b36sm1965443ika.2007.04.17.03.24.41;
        Tue, 17 Apr 2007 03:24:42 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <7vzm57pcxp.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44755>

On Tuesday 2007 April 17 10:28, Junio C Hamano wrote:

> And your patch was a step in the right direction based on my
> previous patch.
>
> But sorry, you were shooting at a target that is still moving
> too fast, and you missed.  It's not your fault, as even I did
> not know where it was heading to, but my plan has been to have
> the scripts parse the text output, as we would need more than
> true/false values, as I did in the four patch series I sent out
> tonight.

Not a problem.  It was a couple of seconds work.  I added it so that I could 
test my keyword expansion stuff.

Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
