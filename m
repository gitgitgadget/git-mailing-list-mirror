From: Kumar Pande <pandekumar023@gmail.com>
Subject: How to setup git repository for internal collaboration, that can be
 rebased easily?
Date: Mon, 26 Mar 2012 12:08:33 -0700
Message-ID: <CANz+fEmN2qm9Nwk4tyg0eCrKPR6WZg4kvqCkhB7TmYw2JKoJJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 26 21:08:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCFHU-0005SL-SX
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 21:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216Ab2CZTIg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Mar 2012 15:08:36 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:47206 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062Ab2CZTIf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Mar 2012 15:08:35 -0400
Received: by lbbgm6 with SMTP id gm6so4232747lbb.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 12:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=6/xW77ALGE7pRhcem0aCwNjToQjDmzTVEEDQHGJ00X0=;
        b=xDif+qY6fW6hIe/8RWK+7ddAJwjisr2HbX9CRKIK3Gg0MxzZMhtiujF7fluQN4qDuo
         pH5DRq/Pu1j3TY6BQzdJCnr2m80Qq4+Ej2Xh3fKZ0P6wz6MKhIPHAT2Apdo5Qey4dNsY
         cj6Uv4DvvPRqh7GTAlJbeRe13/MW+N+AO8xzibWPO5/VxUpqw3Rd/dKtwmSdlZj+2GMC
         1h7TvAfSiUyt8MLZCExLaIeF+rwydnNniP5UaqJ1JFMSPMsnxaXa21wsPmwXtV1tCr5X
         QuD3oO3M/fnwesBe+xxbgvtVbSvQTruUyA9eOYNATPGzEtyuwSJcvtW8zrNX6fwFKDaO
         EnFQ==
Received: by 10.112.11.9 with SMTP id m9mr7981741lbb.60.1332788914159; Mon, 26
 Mar 2012 12:08:34 -0700 (PDT)
Received: by 10.112.42.8 with HTTP; Mon, 26 Mar 2012 12:08:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193957>

Pardon if this embarrassingly simple question, I am new to git haven't
found git-newbies mailing list.

We have a situation where we want to setup internal git repository that
will be based on say linux-3.3 kernel.

There are about four engineers working on developing things for custom
hardware. So would create a development branch say companyx-devel and w=
e
will commit all of our changes to this compnayx-devel branch.

We also want to keep upto date with latest kernel, so say if we want to
move to latest 3.4-rc4 we could rebase (?) our origin to 3.4-rc4, of co=
urse
fix any of the conflicts we may find etc.

We are not sure how to =A0go about setting up the initial import of lin=
ux3-3
kernel into git repository on of my local servers?

We know we should do following on the server:

git init --bare
git config core.sharedrepository 1

Should we be cloning the linux kernel on the server?
git clone path-to-kernel-org-git-tree

Or I should clone the tree from kernel.dot.org client and then push it =
to my
local git repo?

We tried cloning the tree from kernel.dot.org on client and pushing it =
to our
internal server but that doesn't push kernel code as cloned directory
already has .git directory.

Is there a document/web page one can refer to that might help us handli=
ng
this scenario?

-Kumar
