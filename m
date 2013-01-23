From: Hans-Juergen Euler <waas.nett@gmail.com>
Subject: git-svn problems with white-space in tag names
Date: Wed, 23 Jan 2013 11:23:42 +0100
Message-ID: <CAK3CF+4GPKBfAmgsHYnf_6nCCOCe-1d31cGsWp4jkKC28cZr0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 23 11:24:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxxV0-0004X1-Rb
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 11:24:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754728Ab3AWKXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 05:23:45 -0500
Received: from mail-wg0-f53.google.com ([74.125.82.53]:46651 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754655Ab3AWKXo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 05:23:44 -0500
Received: by mail-wg0-f53.google.com with SMTP id fn15so1357036wgb.20
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 02:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=iHIeJe0mx6F1LBTDuzeTk6bIZHVFWJKHJJIl97kKsrI=;
        b=RDZwWGDqE5P72JsZKhuD/5j/dz5SY2EjorAcqKb0azlTkpToU8dQbpkEuI5Lq2zQhs
         ip6BrYXL4nDKDGP1x9k/0bJ/EtaHmuGwCYZc0iZD2jbJkGzRv4wFhtCBb2/FswBNIuH/
         LThGYuqTEkseJAMPPQHrUpl/9XkeLUjBJnTwCHVS0lSVy14hu4Upaq5vP48kTY9GuU/e
         vBFruio7CHX3XSlssyIE5ofN2w7y1fxoNt9IUmpp8KKMRdpDqfIqU8zl7Sz5O1XjuaiB
         UEUJP6zqAJlxFNJDhiEIpCj08psaR0I3olmm+twly0qaZX12JctLxWbzpvC1YGfYBO73
         GSHQ==
X-Received: by 10.180.84.131 with SMTP id z3mr26242933wiy.25.1358936622811;
 Wed, 23 Jan 2013 02:23:42 -0800 (PST)
Received: by 10.194.221.232 with HTTP; Wed, 23 Jan 2013 02:23:42 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214308>

I have discussed already the problem a bit more in this thread
groups.google.com/d/topic/git-users/kfMFZ3uEFsM/discussion

-----Operating system (specifically which version)
windows 7 64 bit

------Git version (git --version)
Git version 1.8.0 for windows obviously.
git bash and git gui installed and using

------Git configuration (system, home, repository)
hmm guess is covered with git bash and git gui. Using the standard config stuff

using subversion
TortoiseSVN 1.7.11
Subversion 1.7.8
Was typically always up-to-date (within 2 months or so) with previous versions

using an external subversion provider for storing the information
externally. guess the version there is older but do not know


I have tried to convert some of my external subversion data bases with
git-svn clone

I have encountered a problem with one of my subversion repos. I have
obviously introduced about 2 years ago a problem with an additional
white space at the end of tag name.

So there is an entry "tags/blabla "

in the subversion repos. The sequential handling of the svn repos with
git-svn gets stuck there. I could not find a way around this. My guess
is that the white-space was introduced by accident on windows by
Tortoise-SVN.
Unfortunately this occurs at revision 90 something and I have almost
1000 revisions stored.

Let me know if you need more details.Thanks.
