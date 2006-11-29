X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS24867 82.211.80.0/20
X-Spam-Status: No, score=1.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,MSGID_FROM_MTA_HEADER
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Path: news.gmane.org!not-for-mail
From: Jakub Narebski <jnareb@gmail.com>
Newsgroups: gmane.comp.version-control.bazaar-ng.general,gmane.comp.version-control.git
Subject: Re: git and bzr
Date: Wed, 29 Nov 2006 12:01:41 +0100
Message-ID: <200611291201.42561.jnareb@gmail.com>
References: <45357CC3.4040507@utoronto.ca> <456CBCD5.3050505@onlinehome.de>
	<Pine.LNX.4.63.0611291145510.30004@wbgn013.biozentrum.uni-wuerzburg.de>
NNTP-Posting-Host: main.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Trace: sea.gmane.org 1164798023 7854 80.91.229.2 (29 Nov 2006 11:00:23 GMT)
X-Complaints-To: usenet@sea.gmane.org
NNTP-Posting-Date: Wed, 29 Nov 2006 11:00:23 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
Original-X-From: bazaar-ng-bounces@lists.canonical.com Wed Nov 29 12:00:17 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GpNAm-0003p0-NC
	for gcvbg-bazaar-ng@m.gmane.org; Wed, 29 Nov 2006 12:00:16 +0100
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GpNAX-0000wW-7z; Wed, 29 Nov 2006 11:00:01 +0000
Received: from ug-out-1314.google.com ([66.249.92.173])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <jnareb@gmail.com>) id 1GpNAS-0000w3-T1
	for bazaar-ng@lists.canonical.com; Wed, 29 Nov 2006 10:59:57 +0000
Received: by ug-out-1314.google.com with SMTP id e2so1525430ugf
	for <bazaar-ng@lists.canonical.com>;
	Wed, 29 Nov 2006 02:59:56 -0800 (PST)
Received: by 10.67.97.18 with SMTP id z18mr3026629ugl.1164797996201;
	Wed, 29 Nov 2006 02:59:56 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209])
	by mx.google.com with ESMTP id 27sm4195547ugp.2006.11.29.02.59.54;
	Wed, 29 Nov 2006 02:59:54 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0611291145510.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Original-Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Xref: news.gmane.org gmane.comp.version-control.bazaar-ng.general:19831 gmane.comp.version-control.git:32633
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32633>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:

> On Tue, 28 Nov 2006, Nicholas Allen wrote:
> 
>> [Linus wrote...]
>>> 
>>> So the tools are certainly there. "git status" just isn't necessarily the 
>>> best one (or the best that it could be, for that matter)..
>> 
>> I guess I hit a limitation in the output of status as opposed to a
>> limitation in what git can do ;-)
> 
> I think it is something different altogether: you learnt how to use CVS, 
> and you learnt how to use bzr, and you are now biased towards using the 
> same names for the same operations in git.
> 
> I actually use git-status quite often, just before committing, to know 
> what I changed. But I will probable retrain my mind to use "git diff" or 
> even "git diff --stat", because it is more informative.
> 
> As for your scenario: There really should be a "what to do when my merge 
> screwed up?" document.

It would be nice to have git-resolved (or git-resolve) wrapper around
git-update-index similar to git-add, git-mv, git-rm which would mark
file as resolved, without need for git-update-index, git-add and git-rm
even in the case of CONFLICT(rename/rename). Although I'm not sure
if it could work in all cases in the simple form of "git resolved <file>",
e.g. in the case of CONFLICT(add/add).

By the way, I wonder if git can detect the case when the same (or nearly
the same) file was added in two different branches under different
filename...

