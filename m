From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clean weird documentation for 'git var' and 'git
Date: Thu, 10 May 2012 11:41:43 -0700
Message-ID: <7vvck3najc.fsf@alter.siamese.dyndns.org>
References: <CAGK7Mr7QWrddaRLkr=1h=GYUNtNVOatQF1sj+p11mejzs65u8A@mail.gmail.com>
 <7vzk9gm0wa.fsf@alter.siamese.dyndns.org>
 <F89882854A7D45E2843F6F1F7CB21DB4@PhilipOakley>
 <CAGK7Mr6AjSY-D9p1vzs=xCg-TMCPiBJDOSxMVYtykeCZCPW2FA@mail.gmail.com>
 <CAGK7Mr7rzuPVmGsnx+uhmVgBepAav734uh6hHeqn25BC0_+0Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 20:41:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSYJE-0005io-OC
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 20:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761345Ab2EJSlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 14:41:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64572 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761245Ab2EJSlq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 14:41:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E65CF88EC;
	Thu, 10 May 2012 14:41:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Wo/S1rxc0XqGP0tcEGCtFV29k94=; b=tc5P3e
	SvdW7k1eACfopJ7B6HPbOd8/UFJcZ6mH3Dd8Mz3QnF/LRj+xd+K6EPTLq6jieUkm
	MsMj/1s5CzVoofqBmSf12ha8QP+MekkL7lmbO+RKhZ6uXrHwo+iH/lUDY134bBtO
	0NxR6TMbsjiMgH4avQauTLwCLqRnao5Jb9kxI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vuJu82I9pTjQrppqDyd7Rq4LMGsYXGE3
	Ph9YVhkofk6kG3yHCvLGui4QgD0Q4NKGqgUt0xPm9aZbZnEqItkMdBxNzbMKhWtS
	1b3jfzjYPraQ2yXK/IPeeXQKac/SJ7C6gNjMF6DrJqMuyHW+pizrpQVhhjYjs231
	S/tvdriQN3A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDA4188EB;
	Thu, 10 May 2012 14:41:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 719F988EA; Thu, 10 May 2012
 14:41:45 -0400 (EDT)
In-Reply-To: <CAGK7Mr7rzuPVmGsnx+uhmVgBepAav734uh6hHeqn25BC0_+0Lw@mail.gmail.com>
 (Philippe Vaucher's message of "Thu, 10 May 2012 20:26:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CB226334-9ACF-11E1-B2B6-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197613>

Philippe Vaucher <philippe.vaucher@gmail.com> writes:

>>> What's weird about them? They are real messages issued exactly when they are described to be issued.
>>
>> The problem is surely that an explanatory line is needed to say that these are the diagnostic messages that occur in various cases. Its in 'ident.c'.
>
> I guess I'm just unfamiliar with the "Diagnostics" section of a man
> page.

Ahh, that makes your initial message understandable.

It indeed is not one of the very common and established ones, and it may
help to give it a gentler introduction.

 Documentation/git-commit-tree.txt | 4 ++++
 Documentation/git-var.txt         | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index cfb9906..868ad09 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -90,6 +90,10 @@ include::date-formats.txt[]
 
 Diagnostics
 -----------
+
+Some of the common error message the command may give upon errors are
+listed here.
+
 You don't exist. Go away!::
     The passwd(5) gecos field couldn't be read
 Your parents must have hated you!::
diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index 988a323..394bfa7 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -61,6 +61,10 @@ endif::git-default-pager[]
 
 Diagnostics
 -----------
+
+Some of the common error message the command may give upon errors are
+listed here.
+
 You don't exist. Go away!::
     The passwd(5) gecos field couldn't be read
 Your parents must have hated you!::
