From: Andrew Eikum <aeikum@codeweavers.com>
Subject: Re: What's cooking in git.git (Feb 2014, #04; Wed, 12)
Date: Fri, 14 Feb 2014 14:50:38 -0600
Message-ID: <20140214205038.GC743@foghorn.codeweavers.com>
References: <xmqqd2ism1pu.fsf@gitster.dls.corp.google.com>
 <20140214194436.GB743@foghorn.codeweavers.com>
 <xmqq4n41ihgi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andrew Eikum <aeikum@codeweavers.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 14 21:50:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEPif-0007Y0-PK
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 21:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752AbaBNUul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 15:50:41 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:32896 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbaBNUuk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 15:50:40 -0500
Received: from foghorn.codeweavers.com ([216.251.189.130])
	by mail.codeweavers.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <aeikum@codeweavers.com>)
	id 1WEPiZ-0007Nl-Df; Fri, 14 Feb 2014 14:50:39 -0600
Content-Disposition: inline
In-Reply-To: <xmqq4n41ihgi.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242144>

On Fri, Feb 14, 2014 at 12:10:05PM -0800, Junio C Hamano wrote:
> Andrew Eikum <aeikum@codeweavers.com> writes:
> 
> > On Wed, Feb 12, 2014 at 01:59:41PM -0800, Junio C Hamano wrote:
> >> As a workaround to make life easier for third-party tools, the
> >> upcoming major release will be called "Git 1.9.0" (not "Git 1.9").
> >> The first maintenance release for it will be "Git 1.9.1", and the
> >> major release after "Git 1.9.0" will either be "Git 2.0.0" or "Git
> >> 1.10.0".
> >> 
> >
> > Apologies if this ground has been tread before, but has there been a
> > version numbering discussion? A quick google didn't seem to turn
> > anything up.
> >
> > This seems to be an opportune time to drop the useless first digit.
> > Explicitly, the major release numbers would be: 1.8, 1.9, then 2.0,
> > 3.0, 4.0, etc, with the 2nd digit would take the meaning of the
> > current 3rd digit and so on.
> 
> Considered, and discarded.
> 
> cf. http://article.gmane.org/gmane.comp.version-control.git/241498
> 

Thank you for the link, it hadn't turned up in my searching.

> When you see a version number vX.Y.0 next time, think of it as just
> play vX.Y without the third digit, and you will be fine.  People's
> script cannot learn the "think of it as ..." part overnight, and
> that is why we have the .0 there.

Sorry if I wasn't clear, I meant the useless digit is the first one,
which is currently "1." and has been hanging around for a bit over
eight years.

My worry is having "2." hang around for another decade or longer. I'd
rather see X.0.0 denote a major feature release (currently represented
as 1.X.0), with X.Y.0 for minor enhancements and X.Y.Z for bugfix. So
the major release version sequence would become 1.8.0, 1.9.0, 2.0.0,
3.0.0, with minor releases like 2.1.0, and bugfix releases like 2.1.1.

It seems reasonable to expect fewer backwards incompatible changes in
the future as Git has become more mature. This reduces the utility of
reserving X.0.0 for major backwards incompatible changes, especially
considering it's already been eight years for the first increment.

Andrew
