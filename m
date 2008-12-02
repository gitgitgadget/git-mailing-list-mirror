From: Gary Yang <garyyang6@yahoo.com>
Subject: git-p4, SyntaxError: invalid syntax
Date: Tue, 2 Dec 2008 11:08:09 -0800 (PST)
Message-ID: <186027.87419.qm@web37901.mail.mud.yahoo.com>
Reply-To: garyyang6@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 02 20:09:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7ack-0007x5-Ly
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 20:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754212AbYLBTIN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Dec 2008 14:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754204AbYLBTIM
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 14:08:12 -0500
Received: from web37901.mail.mud.yahoo.com ([209.191.91.163]:20684 "HELO
	web37901.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752507AbYLBTIK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 2 Dec 2008 14:08:10 -0500
Received: (qmail 88590 invoked by uid 60001); 2 Dec 2008 19:08:09 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=w3ByujoA61sTt0MjF5lUR6nESwHvm0hwYJ1posjeEUCvULTXYY0gdzvSBOaaFS35iHy6hAI/WaKdiBEISoCFLpb5NQNGMOUylz2DJH3uR/ZgfQeAi3qKkmRhdQmTN0W9xii3pG/CgYnBNcDWJ9RMxNdeFuwWkO0mD3+7PC8VUbk=;
X-YMail-OSG: CEALT_IVM1mjfCX.tNfZ0nOo_6eel8KmNgiRUU9NHzhEZcRupgdbTR9_MegzsHC_WhFY9KKW4WOtOhDtQayHMJM9sjqMi3mWvd3_LgrLiDchZwzYYGkXUHWEg1ftlmRTP_Hsl_01g9uGXHv9SaB2wQA6R3tUBajkAYpWklyQwpK4mZhC4UuEbI_H6aw0
Received: from [76.195.33.70] by web37901.mail.mud.yahoo.com via HTTP; Tue, 02 Dec 2008 11:08:09 PST
X-Mailer: YahooMailWebService/0.7.260.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102169>


I got git-p4 from =E2=80=9Cgit clone git://git.kernel.org/pub/scm/git/g=
it.git git=E2=80=9D
I copied git-p4 from contrib/fast-import/git-p4 to /home/gyang/bin

I got SyntaxError  when I ran,

git-p4 clone //depot/Workshop

/home/gyang/bin/git-p4:161: Warning: 'yield' will become a reserved key=
word in the future
  File "/user/svdc/pluo/bin/git-p4", line 161
    yield pattern
                ^
SyntaxError: invalid syntax

I opened the file, git-p4. There are three import lines. I am not pytho=
n programmer. Maybe I missed something in python? I have python install=
ed at /usr/local/bin/python

which python
/usr/local/bin/python

vi git-p4
import optparse, sys, os, marshal, popen2, subprocess, shelve
import tempfile, getopt, sha, os.path, time, platform
import re

Can someone tell me what I missed?

Thanks.




     =20
