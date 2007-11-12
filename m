From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH,RFC 1/2] Make the list of common commands more exclusive
Date: Mon, 12 Nov 2007 13:48:33 +0800
Message-ID: <46dff0320711112148u59d01ff4v4fea7168c9822799@mail.gmail.com>
References: <20071111235819.GB7392@thunk.org>
	 <1194829077-14320-1-git-send-email-tytso@mit.edu>
	 <7vzlxk8apz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Theodore Ts'o" <tytso@mit.edu>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 06:48:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrSAI-0000G9-Id
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 06:48:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbXKLFsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 00:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbXKLFsf
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 00:48:35 -0500
Received: from py-out-1112.google.com ([64.233.166.177]:23371 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbXKLFse (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 00:48:34 -0500
Received: by py-out-1112.google.com with SMTP id u77so1012254pyb
        for <git@vger.kernel.org>; Sun, 11 Nov 2007 21:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=FpOOGeLO6D0cVQ/4etQ1FMdeGGtyLME2IgypQRFehIo=;
        b=iPNxESAfGSNkSHrJKpW7UgmiWTh83mJqi8A2D0bJZMcQAGHc5FRZ79OccbKBoRhcDP4vgZbp4pkQvFmpSlRM97M66X2+2jQK1bv+5FIVkCu3blxankvS2pLC8TGqmnqwfvJZ+dUAa0M6vVDKcXtqfvCdltPyZeIUgrz5gYMGQaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AO4OAl/wQGlmZiozoV8M0y3jvhLd+aUdgPqLoDukAsnLjo8+R1gi7PY7tXWuhxnokGy0lVfpwT+k2nyfqrUMKJ6oFyZxXsck0OUASp7rkuA+1u0WsFntWMpty7Ajo466jnkOO+GXJkiZ2HgolU/f27dXb6QxQKa2pmpHIKe7+vQ=
Received: by 10.35.98.3 with SMTP id a3mr5674777pym.1194846513845;
        Sun, 11 Nov 2007 21:48:33 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Sun, 11 Nov 2007 21:48:33 -0800 (PST)
In-Reply-To: <7vzlxk8apz.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64562>

> I have a bit of reservation about revert, but I'd imagine we
> could kill it, and also fetch, pull and push, if you are
> shooting for *real* beginners who work alone.  I think the only
> valid justification to drop "revert" from the list is to assume
> that the audience do not interact with the outside world, and
> dropping fetch/pull/push from the list is in line with that.
many "real" beginners are users of CVS/svn, so the very first thing
they want to do is simulating the cvs/svn operation, so IMHO pull
(update) and push(commit) should be kept.
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Ping Yin
