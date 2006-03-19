From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Cloning from sites with 404 overridden
Date: Sun, 19 Mar 2006 15:04:43 +0100
Message-ID: <e5bfff550603190604ne4364f3o6a862d25267a2dce@mail.gmail.com>
References: <e5bfff550603190252n7e3e1cbbp94e3f15c92f12d07@mail.gmail.com>
	 <4d8e3fd30603190525o5a01fba8w5bcdedd064c213ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Mar 19 15:04:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKyWX-0006I7-19
	for gcvg-git@gmane.org; Sun, 19 Mar 2006 15:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWCSOEp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Mar 2006 09:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWCSOEp
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Mar 2006 09:04:45 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:23145 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932095AbWCSOEp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Mar 2006 09:04:45 -0500
Received: by zproxy.gmail.com with SMTP id r28so928285nza
        for <git@vger.kernel.org>; Sun, 19 Mar 2006 06:04:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X8MHOg11KAovH9GEXRemyQEHTDSoeb80HgK8Wx6RhEi/Gtl96Oa+IiOfD/alYKPjbt+JIjKHwl6VNbL0V7YTZ+fAZbMJLl6f93Avn0rRyCIgSGvab3ruc1O3ZojtFX6V6eFYDHxIqrX8zASNe2QiLwdwkccUYCsRWzZLybYpYbE=
Received: by 10.64.250.4 with SMTP id x4mr483200qbh;
        Sun, 19 Mar 2006 06:04:43 -0800 (PST)
Received: by 10.64.131.10 with HTTP; Sun, 19 Mar 2006 06:04:43 -0800 (PST)
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
In-Reply-To: <4d8e3fd30603190525o5a01fba8w5bcdedd064c213ec@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17715>

On 3/19/06, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> On 3/19/06, Marco Costalba <mcostalba@gmail.com> wrote:
> >
>
> How about getting an account on kernel.org?
>

I don't think I have the credentials to ask for ;-)

> Anyway, here is what I did:
> paolo@Italia:~$ cg-clone
> http://digilander.libero.it/mcostalba/scm/qgit.git qgit defaulting to
>
> Why am I getting this error?
> error: File 8dea03519e75f47da91108330dde3043defddd60
> (http://digilander.libero.i
> t/mcostalba/scm/qgit.git/objects/8d/ea03519e75f47da91108330dde3043defddd60)
> corr upt
>

Because http server of digilander.libero.it instead of responding with
404 code (page not
found) sends a not standard html page as answer. To see the page just point
your browser to:
http://digilander.libero.it /mcostalba/scm/qgit.git/objects/8d/ea03519e75f47d

Git does not understand object is missing and thinks what site sends
_is_ the requested
object and then founds that is (of course) corrupted.


Marco
