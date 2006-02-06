From: Sam Vilain <sam@vilain.net>
Subject: Re: Tracking and committing back to Subversion?
Date: Tue, 07 Feb 2006 12:23:43 +1300
Message-ID: <43E7DA7F.6060503@vilain.net>
References: <1138834301.21899.40.camel@wilber.wgtn.cat-it.co.nz> <200602040727.30965.linuxfood@linuxfood.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 00:23:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6Fi9-0004Kd-1v
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 00:23:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWBFXXy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Feb 2006 18:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWBFXXy
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Feb 2006 18:23:54 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:37789 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S932393AbWBFXXx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2006 18:23:53 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id D26342DFB; Tue,  7 Feb 2006 12:23:50 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id F04EB9F2;
	Tue,  7 Feb 2006 12:23:44 +1300 (NZDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Brian Smith <linuxfood@linuxfood.net>
In-Reply-To: <200602040727.30965.linuxfood@linuxfood.net>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15671>

Brian Smith wrote:
>>Has anyone done any work on bidirectional access to SVN repositories?
>>ie, tracking and committing.
> I'm working on something that does just that, I haven't gotten to the 
> bidirectional part just yet. (The only reason I didn't use git-svnimport is 
> that it has a /terrible/ time importing from the KDE svn repo. )

Indeed, mirroring SVN repositories via SVN::Mirror (which is used by
SVK) can take hours for large projects with thousands of commits.

> My take on the properties, though I like your thoughts on how to handle at 
> least svn:ignore, is to basically just let svn deal with them. I will make a 
> couple tools that will modify them, for interface reasons, but they'll just 
> be wrappers around the svn commands themselves.
 > At the moment, the tools are written as bash shell scripts with an
 > interface I'm trying to keep as intuitive as cogito (even though I use
 > the core-git tools now.)

Right; I was looking for an approach that did not require working copies
of the remote subversion repository to be kept locally.  Still, perhaps
that approach has merit, though I would probably start in Perl and use
SVK::Simple (see CPAN) to give a richer SVN mirroring API.

Are you planning on publishing these scripts?

Sam.
