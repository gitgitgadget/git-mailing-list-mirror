From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: Remote git-describe ?
Date: Wed, 24 Jan 2007 13:50:56 +0100
Message-ID: <38b2ab8a0701240450s614df3bevf95e62add1b1783f@mail.gmail.com>
References: <38b2ab8a0701240231v5ec4acfasd838ececb316500d@mail.gmail.com>
	 <Pine.LNX.4.63.0701241201410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <38b2ab8a0701240313w64c2df57w2542b63eba2294e0@mail.gmail.com>
	 <7vps94fweq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jan 24 13:51:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9haj-0002GQ-Ft
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 13:51:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbXAXMu6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 07:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbXAXMu6
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 07:50:58 -0500
Received: from hu-out-0506.google.com ([72.14.214.225]:11912 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbXAXMu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 07:50:58 -0500
Received: by hu-out-0506.google.com with SMTP id 36so145714hui
        for <git@vger.kernel.org>; Wed, 24 Jan 2007 04:50:56 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GkIxbmqShKwYvIPXf4nQhxwoQSlLwX9yBrWZSmdqz1OPEXSc5tiKZ5LZV+sKGod9Z3VpFtQibI9RxyFEzGebGpIbiiUt7S/L1H6K76n/HDZXMbMhMxREd4ce5s4WZueOxIXfAh5sE7Jn+Ql1HuAA8jTjogiiiAzz+XqnkYCwsZ0=
Received: by 10.49.57.1 with SMTP id j1mr2791457nfk.1169643056176;
        Wed, 24 Jan 2007 04:50:56 -0800 (PST)
Received: by 10.49.30.4 with HTTP; Wed, 24 Jan 2007 04:50:55 -0800 (PST)
In-Reply-To: <7vps94fweq.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37634>

Junio C Hamano wrote:
> "Francis Moreau" <francis.moro@gmail.com> writes:
>
>> ... Givinig that I would use it to describe the HEAD of the kernel repo:
>>
>>        $ git describe --remote=<git-server> HEAD
>>
>> this would make the server parse all commits between HEAD and the
>> closest tag which seems to me a lot cheaper than downloading the whole
>> repo...
>
> Do you mean you want to have the server describe the HEAD the
> server side has (not the HEAD in your repository)?  Why?
>

yes. see below...

> I suspect the real motivation of your question lies elsewhere
> and not in "describe".
>
> Suppose we had such a service on the server side, and you asked
> the server twice and got these (at different times, of course):
>
> 	v2.6.20-rc5-g419dd83
> 	v2.6.20-rc5-gde14569
>
> What useful information can you get between the two?
>
> Nothing.
>

I agree in the context I gave, it's useless.

>
> So I suspect what you are after is not about using describe
> remotely or describing where the HEAD is; you want to know if
> there is a new tag near the tip since the last time you checked.
>

Actually I'd like to generate an archive from a git server. And
I want to give the name of the archive file, the ouptut given by
'git describe'.

Since I can pass --remote to 'git archive', I do not need anymore
to clone the repo before generating the archive. But I still needs
it only to run 'git describe' thus my question...

thanks
-- 
Francis
