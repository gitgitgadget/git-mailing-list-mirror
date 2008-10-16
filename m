From: "Richard Hartmann" <richih.mailinglist@gmail.com>
Subject: Feedback outside of the user survey
Date: Thu, 16 Oct 2008 12:19:36 +0200
Message-ID: <2d460de70810160319r4bed8643g884508cdeba772@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 12:21:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqPyb-0007sO-2R
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 12:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736AbYJPKTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 06:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbYJPKTj
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 06:19:39 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:11132 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702AbYJPKTi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 06:19:38 -0400
Received: by an-out-0708.google.com with SMTP id d40so225354and.103
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 03:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=5zPWZDpnfzVe0j8I3jF82DfNAgMkCh9c+YBL94fzJ3Q=;
        b=eQyoQgpah/YQV9BrsxdkxTPNdCTaqh2P+69TLsTdoJ1bVd7V3G15fIvz1L4/RlB5R0
         op5YISmnndcZJmkGlALnFDiCPESe8JYVHzHF5nsn0tTac1DcSSZnw4Fc7HBOItfIKrWc
         +x88BDvMbz2UMEehZCPniNrXpc3zIXZH8tR7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=QkgwLihYpaoJSkUFrVvGJzjcYhFYdcQmSBlkLkDC5pt9VZkf6qwc2Y08li01pYYq9h
         Ol+vkEDjAW4MqJdKMvb1iovxdxN3eFGgkvzRQfZPx1y8vxYGAxQg08os2AdfZsDpKiau
         yLcpkeXDEdEjhZBiyAqTyJah2cEg07MSxqs1A=
Received: by 10.100.127.18 with SMTP id z18mr3077547anc.6.1224152376838;
        Thu, 16 Oct 2008 03:19:36 -0700 (PDT)
Received: by 10.100.43.19 with HTTP; Thu, 16 Oct 2008 03:19:36 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98361>

Hi all,

unfortunately, I did not know there was a survey, so I did not
participate in it.

I still want to give some feedback from my experiences with
git.
From browsing the results [1] of said survey, I see one
request being made a lot of times. It's basically my main
gripe with git, as well :)

git can do a lot of things, but, as a new user, you are never
quite sure where to start. Docs are geared towards advanced
users (which is fine), but there is no easy entry point (which
is bad).

I would suggest three approaches to fix this:

1) A table/An overview along the lines of "So, you are used to
foo and that is how you do it in git."
For example "What is the equivalent of svn co" (yes, that is an
easy one ;). This should not be limited to things git can do.
svn's ability to pull a subdirectory, which is, ttbomk, lacking
in git, should be included, as well. I am sure there are other
examples [2].

2) A use case repository. "So you want to merge two
branches", etc. This would be a good place to explain the
different ways git offers to do stuff, as well.

3) A tutorial. It does not even have to be as sophisticated
as vimtutor. A simple text file specifying steps to do stuff
would be enough.


Thanks,
Richard

[1] http://www.survs.com/app/2/wo/7OeqmUsbjaDuuaLsOCLeSg/0.0.9.3.3.0.1.3.33.1.7.1
[2] http://www.survs.com/app/2/wo/7OeqmUsbjaDuuaLsOCLeSg/0.0.9.3.3.0.1.3.14.1.7.1
