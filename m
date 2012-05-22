From: Alexey Pelykh <alexey.pelykh@gmail.com>
Subject: Question about submodules and absolute paths
Date: Tue, 22 May 2012 14:36:45 +0300
Message-ID: <CAOmKuSpqFrC7G4DbZu=uYDwvU6QqrJUi2aNBnSjy7_PXMMJpjQ@mail.gmail.com>
References: <CAOmKuSoYP9fYORDy5twLpFh7SQ7rc6x2A=F8XjfKMqo-ErCauQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 22 13:36:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWnOV-0007ZR-3X
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 13:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758515Ab2EVLgq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 May 2012 07:36:46 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:43640 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758486Ab2EVLgq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 May 2012 07:36:46 -0400
Received: by obbtb18 with SMTP id tb18so9494139obb.19
        for <git@vger.kernel.org>; Tue, 22 May 2012 04:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=JNxRHUhlQ9X8mo1plNZFrKPv2zQH+qK2wewYpEDyBIQ=;
        b=I6pHXmyQTpBMyYVU1MY7mM9P+iytV+MAerXa0h9n7YGSt3GgTEgEewT8BeITTJWcjh
         BxvoRX32f6BQPebt0r33LLyLvw6J3/srvniWyLqEvtQYyLWTmR6vsrJYyt2qyiWTe+AX
         JBVLEQI5RZ8LsB8t5TiyMV8IlQbuXHlLkqDS4kHlMX4SgirfssZ/KCY1BtPibwWY4KMW
         eXhVV6k8BMwJ+vgaPz+F/nQxmW1iHYzbWF5syRw+YTBN/c75s/7QpJ20CNOBFMsVUM/B
         pAGcEssLUTJwbv4I/lQmqxUUWlkU+JsmaAb/d3udUD+ZXv95FGvKlywsa5DgTFx8dpsX
         Lq3Q==
Received: by 10.182.45.72 with SMTP id k8mr189956obm.51.1337686605512; Tue, 22
 May 2012 04:36:45 -0700 (PDT)
Received: by 10.182.72.65 with HTTP; Tue, 22 May 2012 04:36:45 -0700 (PDT)
In-Reply-To: <CAOmKuSoYP9fYORDy5twLpFh7SQ7rc6x2A=F8XjfKMqo-ErCauQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198193>

Hello,

Is it possible to avoid usage of absolute paths in information about
submodule? I'm working with same local repository from both Windows and
Linux. But unfortunately absolute paths in modules break all the sweetn=
ess,
since these paths differ from OS to OS and thus I have to keep two clon=
es of
each repository.
Regarding absolute paths I refer to are:

In ${REPO}/.git/modules/${MODULE_RELATIVE_PATH}/config file:
[core]
=A0 =A0worktree =3D=A0 ${FULL_REPO_PATH}/${MODULE_RELATIVE_PATH}

In ${REPO}/${MODULE_RELATIVE_PATH}/.git file:
gitdir: ${FULL_REPO_PATH}/.git/modules/${MODULE_RELATIVE_PATH}

Thanks,
Alexey
