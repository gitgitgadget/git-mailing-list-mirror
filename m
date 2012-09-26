From: Max Horn <postbox@quendi.de>
Subject: Re: Can git pull from a mercurial repository?
Date: Wed, 26 Sep 2012 10:46:38 +0200
Message-ID: <7F5A6E53-4F7C-462F-8B04-09934BAB88DB@quendi.de>
References: <k39lir$gpm$1@ger.gmane.org> <50585F10.3080307@op5.se> <000a01cd959a$d8cd0730$8a671590$@schmitz-digital.de> <37D17798-4BDC-433D-A9B4-49F4352754D9@quendi.de> <5062B0F6.1040906@unixsol.org>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Joachim Schmitz <jojo@schmitz-digital.de>,
	'Andreas Ericsson' <ae@op5.se>, git@vger.kernel.org
To: Georgi Chorbadzhiyski <gf@unixsol.org>
X-From: git-owner@vger.kernel.org Wed Sep 26 10:47:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGnGi-000063-IG
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 10:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754396Ab2IZIqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 04:46:48 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:53936 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754319Ab2IZIqo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 04:46:44 -0400
Received: from 77-22-74-244-dynip.superkabel.de ([77.22.74.244] helo=zanovar.fritz.box); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1TGnGS-0002Lx-Iz; Wed, 26 Sep 2012 10:46:40 +0200
In-Reply-To: <5062B0F6.1040906@unixsol.org>
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;postbox@quendi.de;1348649204;b53f9d33;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206400>


On 26.09.2012, at 09:38, Georgi Chorbadzhiyski wrote:

> Around 09/25/2012 05:15 PM, Max Horn scribbled:
>> I think there is a lot of demand for a "git-hg" bridge, a way to seemlessly access a Mercurial repository as if it was a git repository. A converse to hg-git <http://hg-git.github.com/>
> 
> I've already mentioned this, but such a tool already exists and it
> is working very well (IMHO): http://offbytwo.com/git-hg/

I guess this is a matter of perspective. It doesn't work at all for me because it does not really support pushing. (It does have a "push" command, but at least last time I looked, it was utterly broken; see also <https://github.com/dubiousjim/yagh/blob/master/Backends.md> for a discussion (not written by me!). I'd be happy to learn that has changed, though I just looked, and it still uses "hg convert", so I don't see how it possibly could work...

Cheers,
Max