From: Paul Chown <pmchown@yahoo.co.uk>
Subject: git-p4 under cygwin
Date: Tue, 3 Jan 2012 15:32:06 +0000 (GMT)
Message-ID: <1325604726.49597.YahooMailClassic@web132101.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 03 16:37:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ri6R1-00044F-9d
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 16:37:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753950Ab2ACPhx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jan 2012 10:37:53 -0500
Received: from nm21-vm7.bullet.mail.ird.yahoo.com ([212.82.109.247]:35528 "HELO
	nm21-vm7.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753868Ab2ACPhw convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 Jan 2012 10:37:52 -0500
X-Greylist: delayed 344 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Jan 2012 10:37:51 EST
Received: from [77.238.189.53] by nm21.bullet.mail.ird.yahoo.com with NNFMP; 03 Jan 2012 15:32:06 -0000
Received: from [212.82.108.119] by tm6.bullet.mail.ird.yahoo.com with NNFMP; 03 Jan 2012 15:32:06 -0000
Received: from [127.0.0.1] by omp1028.mail.ird.yahoo.com with NNFMP; 03 Jan 2012 15:32:06 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 934393.74015.bm@omp1028.mail.ird.yahoo.com
Received: (qmail 50128 invoked by uid 60001); 3 Jan 2012 15:32:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.co.uk; s=s1024; t=1325604726; bh=DVfxwamgRcQMVD9aztgVKtLt0fwOLQ8gw8hONXiasEM=; h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=nRi2cww9rniB54W2YC5UuT7rCBSydMmPdtD5XUKqBkT6n1cbqtIbaVG1ffemveX7zUwAhtdpDEw3RlVhcC4LZ79SSPiJCv/ERwZkuTmWa23lP3sO7Y8ymH9tBWZkNvaa+4zg3/cFHz1QYD0ixDJJkzJPnjfAg+LqTLcD9r3xUp8=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=PFBLK1Mgq+hXCo2Rj9uGDVxrA4bcrC5GmvgmhVywHmMBGiiS9KZlaQ/cdlpveGv5qBwqWsvVgPDc211DVhTgbGMgplcX5K33/mDtsp8yD+0ze+ixr0xJevHELSp+J/rn/mqesWw5rDUT0RavI0slYyQztrrkwejJHQ5vbaT4l6o=;
X-YMail-OSG: ya.g6RcVM1kOMvfdlh0OYFVMRdRme2pMM9o9Y8_Atxxxw4F
 lS77_Qt.kO3bCjQAB74cY81jjI.ykCsPJPEUXu5oseqeAZ3QslHg2pbmYVKh
 CQBpobU1pJzVxI1WYnDx2odFYBhzA7eFKiCOcgLGgTMhpidGhq7z6bMjwe89
 mHQ4X50EbjicCMA4OkPweDNasYHm9UgGimHOVONs2N0bOzVCvUIlKDoiNfiJ
 QMi9R0GIFxPcekgq7ueegsKMkF3k1ITDw0SQCR86NmwcNkAiKRNpN6h6KpLX
 zor46jZZ8wsvyWt_qblZKd.88xseqHgg2ByrS98c0tvEiAy2kesn3bsn4ii4
 I_IAmm_sDSN0OnisY2ACyCizfPIdVr7nNYdRmapVOe8M.TCdQMyg89x7VEh2
 kxnbobQOIU8GTjIZebanWoMbw.X8ue6MBOlUBIZViI0cy7IBJxO1yILr97Z4
 VK6LTw7Cnng6_NUAz6P5otWjeR.wOJL2urw1lo0ia2qiTV.iFnIxjz3lH9HE
 1qWFJeNPXYuO2y.WMWzVb9Jp4tyyvhOQtyh4-
Received: from [141.249.133.128] by web132101.mail.ird.yahoo.com via HTTP; Tue, 03 Jan 2012 15:32:06 GMT
X-Mailer: YahooMailClassic/15.0.4 YahooMailWebService/0.8.115.331698
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187866>

I'm trying to use git-p4 to push changes from git into a Perforce repos=
itory under Cygwin, using the cygwin git installation. I followed the i=
nstructions at http://kb.perforce.com/article/1417/git-p4 and everythin=
g works fine until I do the final 'git p4 submit'.

During the submit command I get the following error:
=A0
Path '/cygdrive/c/work/perforce/config_test\...' is not under client's =
root 'c:\work\perforce\config_test'.
Traceback (most recent call last):
=A0 File "/usr/local/bin/git-p4", line 2371, in <module>
=A0=A0=A0 main()
=A0 File "/usr/local/bin/git-p4", line 2366, in main
=A0=A0=A0 if not cmd.run(args):
=A0 File "/usr/local/bin/git-p4", line 1130, in run
=A0=A0=A0 p4_sync("...")
=A0 File "/usr/local/bin/git-p4", line 137, in p4_sync
=A0=A0=A0 p4_system(["sync", path])
=A0 File "/usr/local/bin/git-p4", line 131, in p4_system
=A0=A0=A0 subprocess.check_call(real_cmd, shell=3Dexpand)
=A0 File "/usr/lib/python2.6/subprocess.py", line 498, in check_call
=A0=A0=A0 raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['p4', 'sync', '...']' returned=
 non-zero exit status 1

Is there are recommended approach for using git-p4 on Windows? I also t=
ried using the non-Cygwin installations of git, but these don't seem to=
 have any Python support in them, so the git-p4 code won't run at all.

Many thanks in advance

Paul Chown
