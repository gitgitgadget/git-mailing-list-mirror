From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: working with a large repository and git svn
Date: Wed, 12 Jan 2011 21:23:00 -0600
Message-ID: <20110113032300.GB9184@burratino>
References: <AANLkTimKbS3ECzOaGtNgvx7DThJGH_DkPmg4ehKXGtwc@mail.gmail.com>
 <201101120830.47016.wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joe Corneli <holtzermann17@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: "Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Thu Jan 13 04:23:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdDmr-0005K7-1p
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 04:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725Ab1AMDXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jan 2011 22:23:40 -0500
Received: from mail-yi0-f42.google.com ([209.85.218.42]:55783 "EHLO
	mail-yi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932602Ab1AMDXj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jan 2011 22:23:39 -0500
Received: by yia28 with SMTP id 28so518324yia.1
        for <git@vger.kernel.org>; Wed, 12 Jan 2011 19:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=DGJ/1kYQdvnTgMFkC+EWV/inBajH1eaZR/a6xK7nHBM=;
        b=X7LawmjMyEvofFjcZS7TrmuRC3SA1VgVq9pUlc9Yf2i8p84wSu0QE5Iuws5+u5ZIgZ
         6sChwTFGvsq7yS4/P6wGS340vz5ZjE+wmRs0Ijre95L3Zia5j4hWWMj0a6+5aA80qq6O
         XTKuXw75mq6IDnOv41zJsCb6F00kDjYL+V6jY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=B1+5wYnNWxTgQDO9wn8uU+qk3L4ehmM/k+SvF4YmYzZzB57qYAVQK2xYxN5Jr17UY7
         DWmaRtDflmKEwt9JOAGbSEUqmWB2Igll3OF3coZuFLGGhvRY1svt6tpT7JJTJKSnP3GL
         0l92vrVh4zh1HVAUf5q+UM8iZBHaiViagYkLA=
Received: by 10.151.82.7 with SMTP id j7mr2916083ybl.435.1294889017437;
        Wed, 12 Jan 2011 19:23:37 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id v7sm4186216ybe.15.2011.01.12.19.23.35
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 12 Jan 2011 19:23:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201101120830.47016.wjl@icecavern.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165036>

Wesley J. Landaker wrote:

>   3) I love git-svn for working with Subversion repositories, but you could 
> consider a different tool, like tailor, if you can't make git-svn do what 
> you want. I have also heard talk (but I don't know the state of things) of 
> people working on a fast-import tool for SVN, so you could git-fast-export 
> and svn-fast-import in a big batch.

I think the state of the art is currently git2svn[1] + "svnrdump load".
This requires permission to change properties on the svn repo, just
like svnsync would.

Hope that helps,
Jonathan

[1] http://repo.or.cz/w/git2svn.git
