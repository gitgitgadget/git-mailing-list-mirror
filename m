From: Chico Sokol <chico.sokol@gmail.com>
Subject: Reading commit objects
Date: Tue, 21 May 2013 18:21:49 -0300
Message-ID: <CABx5MBQ57-=MPamvV-peZUdD_KDLX+5cy9vD7CL7p_Vz9BkvTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 21 23:22:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ueu0d-00011S-PI
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 23:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647Ab3EUVWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 17:22:11 -0400
Received: from mail-ve0-f180.google.com ([209.85.128.180]:38324 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445Ab3EUVWK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 17:22:10 -0400
Received: by mail-ve0-f180.google.com with SMTP id c13so879787vea.25
        for <git@vger.kernel.org>; Tue, 21 May 2013 14:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=dUKkfyivuYrxbSJhE7XvIi3WMBfRlEfr3UijpyFRbpE=;
        b=vmDD0ZNdFLSnGIbE6pppLGKAoZg8BKC6787I466NBzCZgH26WX7p8Hy9V9OSlz8vOZ
         hPKUGIusrTfiz5on6eR/f715xAAbiytOQ1UQgUY2Zg3GmASd+kdellHwR7J1J3UE5Lob
         eFRM9jqausfJ+8Gd5Z991JsJi3e0nTyoWm0LuQBSjxSE2qIh2idcvXaLCp510RFNKD2a
         Oc34EVVVvTUO30FwReVE/nbGCfuKcl5z9T0KisoTO4AQT7AT3BZ4M5g0rZSzYyT7WB2g
         Z5ZcBhdp2J8KvMl5IXUdqoz7tEqs5OtGyJsJ3eXCMwaKuy8vpRC+xTmiaB5eq1dpbRNO
         Nt6w==
X-Received: by 10.52.175.200 with SMTP id cc8mr1435429vdc.94.1369171329832;
 Tue, 21 May 2013 14:22:09 -0700 (PDT)
Received: by 10.220.80.10 with HTTP; Tue, 21 May 2013 14:21:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225081>

Hello,

I'm building a library to manipulate git repositories (interacting
directly with the filesystem).

Currently, we're trying to parse commit objects. After decompressing
the contents of a commit object file we got the following output:

commit 191
author Francisco Sokol <chico.sokol@gmail.com> 1369140112 -0300
committer Francisco Sokol <chico.sokol@gmail.com> 1369140112 -0300

first commit

We hoped to get the same output of a "git cat-file -p <sha1>", but
that didn't happened. From a commit object, how can I find tree object
hash of this commit?

Thanks,


--
Chico Sokol
