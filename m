From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: Call Me Gitless
Date: Mon, 18 Aug 2008 16:24:35 -0700
Message-ID: <905315640808181624w58918a0ao939a3f0462f9dc9e@mail.gmail.com>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
	 <alpine.LNX.1.00.0808181512160.19665@iabervon.org>
	 <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Daniel Barkalow" <barkalow@iabervon.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 01:25:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVE6X-00077l-M3
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 01:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753114AbYHRXYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 19:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752643AbYHRXYi
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 19:24:38 -0400
Received: from ik-out-1112.google.com ([66.249.90.177]:61112 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580AbYHRXYh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 19:24:37 -0400
Received: by ik-out-1112.google.com with SMTP id c28so2478853ika.5
        for <git@vger.kernel.org>; Mon, 18 Aug 2008 16:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=MRL3aI/XxLL2CebyVsEesYvNZFyLLXV8+SBtQjoxdwo=;
        b=WHO/IYXfKyBPTTF1Nn5lsPDpViHmBlCv+kzLYLY+50doE42fpiQLfVtqZ+yTfxWUif
         YWmR/N8p2LrEFaEh9vJwfMe8f4c8FNUrfWgzAx7rXdgWJzaB2py+7xvMv1EVqfasXs6/
         wR0hAMnXWGddy8a10WniXw7NxmXK3C4TTfSYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=a7NNqF3CxyGjdK6ERPPSLpmfqzdtB5oY90N6K38B7vRDtqK2r0zVFXbQIPBYh/Bky9
         L5zX47ehdQLgILRWMOYrC2rZJYsZ0za/eV4cphvXZug5IMdba/0oVA+cNfZbaNzBX6a2
         uBQ7NYKlGuZD5gTyr35y3b92LUK0PrvlOPoM4=
Received: by 10.210.87.19 with SMTP id k19mr8777702ebb.176.1219101875655;
        Mon, 18 Aug 2008 16:24:35 -0700 (PDT)
Received: by 10.210.28.18 with HTTP; Mon, 18 Aug 2008 16:24:35 -0700 (PDT)
In-Reply-To: <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: e6992efaa9c61e31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92760>

On Mon, Aug 18, 2008 at 1:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> (2) Some concepts in git are different from what they are used to, without
>    any good reason.  IOW, the concepts have room for improvement, and our
>    UI is based on these faulty concepts.
>
> (3) Some concepts in git may be exactly the same with other systems, yet
>    our UI may operate differently from them without any good reason.

One confusing part of the porcelain may be the way that git's revert
is different from other systems' revert.  What would people think
about something like this somewhere in git-revert(1)?

+DISCUSSION
+----------
+If you are more familiar with another SCM, 'git revert' may not do what you
+expect.  Specifically, if you want to throw away all changes in your working
+directory, you should read the man page for 'git reset', particulary the
+'--hard' option.  If you want to extract specific files as they were in a
+previous commit, you should read the man page for 'git checkout -- <filename>'.
+

asciidoc probably won't like that as is, but if people like the idea,
I can make up a real patch.

Thanks,
Tarmigan
