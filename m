From: "Elijah Newren" <newren@gmail.com>
Subject: Easy Git (eg) -- brainstorming about git UI
Date: Mon, 10 Mar 2008 06:57:57 -0600
Message-ID: <51419b2c0803100557v6b36120bt17b38d325712f8c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Carl Worth" <cworth@cworth.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 10 13:58:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYhaQ-000398-1k
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 13:58:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbYCJM56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 08:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbYCJM56
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 08:57:58 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:48391 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbYCJM56 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 08:57:58 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2263459wah.23
        for <git@vger.kernel.org>; Mon, 10 Mar 2008 05:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=Pp2l5uq+dxQUFgPhNPfd88CyIr3MdDkLWpeylocqH7w=;
        b=Wp3hRqKh5PXzFRSXGtKQQqoT7z5rzELuA00Pe6vfnp+3Ql1c6edWZlbLjsZzBakwDbtDZ7uuUVjyOjZD3jSTjg69pBkwxrFfHs+/MIhec/bBBDKn324Z5htH3iKpTucVuO3wNPWFAvuhMNY83oFvq0tQInMm2YVT8dPMImYaB70=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=shahiMNWR6Ah4WCi/RI6OhTqX0wOxM0Ubzyyv8AJ2zN+ZnJupqB2p6jzNlRUdRxMzQPIvP0ZtFfE05HHf6ULKWvpUVoL1uNhWngMOqFb02175Uhl1TrXAe1gr2G+rDHEo2PAuNibiVFlH6M2cmk4So71RWsO9yHdEKo9pB2mAdo=
Received: by 10.114.191.1 with SMTP id o1mr3322999waf.66.1205153877243;
        Mon, 10 Mar 2008 05:57:57 -0700 (PDT)
Received: by 10.114.205.19 with HTTP; Mon, 10 Mar 2008 05:57:57 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76725>

Hi,

I thought I'd send a heads up to the list that I'm working on a
porcelain called eg (see http://www.gnome.org/~newren/eg/).  It's more
of a brainstorming session and demonstration than anything else.  I'm
not sure if anyone else will actually be interested, but it at least
has been serving to teach me more about git.  Here's a small blurb
about eg that I wrote last week:

    * eg is a brainstorming session about simplifying the user
interface of git, in the form of a usable demonstration
    * eg is predominantly an exercise in writing documentation; I'd
guess that 95% of the lines of the program are inline text for its
replacement help system.
    * eg is nearly command-line backwards compatible to git; those
familiar with git can start using eg by simply replacing "git" with
"eg" in their commands.
    * eg is example driven; the documentation focuses heavily on examples
    * eg is incomplete and probably buggy. Sorry, I'm working on it.

The first and last bullet points were too optimistic (or I caved in
and published this too early, take your pick).  There are *definitely*
bugs[1], and there's lots of things I haven't gotten around to doing
yet.

Elijah


[1] In addition to the bugs I have run across and not yet fixed, I
also made a bunch of changes recently without testing them.  So much
for getting everything done I wanted this weekend....and now it's time
to go to work.
