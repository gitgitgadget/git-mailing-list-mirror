From: Georgi Chorbadzhiyski <gf@unixsol.org>
Subject: Re: Can git pull from a mercurial repository?
Date: Wed, 26 Sep 2012 12:46:49 +0300
Organization: Unix Solutions Ltd. (http://unixsol.org/)
Message-ID: <5062CF09.2090703@unixsol.org>
References: <k39lir$gpm$1@ger.gmane.org> <50585F10.3080307@op5.se> <000a01cd959a$d8cd0730$8a671590$@schmitz-digital.de> <37D17798-4BDC-433D-A9B4-49F4352754D9@quendi.de> <5062B0F6.1040906@unixsol.org> <7F5A6E53-4F7C-462F-8B04-09934BAB88DB@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Joachim Schmitz <jojo@schmitz-digital.de>,
	'Andreas Ericsson' <ae@op5.se>, git@vger.kernel.org,
	cosmin@offbytwo.com
To: Max Horn <postbox@quendi.de>
X-From: git-owner@vger.kernel.org Wed Sep 26 11:47:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGoCr-0001jP-DI
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 11:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027Ab2IZJqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 05:46:52 -0400
Received: from ns.unixsol.org ([193.110.159.2]:47194 "EHLO ns.unixsol.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753358Ab2IZJqv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 05:46:51 -0400
Received: from [10.0.1.78] ([::ffff:10.0.1.78])
  (AUTH: CRAM-MD5 gf, SSL: TLSv1/SSLv3,256bits,AES256-SHA)
  by ns.unixsol.org with ESMTPSA; Wed, 26 Sep 2012 12:46:50 +0300
  id 000000000018866A.5062CF0A.00004BB3
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:14.0) Gecko/20120717 Thunderbird/14.0
In-Reply-To: <7F5A6E53-4F7C-462F-8B04-09934BAB88DB@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206401>

Around 09/26/2012 11:46 AM, Max Horn scribbled:
> On 26.09.2012, at 09:38, Georgi Chorbadzhiyski wrote:
>> Around 09/25/2012 05:15 PM, Max Horn scribbled:
>>> I think there is a lot of demand for a "git-hg" bridge, a way to seemlessly access a Mercurial repository as if it was a git repository. A converse to hg-git <http://hg-git.github.com/>
>>
>> I've already mentioned this, but such a tool already exists and it
>> is working very well (IMHO): http://offbytwo.com/git-hg/
> 
> I guess this is a matter of perspective. It doesn't work at all for me because it does not really support pushing. (It does have a "push" command, but at least last time I looked, it was utterly broken; see also <https://github.com/dubiousjim/yagh/blob/master/Backends.md> for a discussion (not written by me!). I'd be happy to learn that has changed, though I just looked, and it still uses "hg convert", so I don't see how it possibly could work...

I have not tested push (I'm using git-hg to sync hg repo and develop
using git, no pushing back to hg, just sending patches).

According to git-hg README "Push supported added as well although it
is still experimental". You should report the "push" bugs to the
author(s) they may be able to fix them.

-- 
Georgi Chorbadzhiyski
http://georgi.unixsol.org/
