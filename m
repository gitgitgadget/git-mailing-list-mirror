From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: current repository hash
Date: Mon, 16 Jun 2008 14:15:14 +0200
Message-ID: <8aa486160806160515p751b2af4j2b0db6db7a9ad482@mail.gmail.com>
References: <556d90580806160451g36daefb6o48b93b92589211bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alf Clement" <alf.clement@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 14:16:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8DdP-0003CX-4o
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 14:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115AbYFPMPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 08:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753167AbYFPMPg
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 08:15:36 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:7522 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076AbYFPMPf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 08:15:35 -0400
Received: by yw-out-2324.google.com with SMTP id 9so3071976ywe.1
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 05:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=vG/RbxzBXUE5XN24QSR28qMjpMDt96czAvev6gFVI+s=;
        b=BlVG5Kip6sN6YZ7RowBHXYlxEGPacsH2Z3zCUZmFhlfXSqNsyTiv6SHkFgVq1QCJaH
         3hL5p0kmOcpcvID44iTaVK+6ucdjI7hedTL/OEtNDWriBa0VvqJwiKWYAscoeQUSScIl
         6dhmKMGsbO4XJP/Ccx0b8OdCFF4HLMZbTugco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ExkUsJhTwnApwZvyp5aOIzLoaRFGjzCxVsoOMq2oB5FCpgPchPooEe8n8pTIEJ7j7N
         grRU6jqOzFGkGo7+XMrK8mfakLPzPPRQGsN6/tXLNXyvZxES4VbibiRewWk69t5ebEl3
         GNErrI6C4JhgglgtKiaK7RPFUsr77u+A5LY6A=
Received: by 10.150.177.20 with SMTP id z20mr10667817ybe.214.1213618514920;
        Mon, 16 Jun 2008 05:15:14 -0700 (PDT)
Received: by 10.150.152.19 with HTTP; Mon, 16 Jun 2008 05:15:14 -0700 (PDT)
In-Reply-To: <556d90580806160451g36daefb6o48b93b92589211bf@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85184>

On Mon, Jun 16, 2008 at 13:51, Alf Clement <alf.clement@gmail.com> wrote:
> Hi all,
>
> I want to compile the current repository hash id into my program, to
> be able to checkout later this
> id an see the exact files for the compile. It should flag if there are
> currently modified files in the
> directory tree.

You can look at how git does it:

http://git.kernel.org/?p=git/git.git;a=blob;f=GIT-VERSION-GEN;hb=HEAD

>
> What would be the best command to get a unique identifier?

"git rev-parse HEAD" for a unique identifier,
but "git describe" is more convenient/useful.

> Do I need the 40 digit hash id?

Normally 7 or 8 are sufficient.

> How can I make sure that a shorter hash id will be unique?

You can't. Even the 40 digit hash is "only" cryptographically unique.
But within a project 7 or 8 digits are unique enough for practical
use.

Santi
