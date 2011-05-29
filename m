From: Arnaud Lacurie <arnaud.lacurie@gmail.com>
Subject: Notes in fast import stream.
Date: Sun, 29 May 2011 17:52:06 +0200
Message-ID: <BANLkTinpQ6HbTdNF8K5N0D3aYugj591LRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sylvain Boulme <sylvain.boulme@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 17:52:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQiI4-0005Ym-S4
	for gcvg-git-2@lo.gmane.org; Sun, 29 May 2011 17:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104Ab1E2Pw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2011 11:52:27 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:39036 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049Ab1E2Pw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2011 11:52:27 -0400
Received: by vxi39 with SMTP id 39so2239713vxi.19
        for <git@vger.kernel.org>; Sun, 29 May 2011 08:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to:cc
         :content-type;
        bh=YT+1sgtOrEfJDUepeFrpCNfE/ZEuF2fZaougqLERcb0=;
        b=SQTwA1ONRRBdJ87Kb0r1qN6d30UUjpvNVoKUG8eE47vKT5Y2S3h7ebNKhDWLm40yut
         EiTyn8zOlxXF3y+3/4VbuyISBh4Y9h7I/r8K+/+VsRMk+tpuZNI7oRqh3JCSgny86d6G
         1a6tB4wKTYDjMTCeh575n/R7MKhig+KD0gGhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=KM9JAhSCGJljvK9kRT8GJlL73kcJLF4IDFv6xYKrj0zM5IYtHjdfKLAPPi6Cvm6t9p
         j7AQuW7T3hOtWt2WHagLQhk4/c3/0wXgk7kPdyhZASi3j8EGBzGzNfPbsDJ7GsqomFbv
         /UIr9EF1NcHzeSq9OEkV1OLfYXU6NGvdS6gMQ=
Received: by 10.221.9.136 with SMTP id ow8mr1610771vcb.78.1306684346114; Sun,
 29 May 2011 08:52:26 -0700 (PDT)
Received: by 10.220.189.8 with HTTP; Sun, 29 May 2011 08:52:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174692>

Hi,

I would like to add notes through a fast-import stream.
The problem is that I can't know the SHA1 of the commit I would like
to add a note to before the fast-import is done.
I would like to use marks to link my note to a commit this way :


commit refs/heads/master";
mark :1
committer user <user@example.com> GMT+0000
data length_of_my_comment
my_comment
M 644 inline my_file
data length_of_my_file
my_file_content
N inline :1
data my_note_length
my_note_content

This doesn't work because the mark 1 declaration is not finished, and
I can't bind a note to it yet.

How could I do then ?

Thanks for you help.


-- 
Arnaud Lacurie
