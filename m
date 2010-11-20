From: Yang Zhang <yanghatespam@gmail.com>
Subject: =?windows-1252?Q?How_to_fix_=93Your_branch_and_=27origin=2Fmaster=27_have_d?=
	=?windows-1252?Q?iverged=94_after_editing_a_commit_that_came_before_a_pull=3F?=
Date: Fri, 19 Nov 2010 16:36:46 -0800
Message-ID: <AANLkTikr+uGrO2EB9WQk+CXeOm7jiYxdbhGzRRvgc9B9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 20 01:37:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJbSJ-0003f5-N3
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 01:37:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713Ab0KTAhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 19:37:12 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:54411 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614Ab0KTAhL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 19:37:11 -0500
Received: by gwb20 with SMTP id 20so363420gwb.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 16:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=OtZkidOMXgUIvDwJFko/jeGHqUGpm5mh+5SOy5EFOFc=;
        b=JG0ltJCoBDDAFlaJgSdW5zT3oCaB7oMZJ1zfHWGy35GkJbUQDl3cTqglqJlsDhjZvv
         YwWbA4m3QJNyOK8aj5Le2qZnrMZNIxGWOsv2yDxwctFJEB82IDG2Qe3hshC3idZM1drh
         24nTesVJnoilj1wMgsveRUhnNnocUjMGuBX4M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=clLfVJ86dcGNBbHV9cNWxw5fT8RnsWkUwEEJUuD84Qej08j6CvKtgeELlqsj+n3JJy
         APVN4uaaOnO4NmujXlbLfICFufKMPk3ZmxQlETAc4tusYzydpDLItTqX4H5AQT01avG0
         1UL0vPrBtDczduFuD841HFevEVIXrYr9ffqYw=
Received: by 10.90.2.23 with SMTP id 23mr3506188agb.97.1290213429981; Fri, 19
 Nov 2010 16:37:09 -0800 (PST)
Received: by 10.90.222.2 with HTTP; Fri, 19 Nov 2010 16:36:46 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161798>

In the following scenario:

1. Make commits A, B, C
2. Pull, getting commits D, E
3. Make more commits F, G, H, ...
4. Realize that you need to tweak B
5. Tweak B using git rebase -i and git commit --amend

Now git status says:

  Your branch and 'origin/master' have diverged.

How should I fix this? Thanks.
