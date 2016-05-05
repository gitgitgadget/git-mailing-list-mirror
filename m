From: Bryant Bernstein <bryant.bernstein@gmail.com>
Subject: possible problem / bug
Date: Thu, 5 May 2016 12:19:10 +1000
Message-ID: <CAPpP+uW=ReKkUnz4PMEyhchcafd0qtgSZ_Qg0Hq77k4u+aPUyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 04:19:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay8sm-0007Je-08
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 04:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897AbcEECTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 22:19:12 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:33417 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753875AbcEECTL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 22:19:11 -0400
Received: by mail-io0-f177.google.com with SMTP id f89so72623493ioi.0
        for <git@vger.kernel.org>; Wed, 04 May 2016 19:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=STfYo1zl9p50wQ2nJYkZR5broS3AnQQuVC9LHOirc/Y=;
        b=wxESBwknZtW5rOmkcfn0KecajBIotgjRhPvbx/9uZi7awNiBh3TtWBG3quoTcucBwf
         SSapzPUbMAi+MUn0moRvoH66jLEXtcsyl5pgv+gyNuafuZgBNxPINwbU5rXmZsYRt5eq
         T2Rlj2+c9Wo7f4H3fl5kQbaijCOKv8/13sVKkdVTdjpMoQECR+3EjutHu+YjzE4iv43C
         kA++jlsWGpAznRUiDPi8XRHhZPYVr3ixE79p02U/A2SBAFgY184VMO7EWjBNu2WWVK2O
         sPxBEArMCeCW5ZkMjLmW8eyo6bqD7wKWR3x4AE+v79V2NS1a1VcYO6KVLfDi21/oT/K1
         u/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=STfYo1zl9p50wQ2nJYkZR5broS3AnQQuVC9LHOirc/Y=;
        b=X6o+GzrBj3ClZ5CisqICkyyFn+07K9nIrTj9pMayax6tLlmdTimllQ4BaphbfbbI07
         Hdetw4krt28PBYPDpGg/q8HWJ9YKDCyxwWZx307yjryxyF7W1EJtVQqMqR9HjhBZ8pnb
         IYM7y0+C6CK6MbMTi+9eOW3aVDm3AB/Vtf5qNog2Tc1tc2l1f8/DeiDEApuPwo2MkxIv
         oMXKkoXWARhM7kRs2+ydC6jl0r/mL0ffL45dZdmD2xsA5j7EWi03CCYkSDpDP9sXjMg7
         RDH4cN7FHW7dorehVLSardGDqYfIxOzaY5AkTF4UvhTcjqV6RjJwUtwNzn2nSFqNvkle
         0uPQ==
X-Gm-Message-State: AOPr4FVAZZ0lzpPX3Fzy92xQZTP/wtTLkzGlbT4G6qEr5ihh2XjeZ4J6+XQ1dr/rkf8B+ZaEfaSgzDWKNv1VbA==
X-Received: by 10.107.130.160 with SMTP id m32mr15913489ioi.137.1462414750801;
 Wed, 04 May 2016 19:19:10 -0700 (PDT)
Received: by 10.64.246.108 with HTTP; Wed, 4 May 2016 19:19:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293631>

Both windows and linux support links but both git and the git bash
seem to have a problem with them.

In my source, (originally on Linux) I have a link in my source
directory to a config file which I normally import into python.  This
allows me to have something.py pointing to config.txt .  config.txt
can be opened by an editor and something.py can be imported into a
python shell.

This worked in Linux alone and on windows  as both platforms support
links.  But if I use git to bring my code from linux to windows I end
up with a file that contains the path to the target file.

Then I went to try to see what git bash would do with a link.

I created a file and a link to it using ln -s
This created a copy of the file I wanted to link to.

What do you think?
Should this work better?

Bryant Bernstein
+ 61 419 323 378
