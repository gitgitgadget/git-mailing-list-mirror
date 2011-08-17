From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Branches & directories
Date: Wed, 17 Aug 2011 11:35:55 -0700
Message-ID: <CAE1pOi3Eg88i+1s+CcW3+W0WNZ-NYUQb1EV55oh+g1Od78AByQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 17 20:36:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtkyJ-00005V-OV
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 20:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846Ab1HQSf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 14:35:58 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42131 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613Ab1HQSf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 14:35:56 -0400
Received: by ywf7 with SMTP id 7so966608ywf.19
        for <git@vger.kernel.org>; Wed, 17 Aug 2011 11:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=/11uCVoWTK09LhCt/wnJxoKPYNyu+iYDaC9AZYOqyTg=;
        b=LwKd3kVkE5MXfzvf7kK6cK3QnHSM2yduRwciKNb1zTUc8uLCqt6KSZeuOsExNj1rIo
         olhQvqXjdm/IwczpS+dLobVntwbi86nRBhXm4Z53cUx2rDgUN/Sc9AE4WkZ7xPMaGe5B
         9KXFwqst77qHILnaDbWd940wbPGAwiK1CUFbw=
Received: by 10.236.9.41 with SMTP id 29mr4210068yhs.212.1313606155452; Wed,
 17 Aug 2011 11:35:55 -0700 (PDT)
Received: by 10.236.207.67 with HTTP; Wed, 17 Aug 2011 11:35:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179523>

Hi all,

I have been noticing strange behaviour that I would like to be able to
explain or report as a bug as the case may be.

What happens is that I create and commit a new directory in branch
'next' and then when I checkout 'master' this new directory is still
there. I think this is wrong as this new directory does not exist yet
in 'master'. Is my understanding correct?

I tried recreating this scenario in a clean Git repo with a simple
mkdir and commit but when I did a checkout of 'master' the new
directory was removed. So the basic scenario seems to work the way I
expect it to.

Assuming I ran into a bug, I would like some suggestions to properly
investigate this. Clearly, I'm doing something else that triggers the
behaviour I'm seeing but I'm not sure what it is. What might trigger
Git "remembering" a directory? Or what would prevent it from removing
a directory when checking out a different branch?

Extra information: "git status" (in 'master') yields nothing. But
after adding a new file in the directory-that-should-not-be-there, Git
treats the entire directory as untracked and new (as one would
expect). I can also safely remove the directory with no (obvious) ill
effects.

Cheers,
Hilco
