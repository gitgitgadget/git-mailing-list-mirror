From: =?UTF-8?B?SmFudXN6IEJpYcWCb2JyemV3c2tp?= <jbialobr@o2.pl>
Subject: File path not escaped in warning message
Date: Sat, 04 Aug 2012 14:55:17 +0200
Message-ID: <501D1BB5.6020200@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 04 15:03:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sxe0V-00055X-QK
	for gcvg-git-2@plane.gmane.org; Sat, 04 Aug 2012 15:03:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128Ab2HDNC7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Aug 2012 09:02:59 -0400
Received: from moh1-ve1.go2.pl ([193.17.41.131]:42579 "EHLO moh1-ve1.go2.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751895Ab2HDNC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2012 09:02:58 -0400
X-Greylist: delayed 446 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Aug 2012 09:02:58 EDT
Received: from moh1-ve1.go2.pl (unknown [10.0.0.131])
	by moh1-ve1.go2.pl (Postfix) with ESMTP id 55AB392884F
	for <git@vger.kernel.org>; Sat,  4 Aug 2012 14:55:26 +0200 (CEST)
Received: from unknown (unknown [10.0.0.108])
	by moh1-ve1.go2.pl (Postfix) with SMTP
	for <git@vger.kernel.org>; Sat,  4 Aug 2012 14:55:26 +0200 (CEST)
Received: from 89-69-97-238.dynamic.chello.pl [89.69.97.238]
	by poczta.o2.pl with ESMTP id GWGUQd;
	Sat, 04 Aug 2012 14:55:26 +0200
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
X-O2-Trust: 2, 62
X-O2-SPF: neutral
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202878>

Hi,

I have enabled core.quotepath, but file path in warning isn't escaped:
=46ile name is 1=C4=85.txt its content is encoded in windows-1250
Output of git diff after reencoding to windows1250 is:

warning: LF will be replaced by CRLF in 1=C3=84=E2=80=A6.txt.
The file will have its original line endings in your working directory.

But I expected it to be:

warning: LF will be replaced by CRLF in 1\304\205.txt.
The file will have its original line endings in your working directory.

Best regards,
Janusz Bia=C5=82obrzewski.
