From: Andreas Ericsson <ae@op5.se>
Subject: Re: Really beginner on Version Control
Date: Tue, 21 Sep 2010 18:40:23 +0200
Message-ID: <4C98DFF7.2030801@op5.se>
References: <1285080133451-5555023.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: FernandoBasso <FernandoBasso.br@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 21 18:40:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy5tY-0001Py-7V
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 18:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757996Ab0IUQka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 12:40:30 -0400
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:35267 "HELO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753740Ab0IUQk3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Sep 2010 12:40:29 -0400
Received: from source ([209.85.215.50]) by na3sys009aob101.postini.com ([74.125.148.12]) with SMTP
	ID DSNKTJjf+jVwizE2pagl8qYzzKTjnEC6ZRWi@postini.com; Tue, 21 Sep 2010 09:40:29 PDT
Received: by mail-ew0-f50.google.com with SMTP id 24so2895465ewy.37
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 09:40:26 -0700 (PDT)
Received: by 10.213.5.16 with SMTP id 16mr8527143ebt.12.1285087226590;
        Tue, 21 Sep 2010 09:40:26 -0700 (PDT)
Received: from clix.int.op5.se (fw1-sth-pio.op5.com [109.228.142.130])
        by mx.google.com with ESMTPS id a48sm13098180eei.19.2010.09.21.09.40.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Sep 2010 09:40:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.11) Gecko/20100720 Fedora/3.0.6-1.fc12 Thunderbird/3.0.6 ThunderGit/0.1a
In-Reply-To: <1285080133451-5555023.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156732>

On 09/21/2010 04:42 PM, FernandoBasso wrote:
> 
> I am really a beginner in. Bear with me please.
> 
> Why do we merge, say a testing branch into the master branch ? What is the
> use of it ?
> 

Because the sum of the whole is greater than the parts. Most features in git
for example are developed on topic branches. This makes it possible to keep
unfinished code separate from the production branch that people actually use.

> When there is a conflict when merging branches (merging the testing into the
> current branch), should I edit the 'current' branch or the 'testing' branch
> ?
> 

You should edit the working tree, since that's where the conflict will be
staged. When you're done, commit the results and that will be a new commit
on the branch you're on.

> Should both branches have exactly the same code so that they can be merged
> without conflicts ?
> 

Both branches should most definitely not have exactly the same code. If they
did, there would be no point in merging them. The merge-result shouldn't
have the same code as any of the branches either, unless you actually want
to throw one branch away, in which case you'd be far better off doing just
that.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
