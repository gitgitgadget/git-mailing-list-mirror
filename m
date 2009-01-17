From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] http-push: update tests
Date: Sat, 17 Jan 2009 22:24:03 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901172223250.3586@pacific.mpi-cbg.de>
References: <be6fef0d0901161859qbea135bwe89e48caaa69a77c@mail.gmail.com>  <alpine.DEB.1.00.0901170621440.3586@pacific.mpi-cbg.de>  <be6fef0d0901170040r7e11806et87cc5dc3c6f13a2a@mail.gmail.com>  <7vsknh7og5.fsf@gitster.siamese.dyndns.org> 
 <be6fef0d0901171155p26e14aa1t90c0d7b8ec7925f3@mail.gmail.com>  <m3zlhpy981.fsf@localhost.localdomain> <be6fef0d0901171300t44b60aedm801f6f18d88b654b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 17 22:24:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOIf0-0005HD-VM
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 22:24:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760340AbZAQVXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 16:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757592AbZAQVXd
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 16:23:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:47158 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756853AbZAQVXd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 16:23:33 -0500
Received: (qmail invoked by alias); 17 Jan 2009 21:23:31 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp033) with SMTP; 17 Jan 2009 22:23:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19otdBBjhJoSW01AAlqGkT4e5mZU/nbOmDW3BF4mc
	j/NTwvvmkDUiVm
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <be6fef0d0901171300t44b60aedm801f6f18d88b654b@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106108>

Hi,

On Sat, 17 Jan 2009, Ray Chuan wrote:

> -test_expect_failure 'push to remote repository' '
> +test_expect_success 'push to remote repository' '
>  	cd "$ROOT_PATH"/test_repo_clone &&
>  	: >path2 &&
>  	git add path2 &&
>  	test_tick &&
>  	git commit -m path2 &&
> -	git push &&
> +	git push origin master &&
>  	[ -f "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/refs/heads/master" ]
>  '

But it _should_ succeed without <remote> <branch>.  It should find that 
there is a master locally and one remotely, and push that.

Ciao,
Dscho
