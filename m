From: Santi <sbejar@gmail.com>
Subject: Re: [PATCH] Fetch: get the remote branches to merge from the branch properties.
Date: Sat, 23 Sep 2006 02:47:01 +0200
Message-ID: <8aa486160609221747s7859c6b6jb7164abe72b74e80@mail.gmail.com>
References: <874puza2qq.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Sep 23 02:47:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQvff-0005w8-RY
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 02:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbWIWArF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 22 Sep 2006 20:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbWIWArE
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 20:47:04 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:32499 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964982AbWIWArC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Sep 2006 20:47:02 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1190609wxc
        for <git@vger.kernel.org>; Fri, 22 Sep 2006 17:47:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Eb9QUFLr0jRSREmHGGppveC89iOezTfYCFdG0YUr99oBGS+dhqGNhDf4sV+Jln9j4kHKqsOqVrDFJlsjLy6SS5XfoLcYbu2ndGh06CGxQk17QBwMq0eIhfvRZAkF0ibUkCisMb5j0y9nXycLxaQ3ydIetth0mNE80hotRqu1U1s=
Received: by 10.70.59.9 with SMTP id h9mr2125185wxa;
        Fri, 22 Sep 2006 17:47:01 -0700 (PDT)
Received: by 10.70.19.6 with HTTP; Fri, 22 Sep 2006 17:47:01 -0700 (PDT)
To: git <git@vger.kernel.org>
In-Reply-To: <874puza2qq.fsf@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27552>

2006/9/23, Santi B=E9jar <sbejar@gmail.com>:
> If in branch "foo" and this in config:
>
> [branch "foo"]
>        merge=3Dbar
>
> "git fetch": fetch from the default repository and program the "bar"
>              branch to be merged with pull.
>
> Signed-off-by: Santi B=E9jar <sbejar@gmail.com>

Just to comments (it's late here):

=2E- the branch.foo.merge must be the same as specified in the remotes/=
$remote.

=2E- I've already found a bug (it's late and I need to sleep, sorry).
This must only be done for the default repository (origin, or in
branch.foo.remote).

Santi
