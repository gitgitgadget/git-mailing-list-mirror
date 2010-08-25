From: "Todd A. Jacobs" <tjacobs@si2services.com>
Subject: Re: Bug report: %h for abbreviated hashes broken after 1.7.1
Date: Wed, 25 Aug 2010 01:07:28 -0400
Message-ID: <AANLkTi=+tGLfs-t6+fjRu68Mt76dJw4sbNCoO9q9+uyp@mail.gmail.com>
References: <AANLkTinR6_DFD_MbFRbtyJKPhZG1Os0ro=4TcC2h_xZo@mail.gmail.com>
	<20100825041440.GH11619@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 07:07:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo8D4-0004Ra-WC
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 07:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755545Ab0HYFHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 01:07:34 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33523 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754620Ab0HYFHd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 01:07:33 -0400
Received: by wyb35 with SMTP id 35so220964wyb.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 22:07:28 -0700 (PDT)
Received: by 10.216.35.74 with SMTP id t52mr6928405wea.41.1282712848790; Tue,
 24 Aug 2010 22:07:28 -0700 (PDT)
Received: by 10.216.229.164 with HTTP; Tue, 24 Aug 2010 22:07:28 -0700 (PDT)
In-Reply-To: <20100825041440.GH11619@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154418>

On Wed, Aug 25, 2010 at 12:14 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> $ git log --oneline v1.7.2.2..35039ced9296786bc0971bf5385c0d6f6ea5ea1e
> 35039ce archive: abbreviate substituted commit ids again

I'm not at all sure I understand your point. I'd already pointed out
that the referenced commit claimed to have fixed the problem, but
doesn't appear to be working in recent versions. With 1.7.2.2, I'm
still getting the unabbreviated commit IDs with %h.

Tag v1.7.2.2 is almost a month after 35039ce, so I'm not sure where
you're going with that, either. It should definitely be part of the
1.7.2.2 tarball, but the problem persists.

If I've somehow misunderstood your points, please restate them. The
problem is definitely ongoing, regardless of what 35039ce says.
