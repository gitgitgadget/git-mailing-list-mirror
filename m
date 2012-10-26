From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git submodule summary doesn't return an error when passed a wrong
 commit/rev
Date: Fri, 26 Oct 2012 21:53:29 +0200
Message-ID: <508AEA39.2020205@web.de>
References: <CAC9WiBgdgy1bwh0c16jd017q2rqQAq-suDADn2-vGw9eubBs_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 21:53:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRpyR-0005ql-R2
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 21:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966273Ab2JZTxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 15:53:31 -0400
Received: from mout.web.de ([212.227.17.12]:55628 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966267Ab2JZTxb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 15:53:31 -0400
Received: from [192.168.178.41] ([79.193.90.117]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0MKrLo-1TRpyD2G3M-000mGw; Fri, 26 Oct 2012 21:53:29
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <CAC9WiBgdgy1bwh0c16jd017q2rqQAq-suDADn2-vGw9eubBs_w@mail.gmail.com>
X-Provags-ID: V02:K0:II67B4PbJKmz+vYHqItaLnONVYPMqn0emDLUTw8JkEz
 1JwuTqlpeYdnUe9vW0719QaWzen02sXjNA/cBYZeDIdybKvl2o
 pMl/2FSJk1L/yUdqmZRLtffQ7BjRo7WpBzt8nQYVJR+z2A6GtE
 EFKes+F95aDGrweB5LlxLqn4DFAw0HUZ4EuJRZQEKT3D1p7iUW
 OTV282GFVXsmKI5NwdBVw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208487>

Am 26.10.2012 16:03, schrieb Francis Moreau:
> it seems to me that when passed an unknown rev or a wrong commit/sha1,
> git-submodule-summary should at least exit with an error status. Even better
> would be a error output.
> 
> Test was done with git version 1.7.10.4 from debian wheezy.

Thanks for your report, I think you found a real issue. Some quick
tests showed some problems with other parameter combinations too.
I'll take a deeper look the next days.
