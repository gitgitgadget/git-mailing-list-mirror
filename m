From: Daniel Villeneuve <daniel2villeneuve@videotron.ca>
Subject: Re: git -c var=val not taken into account by git config?
Date: Tue, 08 May 2012 08:56:57 -0400
Message-ID: <4FA91819.20301@videotron.ca>
References: <4FA857E3.5030609@videotron.ca>
 <20120508091606.GB31286@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 08 14:59:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRk0W-00015O-4I
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 14:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340Ab2EHM7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 08:59:03 -0400
Received: from relais.videotron.ca ([24.201.245.36]:13947 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257Ab2EHM7C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 08:59:02 -0400
Received: from [192.168.1.100] ([96.23.132.56]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0M3P00FQNG2DV830@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 08 May 2012 08:59:01 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.4) Gecko/20120422
 Thunderbird/10.0.4
In-reply-to: <20120508091606.GB31286@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197359>

On 08/05/12 05:16 AM, Jeff King wrote:
> On Mon, May 07, 2012 at 07:16:51PM -0400, Daniel Villeneuve wrote:
>
>> Testing color configuration via scripting, I tried the following command:
>>
>> git -c color.diff=always config --get-colorbool diff false
>>
>> on a repository with color.diff=auto.
>>
>> I'd expect "true" as output, but got "false".  "git diff" works as
>> expected though.  Is this an exception for "git config"?
> I think you meant "--get-colorbool color.diff"; the fact that you are
> getting a colorbool does not automatically place the name inside the
> color.* section.
>
> With that change, it seems to work as expected.
>
> -Peff
>
Indeed, and the example was mentioning "color.diff".  My error.  Giving 
just "diff", I was getting results from color.ui instead.

Regards,
--
Daniel
