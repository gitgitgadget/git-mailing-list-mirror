From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: How to check out the repository at a particular point in time
Date: Tue, 23 Aug 2011 22:30:58 +0200
Message-ID: <4E540E02.1060201@web.de>
References: <1314085268.42103.YahooMailClassic@web25406.mail.ukl.yahoo.com> <201108231117.00314.trast@student.ethz.ch> <CAJsNXTk0LaSDKCOzJgZRLYmGe8hauPbPOw4oKLKP0Xr0axZkwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, rdiezmail-temp2@yahoo.de,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"in-git-vger@baka.org" <in-git-vger@baka.org>
To: PJ Weisberg <pjweisberg@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 22:31:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvxco-0006hW-P5
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 22:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756027Ab1HWUbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 16:31:01 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:57261 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130Ab1HWUbA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 16:31:00 -0400
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 01ADE195AB9C8;
	Tue, 23 Aug 2011 22:30:59 +0200 (CEST)
Received: from [79.247.254.73] (helo=[192.168.178.43])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Qvxcg-0007Jc-00; Tue, 23 Aug 2011 22:30:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:6.0) Gecko/20110812 Thunderbird/6.0
In-Reply-To: <CAJsNXTk0LaSDKCOzJgZRLYmGe8hauPbPOw4oKLKP0Xr0axZkwg@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19V8VXjq7Ivyg9rF/Uks7BqQco2ZBj1Qh+FJvwF
	4Tb65rhaql1FmCa+RJu3pilL/wWrh0Yk5zpwHhUbmZWcRsj5dT
	BDjN+rEP80W4VGKkul5w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179968>

Am 23.08.2011 12:04, schrieb PJ Weisberg:
> On Tue, Aug 23, 2011 at 2:17 AM, Thomas Rast <trast@student.ethz.ch> wrote:
> 
>> I personally think that's crazy and -- if you want to avoid the work
>> of "really" using submodules -- support Jens's suggestion of having
>> the buildbot automatically assemble an "I tested this" superproject.
> 
> Or create a tag in each separate repository, using the same tag name
> to indicate versions that were tested together.  Or you could do the
> same with a branch, since a branch is basically a tag that moves.  You
> would just have to make sure only the buildbot updated that branch.

That would also work, but it might need some scripting. Probably having
some server side hooks to enforce the policy allowing no-one except the
buildbot to change those branches/tags would help here. Also submodules
would make it easier to see when they differ from the commits recorded
in the superproject, so a script running something like "git describe"
in all local repos and displaying the results might be a good idea to
get that information.
