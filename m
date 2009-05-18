From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Git screwup with reset
Date: Mon, 18 May 2009 17:11:38 +0200
Message-ID: <fabb9a1e0905180811r6e408ce5ged65ddfb3846111c@mail.gmail.com>
References: <9D569322-6A7B-4447-962C-0C740945E227@orgsync.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: jake varghese <jake@orgsync.com>
X-From: git-owner@vger.kernel.org Mon May 18 17:12:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M64Vr-0005rJ-El
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 17:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306AbZERPMA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 May 2009 11:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753226AbZERPL7
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 11:11:59 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:38260 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998AbZERPL6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 May 2009 11:11:58 -0400
Received: by bwz22 with SMTP id 22so3267791bwz.37
        for <git@vger.kernel.org>; Mon, 18 May 2009 08:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=aLbhUrO8oSl8BTTfblo4nSVX/8RyMkMmszpDkC3+kx8=;
        b=VM2zEVUiAjNlFHpbdT0hBfUM5VB2gPsDP5mdPXGKJbR3bGPPDwzzMJ0VCjzwSV5qTU
         W5tTR5CG5huMhVPofTzeur+mG8PyDBccelesN6jAotx+KCx18sqsskJizvYRUhY4UVrH
         2Mrp9IUE3B0OBhLXBZcJIuKRXI/cmUTZSc2z0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=n1zQH9nn7C79SQ/zb7l9bdnSaraGzgmuBuVmAJMtTUMgz4Fd8qF7bec7It7w6JUjs0
         xYR/oDWqm77YAhuxMqNJODDdazqbdzJemW+f3ck7EZLbNDR4F/6y9UTjzg/2za2jk27H
         SHVfWZm5eZJ4qh4fq2J8nYQqR7Dw36FZxpono=
Received: by 10.103.228.19 with SMTP id f19mr4148190mur.32.1242659518098; Mon, 
	18 May 2009 08:11:58 -0700 (PDT)
In-Reply-To: <9D569322-6A7B-4447-962C-0C740945E227@orgsync.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119448>

Heya,

On Mon, May 18, 2009 at 16:58, jake varghese <jake@orgsync.com> wrote:
> =A0Anyone know of a way to get this stuff back.

Make a backup copy of that .git directory, so that whatever you do you
won't lose that work ;). Also, the reason you can't merge or rebase
that hash is because it's the hash of a tree or a blob, not a commit.
You can use git commit-tree [0] to create a commit from your lost
tree, but that works only if you have a tree (for just a blob you can
use git cat-file [1])

[0] http://www.kernel.org/pub/software/scm/git/docs/git-commit-tree.htm=
l
[1] http://kernel.org/pub/software/scm/git/docs/git-cat-file.html

--=20
Cheers,

Sverre Rabbelier
