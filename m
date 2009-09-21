From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] Trivial fix: Display a more friendly message with 
	git-shell.
Date: Mon, 21 Sep 2009 17:45:50 -0300
Message-ID: <a4c8a6d00909211345q593e673bo4964204afa5ce807@mail.gmail.com>
References: <1253466672-21051-1-git-send-email-tfransosi@gmail.com>
	 <4AB71A76.5010509@viscovery.net> <vpqeiq0ssn7.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 21 22:51:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpprR-0000JE-1u
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 22:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017AbZIUUvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 16:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752630AbZIUUvj
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 16:51:39 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:33328 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610AbZIUUvi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 16:51:38 -0400
Received: by fxm18 with SMTP id 18so350163fxm.17
        for <git@vger.kernel.org>; Mon, 21 Sep 2009 13:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=rSheb8+bZGzPJnrmtoIge3Z9o3dZ+aZp7l+ic/9bFrk=;
        b=u8mEJho+hMoyAc8qVA8zC+sWI0o1nP4mVWKdLY8GJZF3cRgJBVSmbRIjfCSlm1R56P
         f+OoeXS2LkRu1otnOfMlcjlA10LAJIhqG/ElUBqw3ATG73JqCdPjgTeGqU/Bj8tJQbof
         MC019jWDUPb2v7ejkbD23tLQ1RRhZbNr+F77s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=lqW8fzObr8T8pc5zPiTri0rsS3sXMyUiOzMGhAVrBua9DHZZ10GNCCSc1OIAO07VNe
         lsN4EoAanqgyahRcSQbzeZLfGODPrRpLmZgNNvniAJHcHbLGJGFMBphig6rVj9iTg7yj
         lpzSIxe+JUwj58m8Q+HMNhFS3j7dRQov9iKwg=
Received: by 10.86.232.5 with SMTP id e5mr135687fgh.27.1253565950073; Mon, 21 
	Sep 2009 13:45:50 -0700 (PDT)
In-Reply-To: <vpqeiq0ssn7.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128911>

Hi Matthieu
On Mon, Sep 21, 2009 at 3:45 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Perhaps one more line saying what 'man git-shell' says in addition
> would help:
>
> $ git-shell
> git-shell: Restricted login shell for GIT-only SSH access
> Usage: ...
I added this line to the output usage, but would be good to show the
commands that git-shell accept too?
