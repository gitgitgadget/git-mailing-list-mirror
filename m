From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: Incorrect default for git stash?
Date: Wed, 18 Jun 2008 08:12:21 +0900
Message-ID: <200806172312.m5HNCpWN002685@mi0.bluebottle.com>
References: <loom.20080617T224138-913@post.gmane.org> <loom.20080617T220852-922@post.gmane.org> <7v1w2v66ce.fsf@gitster.siamese.dyndns.org> <loom.20080617T224138-913@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 01:14:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8kNG-0006xl-Ah
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 01:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760714AbYFQXMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 19:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760495AbYFQXMx
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 19:12:53 -0400
Received: from mi0.bluebottle.com ([206.188.25.15]:39464 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760172AbYFQXMw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 19:12:52 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m5HNCpWN002685
	for <git@vger.kernel.org>; Tue, 17 Jun 2008 16:12:51 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:date:to:cc:subject:in-reply-to:references:
	mime-version:content-type:content-transfer-encoding:x-trusted-delivery;
	b=o9CGbmO3NEk3aoq3lI1DATd3/Noo2sfndtiQkr04X9TswREkeDQmBt8YY7shrlddX
	1Uryys2vWjswkLdh8ubBzIjOPTBAQevMPburWfHHPTxw0vyMiZ5sc5BIZxbMJPM
Received: from nanako3.mail.bluebottle.com ([212.62.97.21])
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m5HNChVi010324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 17 Jun 2008 16:12:48 -0700
In-Reply-To: <loom.20080617T224138-913@post.gmane.org>
X-Trusted-Delivery: <89c5add72e343f07820ac8227390f05d>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85341>

Quoting Eric Raible <raible@gmail.com>:

> Junio C Hamano <gitster <at> pobox.com> writes:
>  
>> Read the whole thread:
>> 
>> http://thread.gmane.org/gmane.comp.version-control.git/63566/focus=63784
>
> I'm glad to know that that was already hashed out, even if it
> didn't end up the way I would have decided.

Then I suspect you did not read the whole thread, as we have not "ended up"
in anywhere yet.

In particular, in

  http://thread.gmane.org/gmane.comp.version-control.git/63566/focus=63781

Junio maps out the next steps for people, who would want the behavior of
the command changed, to take.  None of these follow-up steps have been
taken by people who wanted to change the behavior of the command.

I can well imagine an alternative to make the command "list" by default
when stash.defaultsave is set to false, and actually suggested it earlier
with a patch, but I think the list consensus was negative.

  http://thread.gmane.org/gmane.comp.version-control.git/68539/focus=69045

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Get a free email address with REAL anti-spam protection.
http://www.bluebottle.com/tag/1
