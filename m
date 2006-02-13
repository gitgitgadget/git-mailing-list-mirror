From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Handling large files with GIT
Date: Tue, 14 Feb 2006 12:19:23 +1300
Message-ID: <46a038f90602131519l1d281a32o80dbc5621fbf00af@mail.gmail.com>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com>
	 <87slqty2c8.fsf@mid.deneb.enyo.de>
	 <46a038f90602081435x49e53a1cgdc56040a19768adb@mail.gmail.com>
	 <Pine.OSX.4.64.0602131416530.25089@piva.hawaga.org.uk>
	 <Pine.LNX.4.64.0602121939070.3691@g5.osdl.org>
	 <Pine.LNX.4.64.0602122049010.3691@g5.osdl.org>
	 <Pine.LNX.4.64.0602122058260.3691@g5.osdl.org>
	 <43F113A5.2080506@f2s.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>,
	Ben Clifford <benc@hawaga.org.uk>,
	Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 00:19:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8myh-0001FM-9v
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 00:19:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbWBMXT1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 18:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbWBMXT1
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 18:19:27 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:54587 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030258AbWBMXT0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 18:19:26 -0500
Received: by wproxy.gmail.com with SMTP id 69so959139wra
        for <git@vger.kernel.org>; Mon, 13 Feb 2006 15:19:23 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n0vBtiLxOscQyakOdkxAA6KFZOdzU2DKcDqX6lQsVjYqkHc4mZ8W9zfSTDlL14x8fl1P1MlCPeBwl2HT7LJ5EPD0qlYZ7Imc+1In+NX6/SiJ91lJc0d+yB28QTokuT6gYQ5s9KoR6TVLMdggQRx4U7BNSNayY2RqUCmdk3KWsKE=
Received: by 10.54.123.4 with SMTP id v4mr2804367wrc;
        Mon, 13 Feb 2006 15:19:23 -0800 (PST)
Received: by 10.54.71.8 with HTTP; Mon, 13 Feb 2006 15:19:23 -0800 (PST)
To: Ian Molton <spyro@f2s.com>
In-Reply-To: <43F113A5.2080506@f2s.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16086>

On 2/14/06, Ian Molton <spyro@f2s.com> wrote:
> Im curious as to why anyone would want to use a SCM tool on a mail dir
> anyway - surely no-one edits their pasnt mails and needs to keep logs?
>
> surely incremental backups would be a better way to manage something
> like this ?

Well, the maildir arrangement is friendlier to something content-smart
like git than to something content-stupid like a backup tool. Files
inside a maildir change name/location to reflect changes in status,
but their content tends to remain the same.

git does great in this scenario, except for the "dealing with a
bazillion files" part of it.

cheers,


martin
