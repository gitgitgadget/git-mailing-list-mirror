From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: Fwd: git-gui / Warning: "No newline at end of
 =?windows-1252?Q?file=94?=
Date: Wed, 09 Jan 2013 14:49:06 +0000
Message-ID: <87vcb6bee5.fsf@fox.patthoyts.tk>
References: <CADEaiE-J4nEwyK4WSiH=zzaH6cb85mw15O3wxrWrTXJtZfJixQ@mail.gmail.com>
	<CADEaiE8GKfSQ5u+0bb8qtBe-3OTYJThGb-UFLU_pM-T9ZqvkiA@mail.gmail.com>
	<7vzk0qw8ts.fsf@alter.siamese.dyndns.org>
Reply-To: patthoyts@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>,
	Tobias Preuss <tobias.preuss@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 16:26:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsxY0-0005Cv-3H
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 16:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758018Ab3AIP0M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jan 2013 10:26:12 -0500
Received: from queueout04-winn.ispmail.ntl.com ([81.103.221.58]:63298 "EHLO
	queueout04-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757951Ab3AIP0L convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 9 Jan 2013 10:26:11 -0500
X-Greylist: delayed 2182 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Jan 2013 10:26:11 EST
Received: from know-smtpout-1.server.virginmedia.net ([62.254.123.2])
          by mtaout04-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20130109144946.HIGW18581.mtaout04-winn.ispmail.ntl.com@know-smtpout-1.server.virginmedia.net>;
          Wed, 9 Jan 2013 14:49:46 +0000
Received: from [94.171.229.22] (helo=fox.patthoyts.tk)
	by know-smtpout-1.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1Tswxo-0000ir-Ck; Wed, 09 Jan 2013 14:49:08 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id AA608203CD; Wed,  9 Jan 2013 14:49:07 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
In-Reply-To: <7vzk0qw8ts.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 03 Jan 2013 08:05:35 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=GaEGOwq9FwezmTggA+b6yC6zDZF2HYaK6RN/tSqdnVA= c=1 sm=0 a=F0HhOJWMmYsA:10 a=QEmNFJdUCFwA:10 a=CtgcEeagiGAA:10 a=N659UExz7-8A:10 a=ybZZDoGAAAAA:8 a=mK_AVkanAAAA:8 a=VwQbUJbxAAAA:8 a=uPZiAMpXAAAA:8 a=Rf460ibiAAAA:8 a=2WieraIuLO8eX-oU4IMA:9 a=pILNOxqGKmIA:10 a=qIVjreYYsbEA:10 a=9xyTavCNlvEA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213060>

Junio C Hamano <gitster@pobox.com> writes:

>Tobias Preuss <tobias.preuss@googlemail.com> writes:
>
>> Hello. I never got a response. Did my email pass the distribution
>> list? Best, Tobias
>
>Pat?
>

I did have a brief look at this but I don't have a solution at the
moment. The "\ No newline at end of file" is emitted by git at we don't
appear to handle it well in the lib/diff.tcl apply_range_or_line
function.

>> ---------- Forwarded message ----------
>> From: Tobias Preuss <tobias.preuss@googlemail.com>
>> Date: Tue, Nov 13, 2012 at 9:26 PM
>> Subject: git-gui / Warning: "No newline at end of file=94
>> To: git <git@vger.kernel.org>
>>
>>
>> Hello.
>> I noticed a problem when working with git-gui which might be a bug.
>> The issue only affects you when you are visually trying to stage
>> changes line by line. Here are the steps to reproduce the problem:
>>
>> 1. Initialize a new repository.
>> 2. Create a file with three lines of content each with the word
>> "Hello". Do not put a new line at the end of the file.
>> 3. Add and commit the file.
>> 4. Edit the same file putting words inbetween the three lines.
>> 5. Open git-gui and try to stage the changes line by line.
>>
>> The editor will append the warning "No newline at end of file=94 to =
the
>> end of the diff. When you are trying to stage a line an error occurs=
=2E
>> The problem is also illustrated in a question on Stackoverflow [1].
>>
>> Please let me know if you need more information or if I should send
>> this problem to some other mailing list.
>> Thank you, Tobias
>>
>> ____________
>> [1] http://stackoverflow.com/questions/13223868/how-to-stage-line-by=
-line-in-git-gui-although-no-newline-at-end-of-file-warnin
>

--=20
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
