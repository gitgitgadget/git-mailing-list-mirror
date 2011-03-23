From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: Histogram diff, libgit2 enhancement, libgit2 => git merge (GSOC)
Date: Wed, 23 Mar 2011 01:24:11 +0100
Message-ID: <4D893DAB.3000501@lyx.org>
References: <op.vsm1yszq2m56ex@localhost.localdomain> <AANLkTi=Fu5v-5E2dSAA74f0juUQNjNjus5XFWqMb9v9k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Vicent Marti <vicent@github.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 01:24:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Bs7-00024c-C6
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 01:24:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755928Ab1CWAYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 20:24:15 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59536 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755164Ab1CWAYO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 20:24:14 -0400
Received: by ewy4 with SMTP id 4so2001543ewy.19
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 17:24:13 -0700 (PDT)
Received: by 10.14.11.227 with SMTP id 75mr1606627eex.110.1300839853294;
        Tue, 22 Mar 2011 17:24:13 -0700 (PDT)
Received: from [145.94.80.223] (x080223.tnw-m.tudelft.nl [145.94.80.223])
        by mx.google.com with ESMTPS id b52sm3217978eei.1.2011.03.22.17.24.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Mar 2011 17:24:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; nl; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <AANLkTi=Fu5v-5E2dSAA74f0juUQNjNjus5XFWqMb9v9k@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169789>


> b) Write a minimal Git client using libgit2. Peff keeps bringing this
> up and I think it's a bangin' good idea. Write something small and
> 100% self contained in a C executable that runs everywhere with 0
> dependencies -- don't aim for full feature completion, just the basic
> stuff to interoperate with a Git repository. Clone, checkout, branch,
> commit, push, pull, log. I would totally use that shit on my Windows
> boxes. And since it'll be externally compatible with the original Git
> client, we can reuse the Git unit tests to test libgit2. HA. Awesome!
>

I would dream of having a platform-independent GUI based on libgit2 
which could be used to manage a large project. Setup the workflow in the 
app, requiring only single  mouseclicks to promote a topic branch into 
the stable series. Have a button to merge all maint-branch-updates into 
the other branches. And more..

In order to come up with a possible workflow for our project, I have 
been checking out how Git is managed. I got a little bit disappointed 
that Junio uses some 'home-brewn' scripts for Git. I don't want to write 
them myselves (on Windows).

I'm happy to see that the 'vger' people are supporting libgit2.

Anyway, when I do have some time, I am willing to contribute to the 
libgit2 project.

Greetings,

Vincent
