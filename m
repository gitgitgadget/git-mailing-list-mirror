From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: checkout vs reset
Date: Thu, 26 Feb 2009 02:12:27 -0500
Message-ID: <76718490902252312h6a08f5a6x972523e7c7e4af16@mail.gmail.com>
References: <76718490902252308r474b193yba21b14e14a3baa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 26 08:13:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcaRQ-0002VJ-Jd
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 08:13:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbZBZHMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 02:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbZBZHM3
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 02:12:29 -0500
Received: from rv-out-0506.google.com ([209.85.198.232]:3633 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbZBZHM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 02:12:29 -0500
Received: by rv-out-0506.google.com with SMTP id g37so409781rvb.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 23:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=7kEME4fKWNTCwXjlAhMBCPnrIe5mARyumpSVe3jNRFY=;
        b=fs07lN6IMpcvs6i0ziIihtdSr968OxOdCfkmL+PysM4BEPV4jy3h3qSd39JZybfXD6
         o1bXt5FzCdv/3/G31x0WXYWuBUQvJDuSPB1MJse2koYwXwiEGlIZau+jY3rAmKCtyy5/
         KZ7dUfYvB+pY/J3QSAjL/4QrDwEKPCKNNIYZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=H78JbWN16O8rz0gEkvK2F5oCjTO1ckDXguTaqRBZQxnawxSRwysY2qyhTcgaJebLYT
         1TDX9q8bLTBX6vNhnw6pkMkOU0+EK9eXJ76L4GgZ8M5dO55thkQ7je2ooslagaQcwNsv
         P5Kpbo4S8qZ8yQfsQD0dyLMvfCFbdiAJ5rrDU=
Received: by 10.140.163.12 with SMTP id l12mr488653rve.41.1235632347131; Wed, 
	25 Feb 2009 23:12:27 -0800 (PST)
In-Reply-To: <76718490902252308r474b193yba21b14e14a3baa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111535>

On Thu, Feb 26, 2009 at 2:08 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
> Is there any different between the following two commands?
>
> git reset <commit> -- <paths>...
> git checkout <commit> -- <paths>...
>
> As far as I can tell from the man pages, they are equivalent. To wit:
> both update the index and working copy for the given paths to the
> state that they were in in <commit>.

Doh, answering my own question. reset only touches the index, not the
working copy. checkout updates both.

j.
