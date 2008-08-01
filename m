From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Filtering mode changes
Date: Fri, 1 Aug 2008 14:32:03 +0200
Message-ID: <8aa486160808010532k3932979er1a457b0d627e988@mail.gmail.com>
References: <loom.20080801T111754-982@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Stefan Naewe" <stefan.naewe+git@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 14:33:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOtoi-0006MO-CR
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 14:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbYHAMcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 08:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752876AbYHAMcG
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 08:32:06 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:6900 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbYHAMcE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 08:32:04 -0400
Received: by yw-out-2324.google.com with SMTP id 9so596060ywe.1
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 05:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=4J/Mz7JsBq5+pj3V6S5RZ5A3jZrT/s911ZFVoJfczIE=;
        b=XWOTjizvriWrHVHebRAxV4+8BTfXZF2HFQIIubx7TkTwEc8ubhXsGsGj+HuCzeshVk
         yyUpQHy6FU5PHRMGR6QU7S3fQ7hpYYsKEFl73FiMp59uTTz2usvoDQ9lFlNUEpEIb4Lz
         Ydxdbhsy3eGufx3yVaAu3+BE9BaxaLfloH6EA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=dUgdWcLpskkYV1DLPTdDQfkqrBEXbCLtKxhi8l8E4QBUM0SzFpUqqAtDO/uoHc7PTe
         8qPpxigagrtCUeRmQM4jvVarKSRt9N9/J/OcWL/gLkYJitNyZjI7KQP7phVPz2puqler
         1pO5MtAOCPhsT0EwVsUQ0/+UDAZGbbmW3F1NM=
Received: by 10.150.206.1 with SMTP id d1mr3165281ybg.144.1217593923152;
        Fri, 01 Aug 2008 05:32:03 -0700 (PDT)
Received: by 10.150.95.21 with HTTP; Fri, 1 Aug 2008 05:32:03 -0700 (PDT)
In-Reply-To: <loom.20080801T111754-982@post.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91064>

On Fri, Aug 1, 2008 at 13:25, Stefan Naewe <stefan.naewe+git@gmail.com> wrote:
> Hi there.
>
> Here's my story:
>
> - I did some minor modifications to a repo that I want to 'give back'.
> - I worked on my own branch (of course).
> - I was stupid to edit the files (that live on a linux box) through a windows
>  network share.

Then, you should set core.fileMode to false.

> - When I created diffs (using 'git format-patch') to send send 'upstream', I
>  noticed that the edited files got their executable bit set (old mode 100644 ->
>  new mode 100755)

You can just edit the patches and remove the "old/new mode" lines.

> - I created another commit to undo the mode changes.

You can use "git rebase -i" and edit (or squash) the revision before
generating the patch.

Santi
