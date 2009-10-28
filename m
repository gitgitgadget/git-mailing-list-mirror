From: Matvejchikov Ilya <matvejchikov@gmail.com>
Subject: Is it possible to use git as a remote file storage without making any 
	local repos?
Date: Wed, 28 Oct 2009 15:09:09 +0300
Message-ID: <8496f91a0910280509p49447d6egd7c07b382657c375@mail.gmail.com>
Reply-To: matvejchikov@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 13:09:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N37L3-0004S5-HZ
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 13:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753434AbZJ1MJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 08:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753420AbZJ1MJG
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 08:09:06 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:47755 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753317AbZJ1MJF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 08:09:05 -0400
Received: by ewy4 with SMTP id 4so656874ewy.37
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 05:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:date:message-id
         :subject:from:to:content-type;
        bh=/doK7xO8IEuDssgj+z62Jr20UpXx5gXG0dzIW36Hihc=;
        b=w6xBm1gNd4JLtRWJ8dYrdtXEtJ9pqeUwuONS6H9TCDkN1DC013rfSIYGtnjrXSMfb3
         5AkaYO4H/Ea8DhpfsUORZ/tz2jERmUWtqRv9BP5mOVJig5nMrJmY8o/vaTfNJqEyS2Sb
         m8Car0qyRtmI+X2NbhLzpyeBNnHJHtnL5ROes=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        b=TPc4j8vkCR/6Xd+utCFwiUZrqWLi+nHsFHxBhPF/hp9jFf72QzBylO1Ub9Vxx1MFY9
         8+WCaMnvA/3Qgd0o4kFR1z6bE8yNSQiNvurxWpaOObZMQlBuRhmpbqWm4KZMiKVUrsYO
         +avO2fpeualdwhr/9Ap3SdVQuyvEH9CamxKVY=
Received: by 10.216.88.3 with SMTP id z3mr1992382wee.94.1256731749070; Wed, 28 
	Oct 2009 05:09:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131452>

Hi all,

My question is about using git as a remote file storage.

I have a remote storage server with a git-daemon running and I want to
be able to put some data in that repo
in a way like 'git hash-object -w <object>'. The general problem for
me is that I don't want to create any local
git repositories that is needed by 'pit push ...' etc.

So, is it possible to use git for remote storage purposes without
making local repository?

Thanks.
