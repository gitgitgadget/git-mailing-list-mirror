From: Michael Heerdegen <michael_heerdegen@web.de>
Subject: Re: [Bug] git-log prints wrong unixtime with --date=format:%s
Date: Thu, 19 May 2016 00:57:15 +0200
Message-ID: <87vb2b560k.fsf@web.de>
References: <87vb2d37ea.fsf@web.de> <8760ucoaus.fsf@web.de>
	<20160518004008.GA20007@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 19 00:57:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3APB-0001Xa-34
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 00:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbcERW5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 18:57:25 -0400
Received: from mout.web.de ([212.227.15.14]:52426 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050AbcERW5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 18:57:24 -0400
Received: from drachen.dragon ([94.217.122.112]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0M8QeQ-1bpt8x1tzu-00vx9j; Thu, 19 May 2016 00:57:17
 +0200
In-Reply-To: <20160518004008.GA20007@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 17 May 2016 20:40:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.93 (gnu/linux)
X-Provags-ID: V03:K0:f4nI1D4M6JMU623453WZUwuVf0GuhEoBdZKSx9LcoNve2eCyGL9
 APuKWvYxJ7nJCBoXRc69MDodSmC7wzgbtqvAQ3QCqZombrL6k7k1UEl2TN1/mB7KtKHMmVp
 hKcYE0UumPf1FVwsqakLBJHtip4ceZdbtct4mJQYH0LMGW62NNIC1rEreOEe9PiL8CMe4em
 MQTTYrPExdFm1RezwX8jA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pbtY6N/yJ70=:1eVL4uRnEIsCtIa5cOOpkn
 GK/ia9AXOsCKiDCvf5GdPevoPqO5lMKSu1jnz34kbZGT3yfkpafQQJQX/JCW8CuAOLWLxsFLx
 I/sXEZhdWjyTdSks6/K9VaUlP8cMpqeju6+NFxRG5csQw/FZWhzUsuIwoeYX4XyDdgcJey5IN
 PQ5hS3vczI5cS2+foon+W7i8dLQFDV0bqBr+h1MlZCwDyrJthEQZlFbYnnznBoM2d2LVJvRLT
 0jOJySw+bD9YZeii4/E4gglLHYyFhWm29zJG+x8GbkpoEI7DwlE2RIwPhTucfKCYFi/ZDy60C
 j0Xgbjx4RQNWX+hcZdxNw3b96omt4xqOvAH8IMPHS+K7r8fFdX0MAbdBZyEX1UekWkGlBUdoI
 97pzwEboK3Rb1+uffJfHad1MRhKRiTSKLuBzioOHv7s2+cC5+cRz/Y2B1hj+5RVH9ddyHsaPW
 PiG7dYHiAbLIuPugObSFVanTuGyjNpbjM6bQsPcT0gAYn4mr0PoVk5sAnnk5CF8fkd5FpX+cb
 PN5ulIDB0nWulHn7h/8zRPDeSgeT3BRsQ8N48NA+vjh/0vzPRyYDx23HqWdfaU0SsfAp3uTY7
 wALwzAeQbzFb4gg8MlhO404BU7bR7gky/uTL4TdnDQFVLrIYt6hhsNOe/GbzZe4oQBpG1hTde
 ADnU6d+dpysXDMNususvyn0nC3QiPEXG2P+/ERx2E/3BDCmNWrnGedqVs2hVcZsXP3d85Fph3
 UUH78rz4qBcJVbWwOiB4hxmWtrk1AR5yQirDMApd1ddQnYCS+7lJ8niGddnSeFvJ7OVfyfsZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295025>

Jeff King <peff@peff.net> writes:

> This is probably a totally separate issue, as it would not be using
> strftime (or IIRC, any of the standard time functions at all). Do you
> have a detailed example that shows the problem?

Ok, this was probably false alarm.  Magit (An Emacs Git front end) shows
rounded duration values (rounded hours in my case) in its log views, I
think I just got confused because of this.  In my tests now, the results
were as expected.


Thanks,

Michael.
