From: Luiz Ramos <luizzramos@yahoo.com.br>
Subject: About git-diff
Date: Tue, 9 Aug 2011 18:52:57 -0700 (PDT)
Message-ID: <1312941177.17928.YahooMailClassic@web121810.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 10 03:59:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qqy4u-0006u4-RK
	for gcvg-git-2@lo.gmane.org; Wed, 10 Aug 2011 03:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034Ab1HJB7R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Aug 2011 21:59:17 -0400
Received: from nm24-vm0.bullet.mail.ne1.yahoo.com ([98.138.90.34]:37689 "HELO
	nm24-vm0.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750894Ab1HJB7Q convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 9 Aug 2011 21:59:16 -0400
X-Greylist: delayed 378 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Aug 2011 21:59:16 EDT
Received: from [98.138.90.53] by nm24.bullet.mail.ne1.yahoo.com with NNFMP; 10 Aug 2011 01:52:58 -0000
Received: from [98.138.89.174] by tm6.bullet.mail.ne1.yahoo.com with NNFMP; 10 Aug 2011 01:52:58 -0000
Received: from [127.0.0.1] by omp1030.mail.ne1.yahoo.com with NNFMP; 10 Aug 2011 01:52:58 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 116511.60083.bm@omp1030.mail.ne1.yahoo.com
Received: (qmail 34097 invoked by uid 60001); 10 Aug 2011 01:52:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com.br; s=s1024; t=1312941178; bh=4ibN7n44mQGgV8OBYfATgJWVynIxaXd9/06mNV1ix1E=; h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=S3GnO7sT5YuOACankYGEMj9hcAahtEQtewxYTzq0F06zMR+U4ppkDTJZzga9lZg5dD6+0yCxoE6S9r4PNpbEqKuXKqLPAyc6uP7CgGHBHToQ2h6V0p/L053Vu3ldGOgSScmJmEGGGz2UM6PtEb7LVYusfnxTQw+4lsk7ux4vwpA=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.br;
  h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=F7wc8hXz1kHEK1WhHfyp1CMNPRVW6fQeZQOji2I7V7Po85MXUkSn5jz8B0bHHq7Cn0j+O7DbkSdzWehnukpKJkVx5HZ3T3pmaw2QI64t8xP/adTO1kKDhovRp/qzBlMHM6kP95itYekPbLwDnA5JdgWkxL3T4p9VZog+DGbPNhY=;
X-YMail-OSG: v6Wx3CAVM1n8XQDDux6wZKK0iA6VToKNCFGtFKt5EZsYqhS
 cyoVSN.Pf6Ek.mGWuclG2d8I5dtc4UnQPz7uQwGDWUBtz7z3lbhIq5G6qKn8
 QvmtQYaEFqOhj._dbz9SyncIJSfLfJXlsjno1o1jb0y4Tk1WIohrUnFuwzzd
 mfODTxhpLuhE25qwlkHsu05dXPwScsIIm_8wv1waVTAI27n_lOvbFWNtxH7B
 IC7Wx.wULF7MMyKo0bNSi88Kz8_fgt.eZEdzZUCz1dcm1sOgafHmRJEuQ3kU
 GlAO_Duh6bH0iqDu3rjKgi84EJ3GUBVfHKRV6Eyc4U2ExDVGlrsDC_tZoJ29
 hYaf84ILGUWDaxednW0Qv913w4.z_2vLDfJgVE0cWfymb6V4r
Received: from [189.121.246.226] by web121810.mail.ne1.yahoo.com via HTTP; Tue, 09 Aug 2011 18:52:57 PDT
X-Mailer: YahooMailClassic/14.0.4 YahooMailWebService/0.8.113.313619
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179053>

Hello,

just a doubt, but it can also be a bug.

Suppose there is a project stored in git, and it has two branches. In t=
he branch b1, there is a single file, file_1. In the branch b2, there i=
s a single file file_2.

Suppose also I am using branch b1 above (that is, "git checkout b1" was=
 previously run), but the file file_2 was left in the working directory=
 along with file_1.

If I run:

$ git diff --cached b2 ./

The results will point that the file file_1 is added, as it is in the i=
ndex and not in the tree b2. It will also point that file file_2 is rem=
oved, as it is listed in the tree b2, but not in the index. No doubts h=
ere.

If I run:

$ git diff b2 ./

that is, the "non-cached" version, it will show the same results. This =
is confusing IMHO, because the git-diff manual suggests that invocation=
 should render the difference between the named tree contents and the w=
orking directory. In the working directory, only to recall, file_1 and =
file_2 are both present and with good versions. In my understanding, th=
e command should report that file_1 is in excess in the working directo=
ry, relative to b2, and report nothing about file_2, as it is in the sa=
me version as the sample in the tree b2.

This doesn't seem to be the same thing git-diff-index manual states, ho=
wever. The manual gets more deep into the details, and it's not so easy=
 to understand it unless one knows a lot of the inner commands, which d=
oes not apply to me. In my basic reading, it seems that behind the scen=
es, git-diff-index is what is run in this case, and the fact that file_=
2 is not in the tree associated to b1 is a relevant thing in this case.=
 So, the index seem to matter, and if I try to do it, a previous "git u=
pdate-index" should be done.

I may be wrong, but as a user, I'd like to have the non-cached command =
version comparing tree and working directory, as the manual of git-diff=
 suggests, eventually helped by the index, but not limited to it. Becau=
se if I'd like to compare with index, I would try it using --cached ins=
tead.

Please accept my apologies if there is some newbie mistake here.

Thanks,

Luiz Ramos
S=E3o Paulo - Brazil
