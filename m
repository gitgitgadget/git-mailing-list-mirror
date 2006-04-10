From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: Re: git pull origin doesn't update the master
Date: Mon, 10 Apr 2006 10:21:34 +0530
Message-ID: <cc723f590604092151p7c8c44e3g14decc09c0e24383@mail.gmail.com>
References: <cc723f590604092141q3517136cmc0a895a069021b8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Apr 10 06:51:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSoNG-00062f-Gx
	for gcvg-git@gmane.org; Mon, 10 Apr 2006 06:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWDJEvf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Apr 2006 00:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWDJEvf
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Apr 2006 00:51:35 -0400
Received: from wproxy.gmail.com ([64.233.184.227]:44395 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750758AbWDJEvf convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Apr 2006 00:51:35 -0400
Received: by wproxy.gmail.com with SMTP id i11so667812wra
        for <git@vger.kernel.org>; Sun, 09 Apr 2006 21:51:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R1DbFAikX0FrP53Yn/hcDPmwDZ0YLK8RKpcdkYmwXgeF5lt97lX81OAY+CR1EBinD5HLcWu55N0u5YbJteYmgZu5Hai87sLa82DCKnE1p+IaDjsdAIpLsODNcGvruPsa1i8J3OxY6bghnYLIn2chcz57PoLHk+13fihawnzUbWE=
Received: by 10.64.3.9 with SMTP id 9mr297892qbc;
        Sun, 09 Apr 2006 21:51:34 -0700 (PDT)
Received: by 10.64.114.13 with HTTP; Sun, 9 Apr 2006 21:51:34 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>
In-Reply-To: <cc723f590604092141q3517136cmc0a895a069021b8f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18577>

On 4/10/06, Aneesh Kumar <aneesh.kumar@gmail.com> wrote:
> While updating the git code base the master branch is not getting
> updated. First look tell me that the below commit is the issue
> a9698bb22fb7b66e5882c3a5e7b2b8b53ea03f90
>
> git-pull.sh does
> git-fetch --update-head-ok "$@" || exit 1
>
> and git-fetch.sh exit with status 1 printing the below message
>
> * refs/heads/pu: does not fast forward to branch 'pu' of
> http://git.kernel.org/pub/scm/git/git;
>   not updating.
>
>


I think the git-update-server-info is not run on kernel.org. I am
using the http fetch

562036a04223709de4922873238462007bcb529f	refs/heads/pu
$ more pu
c52d221ba03c84e0b818d19f7ec30cb4d75fe509
$

-aneesh
