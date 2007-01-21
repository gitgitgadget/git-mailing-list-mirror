From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Add new 'rebase' command.
Date: Sun, 21 Jan 2007 23:00:57 +0000
Message-ID: <b0943d9e0701211500v2f54aa61k2592ba060131318@mail.gmail.com>
References: <20070120180329.22621.30534.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 00:01:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8lgL-0002tv-Ci
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 00:01:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbXAUXA7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 18:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbXAUXA6
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 18:00:58 -0500
Received: from nz-out-0506.google.com ([64.233.162.238]:31520 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbXAUXA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 18:00:58 -0500
Received: by nz-out-0506.google.com with SMTP id s1so781120nze
        for <git@vger.kernel.org>; Sun, 21 Jan 2007 15:00:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KTx/lHyqyeI/doeBC7RO8CndAzFOQZaRoJasSzLiGzYUdPZB2Q2WhYInGyKsrQ1FJj3kPbTW4ZuKnTXlBgJADQ6MGSAnIEEAJJf0x8OrEKzNucVAB17m0maAIILYbDbbmt9NClFANORF2/FiLA10sOr4zn1QGcPNyzoBxMYwmd8=
Received: by 10.65.224.11 with SMTP id b11mr6377301qbr.1169420457483;
        Sun, 21 Jan 2007 15:00:57 -0800 (PST)
Received: by 10.65.133.13 with HTTP; Sun, 21 Jan 2007 15:00:57 -0800 (PST)
To: "Yann Dirson" <ydirson@altern.org>
In-Reply-To: <20070120180329.22621.30534.stgit@gandelf.nowhere.earth>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37358>

On 20/01/07, Yann Dirson <ydirson@altern.org> wrote:
> Take two: I had forgotten to add "rebase" to the list of stack
> commands for the purpose of help.

Thanks for the patch. I also added the command to the stgit-completion.bash.

I applied it but changed the patch a bit so that there is no need for
the --to option. I understood your point but I find it a bit strange
to have this mandatory option. Anyway, command line syntax doesn't
have to follow the natural language exactly :-).

Regards.

-- 
Catalin
