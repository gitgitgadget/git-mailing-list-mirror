From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [RFC] External diff viewer
Date: Sat, 25 Mar 2006 10:50:49 +0100
Message-ID: <e5bfff550603250150q7cfa66b2s8a56a23daca80887@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Mar 25 10:51:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FN5Q6-0003JL-Qq
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 10:50:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWCYJuv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 04:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWCYJuv
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 04:50:51 -0500
Received: from pproxy.gmail.com ([64.233.166.179]:65311 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751146AbWCYJuv convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 04:50:51 -0500
Received: by pproxy.gmail.com with SMTP id n25so505021pyg
        for <git@vger.kernel.org>; Sat, 25 Mar 2006 01:50:50 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=q8gqfr93DRtC0FJgZtU9Wo0Evw3+M5RYNYKu1YoOqnbHJwItyT/CAxBvhfFuD7RgiWvqF/Ux8Ea6XeWijg5SztssDnvP8I9E8wxAkPPLlMMlwwNyHn5CnJ6FrOv2COuBaA3swrqxbCQkXFMmOZJHUNr12Te9BxEr1tTATI/s/aI=
Received: by 10.65.74.11 with SMTP id b11mr985431qbl;
        Sat, 25 Mar 2006 01:50:49 -0800 (PST)
Received: by 10.64.142.5 with HTTP; Sat, 25 Mar 2006 01:50:49 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17970>

I have just pushed a patch to let qgit support external diff viewers.
Git repo is

http://digilander.libero.it/mcostalba/scm/qgit.git

This is how it works:

>From menu View->'External diff' it is possible to invoke an external
diff viewer, as example to view the diffs in a two vertical tiled
windows.

External diff viewer shows the diffs between two files.
First file is the current selected file of current revision. Second
file is the same file of the parent revision or of a specific revision
if "diff to selected sha" feature is enabled (CTRL + RIGHT CLICK on
chosen revision with *internal* diff viewer window open).

Default external viewer is kompare, but it is possible to set a
preferred one from Edit->Settings->External Diff Viewer.


I don't think the feature is  already release ready, so I just pushed
the patch in git repo for interested people.

Feedback/comments /bugs or something to change or improve before to release?

Thanks
Marco
