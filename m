From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [ANNOUNCE] qgit4 aka qgit ported to Windows
Date: Thu, 11 Jan 2007 13:19:56 +0100
Message-ID: <e5bfff550701110419v3508e9d5gbc206b7d0fa320ae@mail.gmail.com>
References: <e5bfff550701091314k71e282e8x125db65d5c287a94@mail.gmail.com>
	 <46a038f90701101517s1d5e818eq2fba220d17a6aa03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "GIT list" <git@vger.kernel.org>, "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Jan 11 13:20:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4yuW-0007zl-TR
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 13:20:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbXAKMT6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 07:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbXAKMT6
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 07:19:58 -0500
Received: from wr-out-0506.google.com ([64.233.184.231]:3619 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030305AbXAKMT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 07:19:57 -0500
Received: by wr-out-0506.google.com with SMTP id i30so308458wra
        for <git@vger.kernel.org>; Thu, 11 Jan 2007 04:19:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Omv1coTAb2NIBhffK17C0XiC+SSihH+r8ETHta3cU+H+jiVceaIYlmYxnnPrMsHMtWfXGxsYDKyYJgOSQevpnTohpCdspLWoWzdgZbEnK3FXyeryfG3YZ8WzWPoA4Xj08GxAHbcWigfnBLD/yZ+gHppvkg+9Aqrq74wOIxnak9o=
Received: by 10.35.110.13 with SMTP id n13mr2459776pym.1168517996935;
        Thu, 11 Jan 2007 04:19:56 -0800 (PST)
Received: by 10.35.42.4 with HTTP; Thu, 11 Jan 2007 04:19:56 -0800 (PST)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90701101517s1d5e818eq2fba220d17a6aa03@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36584>

On 1/11/07, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On 1/10/07, Marco Costalba <mcostalba@gmail.com> wrote:
> > 6) Start qgit.exe
> > 7) Have fun
>
> Great!
>
> How much does qgit4 depend on using commandline git? IOWs, how far
> from not needing cygwin+git, and shipping a git+qgit compiled against
> the MinGW that QT4 has?
>

qgit4 does not depends on  commandline git environment at all. You can
start qgit4 also without a git installation, also without a cygwin
installation either. Of course it's not useful in that cases.

I had no time to fix some rogh edges regarding launching qgit4 with
proper paths set. What I plan to do this week end is to find an 'easy
to use recipe' to start qgit4 from cmd.exe, from desktop icon and also
from cygwin shell.

I need to experiment a little bit with this but I would like to add
internal automatic recognizing of environment at least for cmd.exe vs
cygwin shell launching case so to let user have a nice experience in
both cases.

  Marco
