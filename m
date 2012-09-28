From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: git gui does not open bare repositories
Date: Fri, 28 Sep 2012 09:50:03 +0200
Message-ID: <CAB9Jk9CA+e8xR9sz7cW+5+990FmTeYN3pjxs4ZKFpkzb6OL35Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 09:50:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THVKy-0001gB-DA
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 09:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756302Ab2I1HuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 03:50:05 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:38694 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755942Ab2I1HuE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 03:50:04 -0400
Received: by vbbff1 with SMTP id ff1so2849330vbb.19
        for <git@vger.kernel.org>; Fri, 28 Sep 2012 00:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=8kcVVOsXPerbFl5yiraePZh8z4B0c8OSK1+JzrCP184=;
        b=YXMtdNSkOrgJ1G5AjlPHezNIYEVi/KrRrMHQxOvZcUSihWVlDZr8DkOlHHSbpqhMTH
         04ei/R4Q0eEpBohsAfzgnjDmeCkTWqiWCtTmNjjmSxFMfM2BVFfQix48Ujm+8buVsgLw
         CsdjEz990ROFQhTWYoSaJ3iOpFqZGRwntHokWLcfGz2iAzsRRYVW2q5OqmHYZC1hB8P3
         0W4yTF6wZNT1RR7HEwzM1LUQuNjgbD9EtgWnAn03CWSRGdK88ZU6CI6GzeDSz5bRiItc
         B1n5Xk60CCtT8sUETi6KKjQN0ug7vqfEaiDuVJBaoBEtbSfzDPV5CAg8HzczKa8OMWsO
         Mebw==
Received: by 10.52.36.76 with SMTP id o12mr2936862vdj.40.1348818603506; Fri,
 28 Sep 2012 00:50:03 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Fri, 28 Sep 2012 00:50:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206543>

Hello,

I have created a bare repository:

$ mkdir remote.git

angelo@ANGELO-PC /d/gtest (master)
$ git init --bare
Initialized empty Git repository in d:/gtest/

and then tried to open it with the git gui, but have got the message:
"remote.git is not a git repository".

The git gui is the one that I have downloaded from the git web site for windows:

gt-gui version 0.16.GITGUI
git version 1.7.11.msysgit.1

Thank you
-Angelo Borsotti
