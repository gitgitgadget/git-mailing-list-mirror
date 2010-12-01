From: Dun Peal <dunpealer@gmail.com>
Subject: Proper way to checkout a tag?
Date: Wed, 1 Dec 2010 13:38:00 -0600
Message-ID: <AANLkTi=b12n0J+Qg4S7i9dnbMHoWvPS3OXP0CDZevT_4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 01 20:38:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNsVU-0006UT-QI
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 20:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081Ab0LATiD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 14:38:03 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57508 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755399Ab0LATiA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 14:38:00 -0500
Received: by qwb7 with SMTP id 7so7440396qwb.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 11:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=yXVSw5bRm6fzFndhcC1NM4L5OAAVwZMk2im0bStz/0s=;
        b=O+IMJ1Ct5enslEAHAe9aAKQSbuil25d9vvI8XA8jeVDT+PVo7B+oZTJ4TH2Uv8Gpbc
         TvvYtucfQFdrlJ57Z6pBPgav5Sws8Z68YZ7V5fxcO9CbgNqXw3FiMhrcksDo6I3bDFDX
         jpEpxiJvkE/nMNHi1PpTGEL8p/aGHAz1R7qD8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=wPmhvs9Zo8roWdwx9SCtXGDcCX61rZtGEhhRaSdTIrwYU8m5Tvki/SO5Xxv0BIzdWX
         vehi9/Wq4hx7PfF+c5wiRBIsrdcyR+Ljxc8KfX8ZkrHmwhuIaLJ6zheJVzwH6JPqYpda
         y+Qr2HDc/He7/8TGLRhgjxgDYoyxbzp1yYls0=
Received: by 10.224.74.13 with SMTP id s13mr8317453qaj.149.1291232280290; Wed,
 01 Dec 2010 11:38:00 -0800 (PST)
Received: by 10.220.128.133 with HTTP; Wed, 1 Dec 2010 11:38:00 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162581>

Hi. We tag our releases with names like "release-0", "release-1" and
so forth. Tags (lightweight ones) seem like the perfect markers for
these releases since we want a reference that can't ever change (as
opposed to a head).

The problem is that since there's no head pointing to each release, if
our users just:

$ git checkout release-1

When they want to build that release, they get into a detached HEAD
state. I've always construed detached HEAD as a non-standard state,
and it doesn't seem proper to reach it regularly in the course of a
standard operation like checking out past releases.

It's particularly confusing for our users who are new to Git.

Any thoughts, or alternative methods to do this?

Thanks, D
