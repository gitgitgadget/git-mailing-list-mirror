From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: Git completion not using ls-remote to auto-complete during push
Date: Thu, 18 Jun 2015 09:03:10 +0200
Message-ID: <55826D2E.2060308@atlas-elektronik.com>
References: <CAHd499Dk44Fq5c_wadxT_kuCs5BdkRwKZWOHyAgE4oi7pezxPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 18 09:03:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5TrO-0000Fh-GW
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 09:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289AbbFRHDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 03:03:24 -0400
Received: from mail96.atlas.de ([194.156.172.86]:14780 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752810AbbFRHDX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 03:03:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id CE7314A004;
	Thu, 18 Jun 2015 09:03:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qJclP6LAbODm; Thu, 18 Jun 2015 09:03:11 +0200 (CEST)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Thu, 18 Jun 2015 09:03:11 +0200 (CEST)
Received: from MSSRVS1.atlas.de (mssrvs1.atlas.de [10.200.101.71])
	by mgsrv01.atlas.de (Postfix) with ESMTP id E94C227169;
	Thu, 18 Jun 2015 09:03:10 +0200 (CEST)
Received: from [10.200.54.122] (10.200.54.122) by MSSRVS1.atlas.de
 (10.200.101.71) with Microsoft SMTP Server id 8.3.327.1; Thu, 18 Jun 2015
 09:03:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <CAHd499Dk44Fq5c_wadxT_kuCs5BdkRwKZWOHyAgE4oi7pezxPw@mail.gmail.com>
OpenPGP: id=2DF5E01B09C37501BCA99666829B49C5922127AF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271936>

Am 17.06.2015 um 18:10 schrieb Robert Dailey:
> I do the following:
> 
> $ git push origin :topic
> 
> If I stop halfway through typing 'topic' and hit TAB, auto-completion
> does not work if I do not have a local branch by that name (sometimes
> I delete my local branch first, then I push to delete it remotely). I
> thought that git completion code was supposed to use ls-remote to auto
> complete refs used in push operations. Is this supposed to work?
> 
> I'm using Git 2.4.3. Tested on both MSYS2 in Windows and Linux Mint.
> Same behavior in both. I am using the latest git completion code from
> the master branch in the git repo.

Same here!

But it works in my self-compiled version of msysgit (yes, the old
'Git for Windows' development environment) which is rebased onto v2.2.2.
Time for 'git bisect' I guess...

Stefan
-- 
----------------------------------------------------------------
/dev/random says: A cat sleeps fat, yet walks thin.
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.decode('hex')" 
GPG Key fingerprint = 2DF5 E01B 09C3 7501 BCA9  9666 829B 49C5 9221 27AF
