From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Deleting a submodule
Date: Fri, 13 Mar 2009 09:14:20 +0100
Message-ID: <81b0412b0903130114j289e7ae1j527e16cd84a892fe@mail.gmail.com>
References: <20BA928D-7133-40E7-AB01-466F509F002C@simplicidade.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailinglist <git@vger.kernel.org>
To: Pedro Melo <melo@simplicidade.org>
X-From: git-owner@vger.kernel.org Fri Mar 13 09:17:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li2a7-0001Se-Mn
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 09:17:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbZCMIO0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Mar 2009 04:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758375AbZCMIOZ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 04:14:25 -0400
Received: from mail-ew0-f177.google.com ([209.85.219.177]:37537 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758179AbZCMIOX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2009 04:14:23 -0400
Received: by ewy25 with SMTP id 25so2424910ewy.37
        for <git@vger.kernel.org>; Fri, 13 Mar 2009 01:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RUAMoffRURwWLubwJHX/Sg/uWeR3JpBCncKLorFEo2Q=;
        b=L0eBLnlqERhOmgF5r2uoAa36XaUZWKAS5lSyR3fIZ/s0yOi8x+VnVSlwmy9sU9V35O
         Hdz6y6SX8KDqiW3ieuSrQpC5H8w/xPPV5re4WURHas9IuZdfugNtx267PK7EjtRrBtGp
         nrKvHbWXTDGMXCmxNFFAZB3K93pt9OJaLMFv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dyhcbvDjIMYaQaS09RiEI6cgZ3R/CqBFrevw/soFOlC6eaZnjHdCKfDw1JipScAJuQ
         AtLXg3vvVY6XKUF3EabuU8pzvEnJ6eMYYlvkPWinzrjZn4/JzBeZ4xxEeuFImWdNiQf1
         6tfZ7kMH8q2mcguu8Bwl35WI50VvsmI3k03YI=
Received: by 10.210.89.4 with SMTP id m4mr720594ebb.82.1236932060643; Fri, 13 
	Mar 2009 01:14:20 -0700 (PDT)
In-Reply-To: <20BA928D-7133-40E7-AB01-466F509F002C@simplicidade.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113155>

2009/3/12 Pedro Melo <melo@simplicidade.org>:
> I couldn't find a git-submodule command to delete a submodule. What i=
s the
> correct procedure?
>
> I did:
>
> =C2=A0* removed the entry from .gitmodules;
> =C2=A0* run git submodule sync
>
> But its still recorded somewhere.

git rm --cached path/to/submodule
git commit -m'Submodule path/to/submodule removed'
