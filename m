From: Noel Grandin <noel@peralex.com>
Subject: Re: [RFC/PATCH v4 1/3] add high resolution timer function to debug
 performance issues
Date: Wed, 21 May 2014 09:31:00 +0200
Message-ID: <537C5634.3050807@peralex.com>
References: <537BA806.50600@gmail.com> <537BA8D1.1090503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Karsten Blees <karsten.blees@gmail.com>,
	Git List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
X-From: git-owner@vger.kernel.org Wed May 21 09:41:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wn19i-0007kn-19
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 09:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbaEUHli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 03:41:38 -0400
Received: from mail.peralex.com ([41.164.8.44]:27769 "EHLO mail.peralex.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254AbaEUHlh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 03:41:37 -0400
X-Greylist: delayed 639 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 May 2014 03:41:36 EDT
Received: from [192.168.1.77] (noel1.ct [192.168.1.77])
	by mail.peralex.com (Postfix) with ESMTPSA id 31D5A336F30;
	Wed, 21 May 2014 09:30:54 +0200 (SAST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=peralex.com;
	s=default; t=1400657454;
	bh=KkRV9dgI010VW/nQFItUG8rqZ5NOq2GYbUXP+Jf9KQ8=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=bhIL9+0c9Nb4VF2lP6gvK4XNumS72lxlrHqEFF7O07SCIYYHlIkVA3eKvIG7cY26K
	 1gprVbLDAq/8S5jE9Whg7FQoZfXItDIyytOuABgWW9SYxnwheHyjjVQWYbrawp/Qcu
	 vaU92yMNz9truApRXdpT5WCc2SOQ8ROPOLIyfJfs=
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <537BA8D1.1090503@gmail.com>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.4.3 (mail.peralex.com); Wed, 21 May 2014 09:30:54 +0200 (SAST)
X-Scanned-By: MIMEDefang 2.74 on 41.164.8.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249776>

On 2014-05-20 21:11, Karsten Blees wrote:
>   * implement Mac OSX version using mach_absolute_time
>
>


Note that unlike the Windows and Linux APIs, mach_absolute_time does not do correction for frequency-scaling and 
cross-CPU synchronization with the TSC.

I'm not aware of anything else that you could use on MacOS, so your best bet is probably just to use mach_absolute_time 
and document it's shortcomings.

Regards, Noel.

Disclaimer: http://www.peralex.com/disclaimer.html
