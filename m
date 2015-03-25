From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: per-repository and per-worktree config variables
Date: Wed, 25 Mar 2015 22:33:48 +0100
Message-ID: <551329BC.8050207@web.de>
References: <1423401394-13675-1-git-send-email-pclouds@gmail.com> <54D79EAB.6060301@web.de> <20150318213342.GA25692@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Max Kirillov <max@max630.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= =?UTF-8?B?IER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 22:34:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yasw2-0002ZF-2g
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 22:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbbCYVdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 17:33:53 -0400
Received: from mout.web.de ([212.227.15.14]:64613 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751185AbbCYVdx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 17:33:53 -0400
Received: from [192.168.178.41] ([79.211.117.156]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0M6UmJ-1ZOs9G2Q6F-00yRcD; Wed, 25 Mar 2015 22:33:49
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <20150318213342.GA25692@wheezy.local>
X-Provags-ID: V03:K0:ZT4+ek7jERXr29xBHR4t4imYRQes/QG/nFFCkPnskDnhAw/wiB2
 0/XpzJ4MzZm3ZSMosqsXPuoiPkT6MOaf/4hPq8XLCU1erbb2Ks/4krhpwwge5rAtVCFbB8h
 O6DBZNyLcD2cEAsBVEPy0tF1AAT18bjO+xMXLLNi3kexq7cP/qPISj1545OG4fEJFUCAfwz
 PkDZnCWzFnfsJoX4/G4bw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266304>

Am 18.03.2015 um 22:33 schrieb Max Kirillov:
> On Sun, Feb 08, 2015 at 09:36:43AM -0800, Jens Lehmann wrote:
>> I wonder if it's worth all the hassle to invent new names. Wouldn't
>> it be much better to just keep a list of per-worktree configuration
>> value names and use that inside the config code to decide where to
>> find them for multiple work trees. That would also work easily for
>> stuff like EOL-config and would push the complexity in the config
>> machinery and not onto the user.
>
> I actually thought about the same, and now tend to think
> that most of config variables make sense to be per-worktree
> in some cases. Only few variable must always be per
> repository. I tried to summarize the variables which now
> (in current pu) should be common, also listed all the rest
> so somebody could scan through the list and spot anything I
> could miss.

Thanks for your effort! Looks like my suspicion that not only
submodule specific configuration should be kept per worktree
wasn't completely wrong ;-)

Me thinks Duy's proposal to configure the per worktree settings
in a config file might make lots of sense. We could then provide
a default version of that file with settings that fit most use
cases and the user could then adapt that to her special needs if
needed.
