From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: VCS popularity
Date: Tue, 31 Mar 2015 23:56:44 +0200
Message-ID: <CAA787rkKYQ=TJezeLy0f=aGs2GR8ypuxmr2qA2py+hGsC+juVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 31 23:57:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd49T-0002nh-6v
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 23:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266AbbCaV4r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2015 17:56:47 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:33930 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277AbbCaV4q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2015 17:56:46 -0400
Received: by lagg8 with SMTP id g8so23203381lag.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2015 14:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=5dnm/UfjFoVHEu3JtKrR1630NDdu4HryyL6mQBx2Myo=;
        b=I1VDJ01sIjk8iCohPIgL/UtX7mhCBfp8Mr60nlU7hSNy0gO+Y+M5khmIJUYlWYfDNI
         sm7HTI+bIzNzewwQx4f8cQMfBAzp637lkyCvrMMWsBoDpZenxcBoi4oMYxZEYoZMJtKC
         vrvbg5/gxkMHGwAczot+AnPlGn0lwXfTnbp49HUG6gwH+iQ9NnBTLEBoLdBNIo4qhnH4
         6PT1BEm6LktYvRhDmwZRrhnrNSnfgs1itArY9h7I1hKtnMh6JTSb+EMiVMnFVe5Tv8Vn
         z9WLJRfBbel6AYBbqHqvqUcvQ4nvXwsNhlhVUHrxES/cGsiNFsYU9/Lj0S8vs55A8cBj
         iDgQ==
X-Received: by 10.112.17.68 with SMTP id m4mr32604500lbd.50.1427839004844;
 Tue, 31 Mar 2015 14:56:44 -0700 (PDT)
Received: by 10.112.156.231 with HTTP; Tue, 31 Mar 2015 14:56:44 -0700 (PDT)
X-Google-Sender-Auth: q2ob2y0D58zFcttafp0OiXGra5M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266562>

openhub.net (formerly ohloh.net) has an interesting comparison of the
number of public repositories on the net, based on searches of popular
hosting services. This comparison is available at
<https://www.openhub.net/repositories/compare> and shows an estimated
market share between Bazaar, CVS, Git, Mercurial and Subversion.

I've been monitoring this since 2014-08-05 to see how things were
developing, and it's a good indication of the popularity of the various
version control systems.

I've created a repository at
<https://github.com/sunny256/openhub-repositories> where the project
scripts and data files are stored, along with graphs in SVG format.

The graphs are pretty interesting:

https://github.com/sunny256/openhub-repositories/blob/master/graph/rela=
tive.svg
  Graphs of relative growth between the various version control systems=
=2E

https://github.com/sunny256/openhub-repositories/blob/master/graph/rela=
tive-zoom.svg
  Zoomed-in version of relative.svg. Git goes through the ceiling.

https://github.com/sunny256/openhub-repositories/blob/master/graph/repo=
s.svg
  Total number of repositories.

- =C3=98yvind
