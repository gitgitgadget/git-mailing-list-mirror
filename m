From: Panagiotis Issaris <takis@lumumba.uhasselt.be>
Subject: Re: Problem using GIT CVS-server
Date: Wed, 03 May 2006 13:41:27 +0200
Message-ID: <445896E7.1070306@lumumba.uhasselt.be>
References: <445865A5.5030700@lumumba.uhasselt.be> <46a038f90605030311s4e05de2dr90277f97a3a5c223@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 13:41:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbFjX-0000fk-Ve
	for gcvg-git@gmane.org; Wed, 03 May 2006 13:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965156AbWECLl3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 07:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbWECLl3
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 07:41:29 -0400
Received: from alpha.uhasselt.be ([193.190.2.30]:48365 "EHLO alpha.uhasselt.be")
	by vger.kernel.org with ESMTP id S965156AbWECLl2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 07:41:28 -0400
Received: from localhost (datastorage.uhasselt.be [193.190.2.17])
	by alpha.uhasselt.be (Postfix) with ESMTP id C4B6E1AB171;
	Wed,  3 May 2006 13:41:27 +0200 (CEST)
X-Virus-Scanned: by Amavisd antivirus & antispam cluster at uhasselt.be
Received: from [172.18.16.239] (edm-006.edm.uhasselt.be [193.190.10.6])
	by alpha.uhasselt.be (Postfix) with ESMTP id 043741AB137;
	Wed,  3 May 2006 13:41:27 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605030311s4e05de2dr90277f97a3a5c223@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19472>

Hi,

Martin Langhoff wrote:

> [...]
> thanks a lot for the feedback! cvsserver has mainly been
> tried/debugged with a few repositories, mainly the moodle.git
> repository that we host, which is an import from a CVS repo.

I didnt even know it existed! :) I was looking for an Eclipse plugin
(anyone heard anything about such a beast after 20060313?), when
I accidently stumbled upon the git-cvsserver manpage, somewhere
on the web.

> [...]
> That warning is harmless, and always there. I did look once at
> implementing gzip compression, but in some cases it implies creating
> extra temp files to calculate the size, so I've opted to leave it for
> some other day.
>
> OTOH, we could declare that we handle it, and never actually send a
> gzipped file ;-) as long as we can handle gzipped content from the
> client.

Not really an issue imho :) I just automatically type -z3 whenever I do
a CVS update :)

BTW, thanks for writing git-cvsserver!

With friendly regards,
Takis
