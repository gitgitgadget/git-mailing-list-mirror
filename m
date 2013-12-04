From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Publishing "filtered branch repositories" - workflow / recommendations?
Date: Wed, 4 Dec 2013 18:01:07 -0500
Message-ID: <CACPiFCJPq0fqOQrJD-8CHH405Xw61ZDynqqfN+_aZb3ZBgV2VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 05 00:01:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoLRk-0008VC-B0
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 00:01:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078Ab3LDXB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 18:01:28 -0500
Received: from mail-vc0-f175.google.com ([209.85.220.175]:53287 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755146Ab3LDXB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 18:01:28 -0500
Received: by mail-vc0-f175.google.com with SMTP id ld13so12214056vcb.34
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 15:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=Bz4dwR8ic4Na6DQkudkMtiDUD26DwGB5rqB9ot9NUww=;
        b=jnTcZgFAi/h8Swr/bWGoe7onzu7oOPGkEvVfNPzmJ7Y90LDoRtXZUTeCMI3rznV0SS
         BL6QRtfUPqmoB51wWbICBBt2R9dnovb87nO+uXG0KTnhPLM2shNKtuFblMCeB70OPChj
         5qGh6kL17nJugkBOE4J2jbgwcxyblMg/G1Uwg6xf3S4rOf8bpf2B6jpEvSo5KksPQndN
         J0sXuzRlneaFHQ6IfPMlbyeRIq3mz6crfc+hd6r4bhQ8adxYzEwDcm3950rVry7/gyfQ
         ZEwRTbx2AqmLeU+7sF4+gWdbS+JQP2nhav2bRk9Zlj4k/tnorHd4nmMK3QioPUIeKcok
         YSfQ==
X-Received: by 10.220.64.69 with SMTP id d5mr61777966vci.11.1386198087221;
 Wed, 04 Dec 2013 15:01:27 -0800 (PST)
Received: by 10.220.74.133 with HTTP; Wed, 4 Dec 2013 15:01:07 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238826>

Hi folks.

currently working on a project based on Moodle (the LMS that got me
into git in the first place). This is a highly modular software, and I
would like to maintain a bunch of "out of tree" modules in a single
repository, and be able to publish them in "per-module" repositories.

So I would like to maintain a tree with looking like

  auth/foomatic/{code}
  mod/foomatic/{code}

where I can develop, branch and tag all the foomatic code together.
Yet, at release time I want to _also_ publish two repos

  auth-foomatic.git
  mod-foomatic.git

each of them with matching tags and code at the "root" of the git
tree, and ideally with a truthful history (i.e.: similar to having run
git filter-branch --subdirectory-filter, but able to update that
filtered history incrementally).

Is there a reasonable approach to scripting this?

Alternatively, has git submodule been improved so that it's usable by
mere mortals (i.e.: my team), or are there strong alternatives to git
submodule?

cheers,



m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
