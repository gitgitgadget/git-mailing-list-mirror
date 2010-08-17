From: Mike Strauch <mike.strauch@hannonhill.com>
Subject: Ignoring commits when merging
Date: Tue, 17 Aug 2010 16:21:01 -0400
Message-ID: <AANLkTi=B9gsroJS_6SRqa2CLQOed2UguxN7KiFtFWL8t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 22:21:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlSey-0003ZY-6M
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 22:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828Ab0HQUVE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 16:21:04 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45155 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab0HQUVC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Aug 2010 16:21:02 -0400
Received: by bwz3 with SMTP id 3so3853973bwz.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 13:21:01 -0700 (PDT)
Received: by 10.204.16.209 with SMTP id p17mr4721944bka.157.1282076461157;
 Tue, 17 Aug 2010 13:21:01 -0700 (PDT)
Received: by 10.204.83.72 with HTTP; Tue, 17 Aug 2010 13:21:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153777>

Hi,

I'm fairly new to git and I'm trying to figure out the best way to
ignore certain commits when merging one branch into another. =A0I've
found a solution that suggests that I merge everything before the
commit I want to skip, then merge the commit I want to skip using the
"ours" merging strategy, then merge everything after the skipped
commit. =A0This sounds like an adequate solution to the problem, but I'=
m
wondering if there's a better way to do it.

I was thinking that I could just cherry-pick the few commits that I
want from Branch 2 in order to exclude the commit I don't want, but
this will result in there being no link between the branches for those
commits. =A0Are there any other ways this can be done?

--
Mike Strauch
www.hannonhill.com
