From: Johnny Sheeley <jsheeley@fanatics.com>
Subject: Re: Issue with Orphaned Files After Aborted Rebase
Date: Tue, 8 Sep 2015 18:00:49 +0000
Message-ID: <A76F042CD5DF4D49AA84893E036EB052B9859DC4@JXFQ-EXCH001.footballfanatics.wh>
References: <A76F042CD5DF4D49AA84893E036EB052B9859D93@JXFQ-EXCH001.footballfanatics.wh>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 08 20:01:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZNCS-0006AL-4X
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 20:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbbIHSAx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Sep 2015 14:00:53 -0400
Received: from smtp2.footballfanatics.com ([74.11.145.241]:56141 "EHLO
	smtp2.footballfanatics.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751674AbbIHSAw convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 8 Sep 2015 14:00:52 -0400
Received: from smtp.footballfanatics.com (jxfq-exhb001.footballfanatics.wh [10.143.0.20])
	by smtp2.footballfanatics.com (Postfix) with ESMTP id 1526553C26
	for <git@vger.kernel.org>; Tue,  8 Sep 2015 14:00:51 -0400 (EDT)
Received: from JXFQ-EXCH001.footballfanatics.wh ([fe80::6119:3eef:e35d:3447])
 by JXFQ-EXHB001.footballfanatics.wh ([::1]) with mapi id 14.03.0174.001; Tue,
 8 Sep 2015 14:00:50 -0400
Thread-Topic: Issue with Orphaned Files After Aborted Rebase
Thread-Index: AQHQ6l5EAmHvunMbQkSLp3SbkDGmM54yuY6A
In-Reply-To: <A76F042CD5DF4D49AA84893E036EB052B9859D93@JXFQ-EXCH001.footballfanatics.wh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.143.89.152]
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean
Content-ID: <F5FD5BBD2530204FB56554469E78D545@fanatics.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277509>

I began a rebase, and was unable to add two files that appeared as chan=
ged
(1). When I aborted this rebase, these two files were left in my tree,
showing as changed, and did not respond to checkout =8B(2), reset(3), o=
r
stash(4).

My expectation would be that after a rebase =8Babort, the tree would be
returned to the original state pre-rebase.
My expectation for checkout and reset is that the tree would be returne=
d
to its state based on the last commit.
My expectation for stash is that the files would be stashed and thus
changes would be reverted.

Have I done something wrong/missed something?

=46or reference, feature/RED-599-Bundling was created from feature/fana=
tics.
I=B9ll be keeping this repository in this state in case I can provide a=
ny
additional useful information.

Thanks,
Johnny

(1)
https://gist.github.com/sheeley/537f6562e762b288cef8#file-orphaned-txt-=
L1-L
159
(2)
https://gist.github.com/sheeley/537f6562e762b288cef8#file-orphaned-txt-=
L160
-L186
(3)
https://gist.github.com/sheeley/537f6562e762b288cef8#file-orphaned-txt-=
L187
-L201
(4)
https://gist.github.com/sheeley/537f6562e762b288cef8#file-orphaned-txt-=
L187
-L201

Information contained in this e-mail message is confidential. This e-ma=
il message is intended only for the personal use of the recipient(s) na=
med above. If you are not an intended recipient, do not read, distribut=
e or reproduce this transmission (including any attachments). If you ha=
ve received this email in error, please immediately notify the sender b=
y email reply and delete the original message.
