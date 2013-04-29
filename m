From: Eric Cousineau <eacousineau@gmail.com>
Subject: [ANNOUNCE] git-submodule-ext, git-new-workdir (updates for
 supermodules), and git-emeld (using git-new-workdir)
Date: Mon, 29 Apr 2013 00:17:57 -0500
Message-ID: <CA+aSAWvPahFZuYTbpPMfRo5p7onxZ7L2CX571r7izczeBajxRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 29 07:18:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWgTV-0004xR-PA
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 07:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062Ab3D2FSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 01:18:00 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:44633 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab3D2FR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 01:17:59 -0400
Received: by mail-lb0-f175.google.com with SMTP id w20so4377487lbh.6
        for <git@vger.kernel.org>; Sun, 28 Apr 2013 22:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=cI5/JcFEqXrHgrPYzjUBrqu99oov05LlXm/DChZgXZU=;
        b=bkdscV5bJktQJHvSzqNTPZ7sWR4iasxUKL96ZhFk/hIKtK7v2cc+UVbrNPXivT1OvL
         joYdvmj00F8VVjVIpN0GKLisdTcTMGdozAD/1xR3yA2OZaOpdv7RAqCETtoJu2wI3lWM
         VYKshqggPUclUNwmcfZuPpBVJyFtsGkVpjSrzJtzzDJ0nJaUt4O1CnHuRhKcQ2L30FDI
         kw5mS+O56VYXxkYeE69tnazAiXoUIwnlqnL6x/ywLFpqjFUuRkTs29R0Vf6WeTzSbe1b
         WFYM1TVdimwmCNT7yAWuk6Z3OPEZjXNnaN3qrkq4eSOd8Ucj08DeSk6eobL7xAOOVik2
         /BMw==
X-Received: by 10.112.140.100 with SMTP id rf4mr17269053lbb.82.1367212677791;
 Sun, 28 Apr 2013 22:17:57 -0700 (PDT)
Received: by 10.114.57.237 with HTTP; Sun, 28 Apr 2013 22:17:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222770>

Hello,

I have been working on some of the following utilities for working
with submodules:

* git-submodule-ext - Experimental extensions to git-submodule.
Includes 'foreach' with --top-level, --post-order, and --constrain
options. (Been using this to prototype patches for git-submodule)
* git-new-workdir - Modified from git/contrib, I've added support for
using this on supermodules and submodules. It does so by changing some
of the config (which I figured did not matter if the new workdir's are
meant to be short-lived)
* git-emeld - Inspired by git-meld / git-diffall, compare editable
versions of your repos, so you can then go back and make commits.
Since it uses git-new-workdir, it can be used for supermodules as
well.

These are available here: https://github.com/eacousineau/util [Kind of
generic name, may change later]

I have also put together a small primer on Git submodules:
https://github.com/eacousineau/util/blob/master/SUBMODULES.md

Let me know of any suggestions you have for these tools or the primer.
I plan to submit these modifications as patches in the future.

Thank you,
- Eric Cousineau
