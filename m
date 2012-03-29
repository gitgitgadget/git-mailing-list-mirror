From: =?ISO-8859-1?Q?Andr=E9_Walker?= <andre@andrewalker.net>
Subject: Re: better way to find Git.pm officially?
Date: Thu, 29 Mar 2012 02:10:51 -0300
Message-ID: <4F73EEDB.7000009@andrewalker.net>
References: <86r4wc9f6j.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 07:11:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD7dX-0005iS-KS
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 07:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912Ab2C2FK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 01:10:59 -0400
Received: from oproxy6-pub.bluehost.com ([67.222.54.6]:33697 "HELO
	oproxy6-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751775Ab2C2FK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 01:10:57 -0400
Received: (qmail 19375 invoked by uid 0); 29 Mar 2012 05:10:57 -0000
Received: from unknown (HELO host245.hostmonster.com) (74.220.215.245)
  by cpoproxy3.bluehost.com with SMTP; 29 Mar 2012 05:10:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=andrewalker.net; s=default;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=+LSd7F6MpOWZlabAFYQ+d/NSdk4ydxsfT0STX7o1heE=;
	b=WvEZaDHJSenb7e7hfTbnLToeCq7Sb7v2uKUJt/Kh/J08JooouevPNFKquc/KzkGInqyU5D4/zxFHs5n3olkBkXbgyGcVdkZpS8rdVHwpqCofgJab5LgOCy9VEg1F4QiO;
Received: from [189.79.195.99] (helo=[192.168.2.103])
	by host245.hostmonster.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.76)
	(envelope-from <andre@andrewalker.net>)
	id 1SD7dQ-0002af-RB; Wed, 28 Mar 2012 23:10:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.1) Gecko/20120209 Thunderbird/10.0.1
In-Reply-To: <86r4wc9f6j.fsf@red.stonehenge.com>
X-Identified-User: {2744:host245.hostmonster.com:picloadc:andrewalker.net} {sentby:smtp auth 189.79.195.99 authed with andre@andrewalker.net}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194228>

On 03/29/2012 01:58 AM, Randal L. Schwartz wrote:
> Is there a simpler way?  Can we get "git --perl-path" added to the
> binary or something?
Maybe after the GSoC project? :)
Although a --perl-path would probably become unnecessary for newer 
versions. I guess after we publish Git.pm to CPAN, we could install it 
like a regular Perl module, and just have the perl scripts use it from 
default directories in @INC. Unless this will make too much trouble with 
compatibility (i.e., installing Git.pm v1.9 on a machine with git v1.8 
installed).
