From: Andreas Ericsson <ae@op5.se>
Subject: Re: End year project : minimal Git client based on libgit2
Date: Thu, 19 May 2011 08:18:48 +0200
Message-ID: <4DD4B648.8040509@op5.se>
References: <BANLkTinGPvekMDT5nmsFQp3SpR_QOYq+UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marc Pegon <pegon.marc@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 19 08:18:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMwZU-0004k9-U7
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 08:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584Ab1ESGSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 02:18:52 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62396 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932267Ab1ESGSv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 02:18:51 -0400
Received: by bwz15 with SMTP id 15so2072741bwz.19
        for <git@vger.kernel.org>; Wed, 18 May 2011 23:18:50 -0700 (PDT)
Received: by 10.204.14.129 with SMTP id g1mr2732417bka.122.1305785930286;
        Wed, 18 May 2011 23:18:50 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id q25sm1398831bkk.10.2011.05.18.23.18.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 18 May 2011 23:18:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Thunderbird/3.1.10 ThunderGit/0.1a
In-Reply-To: <BANLkTinGPvekMDT5nmsFQp3SpR_QOYq+UA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173931>

On 05/18/2011 06:42 PM, Marc Pegon wrote:
> Hello everyone. We are a team of four students from a French school of
> engineering (Ensimag: http://ensimag.grenoble-inp.fr/). To end the
> school year, we are supposed to work on a four-week full-time project,
> under the supervision of Matthieu Moy, who has been following Git's
> development for quite a few years now. We thought it would be
> interesting to contribute to git/libgit2. We are especially interested
> in one of the GSoC2011 ideas : Build a minimal Git client based on
> libgit2 (http://git.wiki.kernel.org/index.php/SoC2011Ideas#Build_a_minimal_Git_client_based_on_libgit2)
> 

Cool project :)

> We started by taking a look at libgit2 API and Git source code, and we
> have already begun to write some (quick and dirty) code.
> We would like to know more about your expectations around the
> "minimal" git client. What are the key features to implement ?
> According to the GSoC proposal, we should implement some high level
> functionalities (push, commit, branch...). Perhaps we should
> concentrate on more "plumbing" commands ?
> 

If you can make the plumbing commands work it should be trivial to
script the other tools on top of the plumbing.

Otoh, coding up the commands currently implemented as scripts in C
with libgit2 as backend would increase the chance of acceptance into
git.git proper, since you'd then be doing something worthwhile for
the git core.

Then again, creating bindings into other languages and writing up
the minimal git in python or some such would also be extremely
useful and worthwhile, and probably faster than writing the minimal
git from scratch in C as well.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
