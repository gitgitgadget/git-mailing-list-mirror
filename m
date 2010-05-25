From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Maintaining an html branch
Date: Tue, 25 May 2010 14:21:11 -0500
Message-ID: <20100525192111.GA7279@progeny.tock>
References: <AANLkTimMVn8fMVBmfNi4vR3kk3cXF2gq0Y9Ij5w3cl15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Christos Trochalakis <yatiohi@ideopolis.gr>
X-From: git-owner@vger.kernel.org Tue May 25 21:21:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGzgQ-0001Yg-39
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 21:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758559Ab0EYTUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 15:20:49 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:40028 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758530Ab0EYTUs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 15:20:48 -0400
Received: by wwg30 with SMTP id 30so158822wwg.19
        for <git@vger.kernel.org>; Tue, 25 May 2010 12:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=145AOTOQRsuO+lBsvYOcsFhEFHJlwrAc5uTPq7xc7js=;
        b=NnNdsdurB+3RYFz7jswo227MRkFgYRiF681MfbGy+VMo65erKI8SbD0gLLm9XpLu5l
         84bOTJcIfv7e6qwvgjZE1UcdVVXuENGHmKOIdVTxuJI2Zx516BLlqAopdoysNaj3mXi8
         0y7MUo/wI7HEFwUJ6hFzlGj/wJ+SDW58dAkSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XqiKZYHO++t6Fo4dEpq+rU/hXnLWixWe8xcveFnNUqgwaL2/1X6FBdK2MnCUkoLSvE
         rF4NyKw9fl6a8U5GBi4zbUhbC/WvuW//RVRO9w5nRKYQ96KufMJMszflG27oY4ShupsE
         ffzrJbRfWL28DpS4NzrlunRC9H954mmYP6HP0=
Received: by 10.216.86.1 with SMTP id v1mr5011460wee.215.1274815245859;
        Tue, 25 May 2010 12:20:45 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id d75sm1840742wek.8.2010.05.25.12.20.43
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 25 May 2010 12:20:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimMVn8fMVBmfNi4vR3kk3cXF2gq0Y9Ij5w3cl15@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147723>

Hi Christos,

Christos Trochalakis wrote:

> I would like to maintain an html branch for my repo, containing files
> under my '_site/' dir that is not version controlled.
[...]
> rm .git/html.index
> export GIT_INDEX_FILE=.git/html.index
[...]

Looks reasonable.  Way I suggest a simpler way?

If your goal is to publish an html branch with the rest of your
branches, I would recommend using a separate local repository that
pushes to the same remote repository[1].

If the goal is to stay under draconian disk quotas by not maintaining
two local repositories, one with the web site checked out all the
time, I suggest using contrib/workdir/git-new-workdir.

Hope that helps,
Jonathan

[1] See http://thread.gmane.org/gmane.comp.version-control.git/142831/focus=142865
for an example.
