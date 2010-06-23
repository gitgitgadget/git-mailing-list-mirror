From: Bruce Korb <bruce.korb@gmail.com>
Subject: Re: Newbie question: how can I list added files?
Date: Wed, 23 Jun 2010 10:50:11 -0700
Message-ID: <AANLkTikE2ylLXk5XxNGvcvol6R-puSTzPurdLcNMYaZJ@mail.gmail.com>
References: <AANLkTinxOE5xcP_V-PvoZGlfsxtcCafoYKy_PuBZnQnQ@mail.gmail.com> 
	<7vzkylejbf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 23 19:50:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORU5v-0005yq-AC
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 19:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112Ab0FWRue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 13:50:34 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55982 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345Ab0FWRud (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 13:50:33 -0400
Received: by gxk28 with SMTP id 28so288004gxk.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 10:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=tw4cQH4TfucCzPcA9qq+aorTtBnNeEKRV/kFlJ3AfIo=;
        b=TARsRQlRCiKGpGtwO7bLvcu4ZJ8EMxJsSQZ9PuMgMc19qV9VGFBz0m8j2i4dSx+8uK
         SI8SzWuXC68P1YqEK+zuT6Cyr8iqKeVj2w/EllgaNmJZV5cImr7E0e1XJ/KshODKIPre
         JQ3C4bCtTxMcr2rkuE2cHmQWhFn6Ebetawdbk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Cas4Qp1NxPe+WB40av5p/PuJO5R4mrabMs7NZERYLdvBbyQg+ZU8wtUQUOLUrq2VbG
         UJPC2YIDYNUzST6DNySiZ8Wix8dYeqeOD56RVQBkNQBx0sTMw37Dc1w/iucl313GI7BC
         SoF0mpKraqHyihzH37I6rcmw8uX/JFXRP4AEU=
Received: by 10.101.50.19 with SMTP id c19mr6650043ank.266.1277315431110; Wed, 
	23 Jun 2010 10:50:31 -0700 (PDT)
Received: by 10.101.107.13 with HTTP; Wed, 23 Jun 2010 10:50:11 -0700 (PDT)
In-Reply-To: <7vzkylejbf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149525>

On Wed, Jun 23, 2010 at 10:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "git diff --name-only --diff-filter=A HEAD"?

Thank you, but "Nope."
My added file doesn't show anything and not using the
"--diff-filter" thing shows both added and not added files:

$ git diff --name-only --diff-filter=A HEAD
$ git-status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   sw/embedded/platform/strad/scripts/mk_relsrc.sh
[...]
$ git diff --name-only HEAD
chip/chopin2/up/hdl/.sopc_builder/install.ptf
chip/mozart/up_oam/hdl/.sopc_builder/install.ptf
chip/mozart2/up/hdl/.sopc_builder/install.ptf
chip/mozart2/up_ft/hdl/.sopc_builder/install.ptf
sw/embedded/nios2/system/system.stf
sw/embedded/platform/strad/scripts/mk_relsrc.sh
sw/projects/nios2/modules/system/lib/system.stf
$
