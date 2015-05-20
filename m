From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PUB]corrupt repos does not return error with `git fsck`
Date: Wed, 20 May 2015 19:40:57 +0200
Organization: gmx
Message-ID: <d21002e0fa92b03c3d417c8996328563@www.dscho.org>
References: <alpine.DEB.2.11.1505202142540.9343@orwell.homelinux.org>
 <vpq382rkvzf.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Faheem Mitha <faheem@faheem.info>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 20 19:41:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv7zR-0003ls-8s
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 19:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436AbbETRlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 13:41:05 -0400
Received: from mout.gmx.net ([212.227.17.21]:56655 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753033AbbETRlD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 13:41:03 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MCPhl-1Z4Eep1gpd-0099cp; Wed, 20 May 2015 19:40:58
 +0200
In-Reply-To: <vpq382rkvzf.fsf@anie.imag.fr>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:EmSf7TVNjy/cZ3Na1fMXVsD+B1qRfh4ulnwCxPwIsn6+WO79aJE
 P1wdJGPmBZhKpZYid7Mzo/jEwQDtXjAe8MG4qO7dWjY6ZQQMYIJU7jtIuriaO694KyCqFhn
 Qp+Gchq9zt+W5Ho4EDkwuDoCWP2JVx6R8BDozpsI1DJz/hY+IaNYfru4FaoRSPBclTvzC1d
 cGu1jDL3SOdFGQydy1p8Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269482>

Hi,

On 2015-05-20 19:19, Matthieu Moy wrote:
> Faheem Mitha <faheem@faheem.info> writes:
> 
>> Clone the repos https://github.com/fmitha/SICL.
>>
>> Then
>>
>>     git show 280c12ab49223c64c6f914944287a7d049cf4dd0
>>
>> gives
>>
>>     fatal: bad object 280c12ab49223c64c6f914944287a7d049cf4dd0
> 
> It seems 280c12ab49223c64c6f914944287a7d049cf4dd0 is not an object in
> your repository. The good news it: I don't think you have a corrupt
> repository. What makes you think you have an object with identifier
> 280c12ab49223c64c6f914944287a7d049cf4dd0?

I had a similar problem some time ago and tracked it down to a graft that was active while pushing to the public repository. Maybe it's the same problem here?

Ciao,
Johannes
