From: Markus Heller <hellerm2@gmail.com>
Subject: Re: Run git from .bat file (Windows)
Date: Tue, 20 Jul 2010 11:44:00 -0700
Message-ID: <0vtynungcv.fsf@gmail.com>
References: <0vy6d6nmcc.fsf@gmail.com>
	<AANLkTik-Mk0pMKWHqzMXUcSzPexAQd2bTAPZF9Q2WKer@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 20 20:44:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObHnf-0001Lv-QS
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 20:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171Ab0GTSoO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jul 2010 14:44:14 -0400
Received: from lo.gmane.org ([80.91.229.12]:33214 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752378Ab0GTSoN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 14:44:13 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ObHnY-0001J0-Q4
	for git@vger.kernel.org; Tue, 20 Jul 2010 20:44:12 +0200
Received: from mail.cdrd.ca ([142.103.191.98])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 20:44:12 +0200
Received: from hellerm2 by mail.cdrd.ca with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 20:44:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: mail.cdrd.ca
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (windows-nt)
Cancel-Lock: sha1:8Yfsgo2cLaFRbPOx+AvKO84E01s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151348>

Peter Harris <git@peter.is-a-geek.org> writes:

> On Tue, Jul 20, 2010 at 12:34 PM, Markus Heller wrote:
>> git add .
>> git commit -a -m "Automated commit by org-git-sync.bat on %fvar%"
>
>> The line "git add ." works, as I can see the additions when I type "=
git
>> status" after executing the script. =A0Committing doesn't work, howe=
ver:
>> "git log" shows that no commit was created.
>>
>> Any idea what's going on?
>
> git itself is wrapped by a batch file on Windows. You need to "call" =
it. eg:
>
> call git add .
> call git commit ...

Ah, I wasn't aware of this!!

Thanks for your reply, works as advertised!!

Cheers
Markus
