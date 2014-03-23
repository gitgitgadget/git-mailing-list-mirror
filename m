From: David Cowden <dcow90@gmail.com>
Subject: Git-hooks pre-push script does not receive input on stdin
Date: Sat, 22 Mar 2014 17:44:07 -0700
Message-ID: <CAC1XvcPshKQXuRPDd8reb6fsDU3BNOsBAUKO25_dVBD331=yRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 23 01:44:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRWWN-0001FQ-Sa
	for gcvg-git-2@plane.gmane.org; Sun, 23 Mar 2014 01:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbaCWAoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2014 20:44:10 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:55416 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbaCWAoI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2014 20:44:08 -0400
Received: by mail-qg0-f49.google.com with SMTP id z60so12023502qgd.8
        for <git@vger.kernel.org>; Sat, 22 Mar 2014 17:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=D5oayq+B6PWES24cp+R48b4+7rQwhLb5PU7rXW+lyuI=;
        b=0GGTzsz/Que3L4QmHcu7gALUSLNQ2nt+TQjY79OH0/QoqiYXQwEvzdrUIHDYTHdY3M
         /bL8a/0eVa9PmJjA6wCDzNV4hghYj2BC7Fm7qOBwpktNNZg2gljmXRRNqEfTg85dxtzK
         HlYnXiXJyIR/GjvZlooiE5IxJHfPwA3TDjfRLElznQH6ROy9hVFpsDTUs5TOvpyYNsO8
         c/PIsl2iNAGfZqN8Rf3aALDRfVaZ4YABa68no1lpW9ReqCJGK/ue7Db9J9klqqjW+q43
         Rz8KSkNcrfJsd/flE5uSlMU1XdKqGM5v+9M3aQ0A5glca3cS4N5kWYy3KPtrx1SkOCmQ
         PM6Q==
X-Received: by 10.140.102.2 with SMTP id v2mr64304298qge.27.1395535447920;
 Sat, 22 Mar 2014 17:44:07 -0700 (PDT)
Received: by 10.140.91.14 with HTTP; Sat, 22 Mar 2014 17:44:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244787>

http://stackoverflow.com/questions/22585091/git-hooks-pre-push-script-does-not-receive-input-via-stdin

Is this a bug in git?  Or am I just a shell noob?

Thanks in advance,

David
