From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Creating remote branch called HEAD corrupts remote clones
Date: Wed, 27 Apr 2011 12:48:56 +0300
Message-ID: <BANLkTinkR+jEKkno30fiHBZ-PMVvvv7FxQ@mail.gmail.com>
References: <ih1449$ul6$1@dough.gmane.org>
	<7v62tjs66r.fsf@alter.siamese.dyndns.org>
	<20110120203840.GA11468@sigill.intra.peff.net>
	<7vbp3bqmiy.fsf@alter.siamese.dyndns.org>
	<20110120215456.GB11468@sigill.intra.peff.net>
	<AANLkTikBbSt5_WdbuE8a96w1pWBCYLNjMCUCBThjdLdG@mail.gmail.com>
	<7vk4hyp38i.fsf@alter.siamese.dyndns.org>
	<AANLkTikmbWkpjioARZrmySpLM8t7kqCX0v1+NKibk_ar@mail.gmail.com>
	<AANLkTinRcmevXz3zV0wtxd7+Q3F4zcH2AZOQk1XVxYXa@mail.gmail.com>
	<BANLkTim1gW_L-9DKo9p_VFQFUBUGWAPxoA@mail.gmail.com>
	<BANLkTinKDHM-RU2wqZECFcjQEoRWADnTGQ@mail.gmail.com>
	<BANLkTimFas5YLt37RLuCppkQ4ZGhmj56Cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 11:49:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF1Mo-00010I-94
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 11:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756145Ab1D0Js7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 05:48:59 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41058 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755991Ab1D0Js6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 05:48:58 -0400
Received: by fxm17 with SMTP id 17so1005082fxm.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 02:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=g+l2yb56D/QqO75p/ZAc5iDaWVKfSDEst9e4YPF7M3k=;
        b=kxY4A6oX5KpZIJSqvPUquCMcTn8MA7SaFWaiJz/PFk984KrTtGZNidZdw56AUGxnsu
         Zp/GB5Gl3M4b9fZGBjWNIJ3pc6oM1WQTBYMQAJ77BiTMCNF3UyXBc2ok8SIZ1DNxwCxN
         CtCNjl20Ks0I/9z83yQ4Bd4RlbTzJLesgO+Zg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=dS9MAkZX6m7Wp7XzPh79bcF3DyYBIIkujWgbnr/79TLPz8UaexNz+P4WLzZshWc3LT
         +NNmCzZQUMJCXlvEaSAGZ4QU4IxamTz6M1iCvE5okdW1yLWLf8L6DjlcyPDnxW3GiC1P
         dImhIJ5dX1vYQLLxs7DBkciOjAQVXb8486u40=
Received: by 10.223.87.16 with SMTP id u16mr2125276fal.13.1303897736721; Wed,
 27 Apr 2011 02:48:56 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Wed, 27 Apr 2011 02:48:56 -0700 (PDT)
In-Reply-To: <BANLkTimFas5YLt37RLuCppkQ4ZGhmj56Cg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172208>

On Wed, Apr 27, 2011 at 12:18 PM, Stephen Kelly <steveire@gmail.com> wrote:
> On Tue, Apr 26, 2011 at 8:18 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Tue, Apr 26, 2011 at 3:09 PM, Stephen Kelly <steveire@gmail.com> wrote:
>>> Can git have a bug tracker please?
>>
>> So that you would feel comfortable that there would be a bug report
>> gathering dust? Or that it's closed as invalid for lack of
>> information?
>
> If you believe that it is a foregone conclusion that that is the fate
> of all bug trackers, and that that's a reasonable reason for git not
> to have one, then you have had very different experiences to me.
>
> I don't think there's more I can say than that.
>
>>
>>> This is another reminder to fix this bug which is otherwise untrackable.
>>
>> Let's imagine you are posting this to bugzilla: first question?
>> How do you reproduce this?
>
> My initial mail illustrated the problem as best I could:
>
> http://thread.gmane.org/gmane.comp.kde.devel.pim/29534

No problems here:

Initialized empty Git repository in /tmp/remote/
Cloning into alice...
done.
warning: You appear to have cloned an empty repository.
[master (root-commit) 6983153] w
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 file
Counting objects: 3, done.
Writing objects: 100% (3/3), 213 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
To /tmp/remote/
 * [new branch]      master -> master
[master 116a225] w
 1 files changed, 1 insertions(+), 0 deletions(-)
Counting objects: 5, done.
Writing objects: 100% (3/3), 242 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
To /tmp/remote/
 * [new branch]      HEAD -> HEAD
Everything up-to-date
Cloning into bob...
done.
From /tmp/remote
   6983153..116a225  HEAD       -> origin/HEAD
Current branch master is up to date.
[master 0951422] w
 1 files changed, 1 insertions(+), 0 deletions(-)
Counting objects: 5, done.
Writing objects: 100% (3/3), 242 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
To /tmp/remote
   6983153..0951422  HEAD -> master
From /tmp/remote
 + 0951422...116a225 HEAD       -> origin/HEAD  (forced update)
Already up-to-date.
From /tmp/remote
 + 116a225...0951422 master     -> origin/master  (forced update)
Already up-to-date.
From /tmp/remote
 + 0951422...116a225 HEAD       -> origin/HEAD  (forced update)
Already up-to-date.

>> But I already asked you this[1], and you didn't reply. What should one
>> assume but that you don't care enough to help get this fixed.
>>
>> [1] http://article.gmane.org/gmane.comp.version-control.git/165320
>
> Someone else replied. Isn't that enough?

With a different issue that's not really important.

> Other git developers confirmed it's probably an issue. Isn't that enough?
>
> http://thread.gmane.org/gmane.comp.kde.devel.pim/29534/focus=165326

_probably_, many things have happened since then.

Is it still an issue? Doesn't seem so.

-- 
Felipe Contreras
