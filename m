From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: Add new option in the right click menu in git gui
Date: Mon, 1 Mar 2010 22:45:10 +0100
Message-ID: <36ca99e91003011345n43aad0c5m5c02eaf692d54efd@mail.gmail.com>
References: <7fce93be1002181511v1c671f82u7f3d7cc6e3512bab@mail.gmail.com>
	 <20100301171222.GA35830@book.hvoigt.net>
	 <1267478971.4400.5.camel@kheops>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git <git@vger.kernel.org>
To: sylvain@abstraction.fr
X-From: git-owner@vger.kernel.org Mon Mar 01 22:45:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmDQX-0008Dh-BZ
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 22:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631Ab0CAVpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 16:45:15 -0500
Received: from mail-bw0-f212.google.com ([209.85.218.212]:64197 "EHLO
	mail-bw0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615Ab0CAVpM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 16:45:12 -0500
Received: by bwz4 with SMTP id 4so2232353bwz.28
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 13:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=P6h2rmr4YzbCinDkv1JluLKja9k9ehpSF/BqzO2p5Wc=;
        b=alB+EOObxL+IPXjip9rBRrVI2Jqlf1yoPRc5lEajxFQHUxQIX7HeyDAIN/EEVTebsd
         8rG2UFUCAUhbeyFPl3YuHPFdpNqrinwkoUTkmFaQR61D6kebo2dfdfc9mPTFNYCXgk1O
         j/jLWGdqQaeePOd+ocbg1rcnmsenSbf1a1cE4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=cmtwYyrv54P7X2zzul7FnC/u9R/uyZXccrGHDTdhCKg6LwMjWTCdC8qTJFSPHeZEln
         vYngTKb3RQG8Z4ukxqTbV64SrvqZWAHzq1iCC7+KT9CIz8L8NBxnorTVF789nz7Ehi9x
         4Gk+k71dj761xgfbbBAhV0+UlECfXfcXvg6lk=
Received: by 10.204.6.70 with SMTP id 6mr3612686bky.6.1267479910549; Mon, 01 
	Mar 2010 13:45:10 -0800 (PST)
In-Reply-To: <1267478971.4400.5.camel@kheops>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141355>

On Mon, Mar 1, 2010 at 22:29, Sylvain Rabot <sylvain@abstraction.fr> wrote:
> On Mon, 2010-03-01 at 18:12 +0100, Heiko Voigt wrote:
>> On Fri, Feb 19, 2010 at 12:11:57AM +0100, Sylvain Rabot wrote:
>> > Hi,
>> >
>> > In case of conflicts it is possible in git gui, through the right
>> > click menu, to use local or remote versions, but, unless I missed
>> > something, it is not possible, after using the merge tool, to add
>> > merged files to the index.
>> >
>> > It would be nice if we could add merged files in the index directly in git gui.
>>
>> I do not see anything missing. After resolving a conflict you usually
>> just need to add the files (in git gui click on the icon of the file).
>> Am I missing something? This is the usual conflict resolution workflow
>> for git, I see no need for an extra menu option.
>>
>> cheers Heiko
>
> Haaaaaaa, I don't know how many times I tried to do a right click on the
> path itself but I never had the idea to click the icon :P

Actually, I would like to be able to have a right click menu for the
path too and have access to the guitool entries in the Tools menu
which require a path (ie. needsfile=true). That would reduce by mouse
movements drastically.

I have looked into this issue by myself, but I'm not that familiar with tcl/tk.

Bert
