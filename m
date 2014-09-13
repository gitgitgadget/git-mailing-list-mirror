From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH/RFC] submodule: add ability to shallowly clone any branch
 in a submodule
Date: Sat, 13 Sep 2014 13:11:11 +0200
Message-ID: <5414264F.1000909@web.de>
References: <1410455473-2367-1-git-send-email-cole.minnaar@gmail.com> <5411F620.4000408@web.de> <1410467134-sup-6791@Sasori.local> <20140912052123.GN10182@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Fredrik Gustafsson <iveqy@iveqy.com>, Cole <cole.minnaar@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 13 13:11:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSlEc-0007c2-Nl
	for gcvg-git-2@plane.gmane.org; Sat, 13 Sep 2014 13:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbaIMLLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2014 07:11:15 -0400
Received: from mout.web.de ([212.227.15.14]:50092 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750884AbaIMLLO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2014 07:11:14 -0400
Received: from [192.168.178.41] ([79.193.66.205]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MgO9u-1XfUOM2Pzy-00NljE; Sat, 13 Sep 2014 13:11:12
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <20140912052123.GN10182@paksenarrion.iveqy.com>
X-Provags-ID: V03:K0:8uDz9kGOmRUKDgT2VvIWM0ypA5PYeJaPOMeomxR+QPQXXAoogMo
 t30sRRkZRhvqmJHcvbX7DQOqLnKYA1G+pQsC1sGk/jphXVYWiFc8kNdR1/Ce3G0TU1BvAY1
 w55ZY3WaBTgGQaYT2ikN5Bf70aXzHAtrQBB6hIXjg5375BKuUEc54flb3SUlSMTWrn9uT7X
 flopqZa/3VI+33v8wLz6A==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256963>

Am 12.09.2014 um 07:21 schrieb Fredrik Gustafsson:
> On Thu, Sep 11, 2014 at 10:33:51PM +0200, Cole wrote:
>> Also if there is anything else you are currently looking at regarding
>> submodules or thinking about, I would be glad to hear about it or to try
>> look at it while I am working on these changes. Or if there is anything
>> you can think of for me to check with regards to these changes that
>> would also be appreciated.
>
> When implementing the --depth argument for submodules, I would have
> prefered that the depth was set from the commit of the submodules
> refered from the superprojekt and not it's branch.

That would help recursive fetch too.

> However this can't be done, since you can only clone from refs and not
> from a commit. However there's nothing that stops us from allowing to
> clone from a commit (of course we need to make sure that that commit is
> in a tree with a ref as leaf).
>
> I see this as a natural next step for the --depth function and something
> needed for it to be really useful. I'm actually suprised that people
> successfully uses the --depth function already since you always need to
> know how deep down the commit is.

I suspect this only works because users set the depth high enough or the
submodule is updated frequently to the tip of a branch.
