From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: Why does git-commit --template want the template to be modified ?
Date: Tue, 30 Oct 2012 11:09:25 +0000
Message-ID: <1351595365-ner-1835@calvin>
References: <CAC9WiBjeuy8dpSnp5Jq55hs1-CJUzwpH70GZ1ZGOF2dAAeypaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: Francis Moreau <francis.moro@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 12:11:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT9j8-0007G6-Jb
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 12:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167Ab2J3LLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 07:11:08 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:46299 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070Ab2J3LLH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 07:11:07 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so79392eek.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 04:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:references:in-reply-to:mime-version:date:message-id
         :content-type;
        bh=IANOmGGmERr+iI2RHw6077VwnqwASXzbQY7F20YsTrw=;
        b=M1ro8FyCsgzQ6bpxXPps5CTv2J2/szKjNMyDjcuMIqBnD9Z8F7wl2YNTNpmBbVm8Iw
         xeQGCAqHhc4Y8EZEy5goyXUPGea/23a0bs73gj3awHVdiL2KNMjEc7r7sBlv1Cc0vd9n
         X3pyEGPr4w73ky+zIaHYTkoRCZ+cQ9pAH1Z0vGz6sxa/FO3NHE1VmdU8Lhnu6gv+SkZd
         A5WYxnlbjviq90sjVM2/Ufsbur7Pz8fJ8M/K2ULBpfxNeG84MKMi1nNaec2pSQmU9DFI
         sCGeSNgBr4k2N3jQD/PFiojb8JW17xqsT5kMOa9c3f8bReYluZcWq3c8XRa4xjhMKL9U
         JvTw==
Received: by 10.14.194.2 with SMTP id l2mr72740446een.12.1351595465501;
        Tue, 30 Oct 2012 04:11:05 -0700 (PDT)
Received: from calvin.caurea.org (pub082136067238.dh-hfc.datazug.ch. [82.136.67.238])
        by mx.google.com with ESMTPS id g47sm878911eeo.6.2012.10.30.04.11.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 30 Oct 2012 04:11:05 -0700 (PDT)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id 6A725130405; Tue, 30 Oct 2012 11:09:25 +0000 (UTC)
In-Reply-To: <CAC9WiBjeuy8dpSnp5Jq55hs1-CJUzwpH70GZ1ZGOF2dAAeypaw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208696>

On Tue, 30 Oct 2012 11:53:08 +0100, Francis Moreau <francis.moro@gmail.com> wrote:
> Hi,
> 
> I'm using git-commit with the --template option. The template I'm
> given is self sufficient for my purpose but as stated in the
> documentation, git-commit wants the template to be edited otherwise it
> aborts the operation.
> 
> Is it possible to change this ?

It seems you want -F instead of --template.
