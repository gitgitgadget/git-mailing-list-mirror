From: Frans Pop <elendil@planet.nl>
Subject: Re: 'git gc --aggressive' effectively unusable
Date: Sun, 4 Apr 2010 01:23:04 +0200
Message-ID: <201004040123.06877.elendil@planet.nl>
References: <201004030005.35737.elendil@planet.nl> <p2gb4087cc51004031433xc57e52bbq733d1d3c5f37f238@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 04 01:23:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyCga-0000jz-3h
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 01:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896Ab0DCXXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Apr 2010 19:23:10 -0400
Received: from Cpsmtpm-eml106.kpnxchange.com ([195.121.3.10]:64475 "EHLO
	CPSMTPM-EML106.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752696Ab0DCXXI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Apr 2010 19:23:08 -0400
Received: from aragorn.fjphome.nl ([77.166.180.99]) by CPSMTPM-EML106.kpnxchange.com with Microsoft SMTPSVC(7.0.6001.18000);
	 Sun, 4 Apr 2010 01:23:07 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <p2gb4087cc51004031433xc57e52bbq733d1d3c5f37f238@mail.gmail.com>
Content-Disposition: inline
X-OriginalArrivalTime: 03 Apr 2010 23:23:07.0734 (UTC) FILETIME=[9E3BBF60:01CAD384]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143908>

On Saturday 03 April 2010, Michael Witten wrote:
> On Fri, Apr 2, 2010 at 16:05, Frans Pop <elendil@planet.nl> wrote:
> > I haven't had the patience to let it finish
>
> There's your problem.

Yes, I had seen that. But there's a difference between taking much more 
time and slowing down to such an extend that it never finishes.

I've tried it today on my linux-2.6 repo as well and the same thing 
happened. At first the progress is not fast but reasonable. When it gets 
to about 45% percent it starts slowing down a lot: from ~1500 objects per 
update of the counters to ~300 objects per update. And who knows what the 
progress is going to be when it reaches 70% or 90%: 10 per update?

With a total of over 2 milion objects in the repository such a low speed is 
simply not going to work, ever. So I maintain that it is effectively 
unusable.

Cheers,
FJP
