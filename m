From: John Bito <jwbito@gmail.com>
Subject: Re: integrating make and git
Date: Wed, 15 Apr 2009 14:34:33 -0700
Message-ID: <3ae83b000904151434t5c3c85ebvec391ec29981ff79@mail.gmail.com>
References: <3a69fa7c0904150819x7598dea5ic43bf0991c35ae45@mail.gmail.com>
	 <alpine.LNX.1.00.0904151148030.19665@iabervon.org>
	 <3a69fa7c0904150947w25783199n6e304d7b4efcd051@mail.gmail.com>
	 <alpine.LNX.1.00.0904151654330.10753@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 15 23:36:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuCm8-0007GT-84
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 23:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753850AbZDOVef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 17:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752855AbZDOVef
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 17:34:35 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:30118 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbZDOVee (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 17:34:34 -0400
Received: by qw-out-2122.google.com with SMTP id 8so132872qwh.37
        for <git@vger.kernel.org>; Wed, 15 Apr 2009 14:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=+P47xcXLcIn2UB5EyebXdTaUHZ8mO6GPYwlRlkc+yjc=;
        b=XHtQToKvWaBW39TU4jpOWLCU6Y2+ZtPYns98Z+wIBgt1kw8BH9lTvMyeKufvmnIhRc
         h6wyv1Db89AMnAUNTUk3y5016QOi5WG1pfBycOi1xqreu1wRTcv7DmbJwI1ZpQCEhMUL
         cNvJ3dkLuOkKCY8xtT/aPHnC8bIlXOQaVTq4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=lmIx8WEBlpZ/PFWlvhXvfmWGC5RK4b6sgmPv65Di2uTAXREov8ZHdgAuf+oArHhVq0
         UfY7SIacsm5UQoweU3nZPjRv0gYq75duBua6x9T+IgK6vXK4dXS+qSwcWFiW2stL3RMc
         U4K/o969D/dSLhV3xUfhgFl/DbLCcwwRGwXNU=
Received: by 10.229.80.21 with SMTP id r21mr112417qck.80.1239831273369; Wed, 
	15 Apr 2009 14:34:33 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.00.0904151654330.10753@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116650>

If you're not already using make for a project, think before you
start.  If you're building something that will go into distribution in
source form, you probably should need to use it (via automake &
autoconf).  For the stuff that I'm doing in a more focused
environment, I use boost-build/bjam
(http://www.boost.org/users/download/boost_jam_3_1_17).  This provides
very clean organization of release/debug builds as well as a much more
expressive language than make.

It's easy to create makefiles that are quite brittle and the plumbing
to establish portable builds is really complex.  I was away from make
working on Java & Ruby for almost ten years.  Though I have more than
10 years of experience with make, I'm very happy to have replaced gobs
of makefile code with the boost-build package and a few, short
Jamfiles.

YMMV
John
