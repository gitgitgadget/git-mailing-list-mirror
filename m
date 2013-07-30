From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Flatten history
Date: Mon, 29 Jul 2013 18:42:14 -0700
Message-ID: <CAE1pOi0CQ1k3h3ie=s3qvkQog9foYBOnJ++uuum-Br7vzQHRSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 30 03:42:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3yxb-0004M8-7P
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 03:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773Ab3G3Bmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 21:42:35 -0400
Received: from mail-vc0-f169.google.com ([209.85.220.169]:35024 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402Ab3G3Bmf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 21:42:35 -0400
Received: by mail-vc0-f169.google.com with SMTP id ib11so2679015vcb.0
        for <git@vger.kernel.org>; Mon, 29 Jul 2013 18:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=PnSznVa8M/NY3v/ilhUzqYwApVt00f1YL+ky2oQU8wU=;
        b=kSlCGaAlxFE0N0sH4ujtSkOPxRFD7oxhuon3A68KMrn4ptMd2Q5hAqjFGDaHmJ69Hx
         c1P94R/FEUOSpGTeFHJA2cRJjGcAcOsloAA68MdSgD+iQPO8XH6l9pHMcqOJW40D9kvB
         6LfcFYELZC23bU44GU4Zi0VTLgypL78FYCiqc/yUK7CjFvrI+7M3zegBXhPCifCpjlwV
         FJfOpseAVM3RHe8Y+hLDiQPK1bcxOak7qjRBeILkxnkqgM1lm1RwJGm4xkoFkJ/iY4ni
         kcJ5vzmAKao3oN3K8C1z3zqVFY60Ivucw1HuZ188rNOLJ8zYGoHbwr6GyJ5wtFMNtBpF
         1LmA==
X-Received: by 10.58.49.130 with SMTP id u2mr26905686ven.7.1375148554196; Mon,
 29 Jul 2013 18:42:34 -0700 (PDT)
Received: by 10.58.229.106 with HTTP; Mon, 29 Jul 2013 18:42:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231342>

Hi all,

I have a (public) "feature" branch that has been kept up-to-date with
"master" by regularly merging master back into it. I would now like to
get all the changes from feature but not any of the commits.
Basically, I want to replay all of feature's commits without creating
those commits.

I thought something like

git cherry-pick -n abcd^..feature

should do the trick (while on master, where abcd is the SHA-1 of the
commit where feature was created) but I get conflicts.

First, why the conflicts? I have done all the merges so cherry-pick
should simply be able to replay them? Second, what is the correct way
of doing this?

Cheers,
Hilco

P.S. The most annoying thing is that I've done this exact thing before
but I can't find what command I used. :-)
