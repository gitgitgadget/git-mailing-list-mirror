From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Transparently encrypt repository contents with GPG
Date: Thu, 12 Mar 2009 22:34:54 +0100
Message-ID: <fabb9a1e0903121434u4a3d71bdi6277071f54557a7e@mail.gmail.com>
References: <978bdee00903121419o61cd7a87rb55809796bd257d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthias Nothhaft <matthias.nothhaft@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 22:36:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhsZs-0007w8-4y
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 22:36:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754334AbZCLVe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 17:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754176AbZCLVe7
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 17:34:59 -0400
Received: from mu-out-0910.google.com ([209.85.134.185]:49300 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753644AbZCLVe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 17:34:58 -0400
Received: by mu-out-0910.google.com with SMTP id i10so762728mue.1
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 14:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Hn33ORImQZGsQ05CIKRhm+GlhtX7Ajy61f9z5D+0A5I=;
        b=VcEZFsYKv5RsaJrgme0AjW2ouWpcY+K+SGRt+DK33JhG7DFfE+Z5EVQssIhEasVLrr
         d8KPtrLJJR5hbe6zizCy0RRsgH1CMLhG3woohAUywTgDBdk7tXWZ740Qn0jh01KAuuU+
         chil1ULju6GpbfIuoBlqvj+eZGDty5gWakZ2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=X8E6ZXMJ2ZZbIPi5kqPC524Z+buvKa5ETcxtrpNmn4sxPaS6xxqFTCYOuP2yAepma1
         TJGvVaQyEhvxzKAXbqVYcv1Ldhem3wL+6H59KBF9kJi4/FrnTxf59SGpaH+JeBd35+wr
         2q0UhDz80GmEyVGL0PtlxXIqxju8eV6FV9cAw=
Received: by 10.103.24.11 with SMTP id b11mr224862muj.76.1236893694955; Thu, 
	12 Mar 2009 14:34:54 -0700 (PDT)
In-Reply-To: <978bdee00903121419o61cd7a87rb55809796bd257d7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113125>

Heya,

On Thu, Mar 12, 2009 at 22:19, Matthias Nothhaft
<matthias.nothhaft@googlemail.com> > What I need is a way to
automatically modify each file
>
> a) before it is written in the repository
> b) after it is read from the repository

Have a look at smudging, you might not need to touch the git source
code at all ;).

-- 
Cheers,

Sverre Rabbelier
