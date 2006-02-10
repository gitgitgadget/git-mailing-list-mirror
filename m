From: Sam Vilain <sam@vilain.net>
Subject: Re: Tracking and committing back to Subversion?
Date: Fri, 10 Feb 2006 17:27:26 +1300
Message-ID: <43EC162E.9090905@vilain.net>
References: <1138834301.21899.40.camel@wilber.wgtn.cat-it.co.nz> <200602040727.30965.linuxfood@linuxfood.net> <43E7DA7F.6060503@vilain.net> <200602091650.55370.linuxfood@linuxfood.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 05:27:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7Psp-0007Gz-O5
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 05:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWBJE1p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 23:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWBJE1p
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 23:27:45 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:23198 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1751071AbWBJE1o (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2006 23:27:44 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id B72541865; Fri, 10 Feb 2006 17:27:41 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id C048B3D10;
	Fri, 10 Feb 2006 17:27:34 +1300 (NZDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Brian Smith <linuxfood@linuxfood.net>
In-Reply-To: <200602091650.55370.linuxfood@linuxfood.net>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15863>

Brian Smith wrote:
>>Right; I was looking for an approach that did not require working copies
>>of the remote subversion repository to be kept locally.  Still, perhaps
>>that approach has merit, though I would probably start in Perl and use
>>SVK::Simple (see CPAN) to give a richer SVN mirroring API.
> While that is an admirable goal, unless you can point me to something that
> will allow you to actually commit back to SVN without a working copy,

Such as SVK

   http://svk.elixus.org/
   (svn url: http://svn.openfoundry.org/svk/)

> it 
> defeats the purpose of my tools which is basically to use to git for the 
> purpose of holding intermediate development before sending it into SVN as a 
> final commit. That, and being able to use git tools which speak to me on a 
> level far greater than SVN tools. ;)

Your solution may ultimately be the most pragmatic approach.  Issues 
surrounding the C (SWIG) bindings between Perl and the Subversion RA
(remote access) API were "the hard part" in making SVK work, according
to the lead author.

That being said, I am unaware of any drastic outstanding issues, so
perhaps there are useful components there.

> Sure, you can actually pick up the current development straight from
> git://linuxfood.net/pub/git/kosek.git

I will take a look.

Sam.
