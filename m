From: Robert Buck <buck.robert.j@gmail.com>
Subject: [remote rejected] master -> master (n/a (unpacker error))
Date: Wed, 12 May 2010 15:45:52 -0400
Message-ID: <AANLkTinV2U6Lbbl0N7jVAESEi0mZQ_D3slMEYa68vRT4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 12 21:46:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCHsW-00034l-7L
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 21:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156Ab0ELTpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 15:45:55 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42787 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932092Ab0ELTpy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 15:45:54 -0400
Received: by wyb32 with SMTP id 32so352072wyb.19
        for <git@vger.kernel.org>; Wed, 12 May 2010 12:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=myDnZYze2W/B+Po3+CmGRH1S6f9apBHItnJh9/HoSRA=;
        b=VIBXswgR8W/GRKUCozEoiqWYFGMT578XbxvyEGuj9oJyYfSe4e2ETVeaTDlk22BZbB
         ySujck5gLZJyBG3p5C0ali49Y7Ti1DzfCAqyGURYLYI6SGxi44MUOPiRWFRL7aMzI35t
         nIMFsHInjOUftFAYOQb6aKd1j4VXc9EYsnpAk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=O957Y2XCMQR7tBzv5wQjpCl/3DCCJj6YH3//k4sRLyo7FeJ11Z6gXWCAb4RLOQW6lf
         0uN5wfC8R0sE6q2xwf6v2P7jCCR330JxW/jr9+qjcAS5L/1E2NG+8hHkD7H6YfG4Xi27
         VVS/jVIKgzBnn68fZ2u8+V9r8SG8lwXj9H/fE=
Received: by 10.216.89.140 with SMTP id c12mr620080wef.163.1273693552914; Wed, 
	12 May 2010 12:45:52 -0700 (PDT)
Received: by 10.216.7.207 with HTTP; Wed, 12 May 2010 12:45:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146960>

Today, just after someone else committed to my public repository I
started getting errors. Until then Git worked great.

Does anyone know what is going on here? Are there particular versions
of Git with known issues around this?


uname@hostname:~/dev/workspaces/scm-evaluations/welcome.git/install/git-config$
git push
Counting objects: 7, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 922 bytes, done.
Total 4 (delta 0), reused 4 (delta 0)
error: unable to create temporary sha1 filename ./objects/e6: File
exists

fatal: failed to write object
error: unpack failed: unpacker exited with error code
To ssh://git.projectbedrock.com/var/cache/git/welcome.git
 ! [remote rejected] master -> master (n/a (unpacker error))
error: failed to push some refs to
'ssh://git.projectbedrock.com/var/cache/git/welcome.git'


As an aside, where the heck is the git bug tracker? I've searched, and
searched, and ... All I found is a Debian tracking system, which
appears to have no full text search capabilities.
