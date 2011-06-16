From: tumik <tumik@tuomisalo.com>
Subject: Re: [git-p4] Trouble importing all perforce branches into git
 repository
Date: Thu, 16 Jun 2011 02:35:28 -0700 (PDT)
Message-ID: <1308216928289-6482333.post@n2.nabble.com>
References: <5A927B4F-7242-48AD-BC1C-BCA490A251C4@gmail.com> <20110522114917.GA19927@arf.padd.com> <398FA881-E4A1-49AC-80F2-2D46E9F2ABB9@gmail.com> <BANLkTi=TCyyS7Q=3BnLcG=yhL_boH=w1XA@mail.gmail.com> <34E33A18-B9C4-4CA9-B96C-79B0E2BDCD44@gmail.com> <BANLkTik+Zp1Fvi_zABCtAZH0RKA68n5Svw@mail.gmail.com> <0AC6DD14-3042-4A18-91AC-1CE77D8B4CD2@gmail.com> <1308212906486-6482174.post@n2.nabble.com> <BANLkTikTt4vMj+iZMhGEi6JefRUkZGZ8dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 16 11:35:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QX8zB-00056e-7a
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 11:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756438Ab1FPJfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 05:35:31 -0400
Received: from sam.nabble.com ([216.139.236.26]:37823 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752422Ab1FPJf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 05:35:29 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <tumik@tuomisalo.com>)
	id 1QX8z2-0000au-9d
	for git@vger.kernel.org; Thu, 16 Jun 2011 02:35:28 -0700
In-Reply-To: <BANLkTikTt4vMj+iZMhGEi6JefRUkZGZ8dg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175890>


Thomas Berg wrote:
> 
> git-p4 only uses the branch mapping for the initial commit on a
> branch. It does not attempt to detect merges after that point. After
> importing to git, merges just appear as regular commits in the
> history.
> 
Thank you for the info, that's the way it seems to be working! It's a shame
if the cloning from perforce -> git can't be made succesfully keeping all
the history information :(


Thomas Berg wrote:
> 
> There was another script called git-p4raw for importing Perforce
> history to git, which does merge detection. It solved the problem by
> having configurable rules for what should be regarded as a merge, and
> it supported manually reviewing the decisions afterwards (iirc).
> 
Yes, I tried the git-p4raw too. Actually even several forks of it! But I
wasn't able to get any of those working, as none of them could load the
perforce database correctly. Maybe the perforce database has changed lately
or something, as git-p4raw gave errors that it's database tables don't have
as much columns as perforce's does. Tried also to change the code to add
those columns but there were so many of them and in many tables so I decided
it's too hard and time-consuming to start reverse-engineering them..

- tumik

--
View this message in context: http://git.661346.n2.nabble.com/git-p4-Trouble-importing-all-perforce-branches-into-git-repository-tp6383422p6482333.html
Sent from the git mailing list archive at Nabble.com.
