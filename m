From: supadhyay <supadhyay@imany.com>
Subject: cvs2git failed in pass2 ...
Date: Tue, 21 Feb 2012 04:52:02 -0800 (PST)
Message-ID: <1329828722466-7304605.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 13:52:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzpCV-0002UY-0Q
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 13:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754396Ab2BUMwF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Feb 2012 07:52:05 -0500
Received: from sam.nabble.com ([216.139.236.26]:40641 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754235Ab2BUMwE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2012 07:52:04 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <supadhyay@imany.com>)
	id 1RzpCM-00074t-Fh
	for git@vger.kernel.org; Tue, 21 Feb 2012 04:52:02 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191154>

Hi All,

I am using cvs2svn  tool to convert my CVS repository to GIT. I have
download the "cvs2svn-2.3.0.tar.gz" file.

I have created git user to install GIT and then using the same user (gi=
t) I
try to run "./cvs2git" command  below way.

=2E/cvs2git \  --blobfile=3D/home/git/tmp/git-files/git-blob.dat \=20
--dumpfile=3D/home/git/tmp/git-files/git-dump.dat \    --username=3Dgit=
  =20
/opt/source/Repo_from_CVS/VD

It took around 10 mins to finish pass1 and for pass 2 it raised the war=
nings
and messages like below=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Done

Time for pass1 (CollectRevsPass): 526.3 seconds.
----- pass 2 (CleanMetadataPass) -----
Converting metadata to UTF8...
WARNING: Problem decoding log message:
-----------------------------------------------------------------------=
----
version 4  - Note concerning =E2=80=9CLeave One=E2=80=9D option for Int=
ernal Duplicate Check
added
=20
-----------------------------------------------------------------------=
----
WARNING: Problem decoding log message:
-----------------------------------------------------------------------=
----
=2E.....
=2E.....
=2E.....
-----------------------------------------------------------------------=
----
WARNING: Problem decoding log message:
-----------------------------------------------------------------------=
----
all labels to be right-justified
all labels to end with =E2=80=9C:=E2=80=9D
removed Selected Error Codes label
=E2=80=98Select One=E2=80=99 dropdowns are horizontally aligned with co=
rresponding text
boxes
=20
-----------------------------------------------------------------------=
----
ERROR: There were warnings converting author names and/or log messages
to Unicode (see messages above).  Please restart this pass
with one or more '--encoding' parameters or with
'--fallback-encoding'.

***********************************************************************=
************
can any one suggest me how to overcome this warning or any workaround ?=
?

Thanks in advance...




--
View this message in context: http://git.661346.n2.nabble.com/cvs2git-f=
ailed-in-pass2-tp7304605p7304605.html
Sent from the git mailing list archive at Nabble.com.
