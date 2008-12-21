From: "Mark Ryden" <markryde@gmail.com>
Subject: Re: Applying patches from a patch set
Date: Sun, 21 Dec 2008 20:34:35 +0200
Message-ID: <dac45060812211034w38691627scf2a36ed814353f9@mail.gmail.com>
References: <dac45060812200637m49c71aa5x3c25010fa00f4a63@mail.gmail.com>
	 <slrngkrv22.knd.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Sitaram Chamarty" <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 19:37:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LETAi-0005M8-JB
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 19:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbYLUSei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 13:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbYLUSei
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 13:34:38 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:52603 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbYLUSeh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 13:34:37 -0500
Received: by yx-out-2324.google.com with SMTP id 8so615911yxm.1
        for <git@vger.kernel.org>; Sun, 21 Dec 2008 10:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=mWV6tTCt/YMZa65NWeGMWfjaBjlCFJmz3wgrTBTSoT8=;
        b=W8ugiOD8vhoxkAv5RMb8K8dZR8i3Se8YmnWzo/LGL72rGu8VmF6rMQ9usfbES/Iag4
         K+W+rrsR/TXKH51ggAShKF7ucD7GsrjPIiaN3K0iWvR1X1Fmif48CD6clRyNOQg6xjCq
         doHNjv47CBXu6WwolnZVaEfsZ0eEt3+zgI6dk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=EPWCj3qkq+hu16+0dxatfSNFFlZ7Zpy3NDMXQMY9SWC+UB4rytxHpnHmqFnhYRQG0R
         rPSoX6XOrqR3wEftpLQYPSwsZogUcZ0xxhtp/A2mv6J1CwSK0ruWDFLa6KjMaJ//VWIE
         OTpZioCCsIPm/gqMOvj2/IUKtDYbutHC4rWZQ=
Received: by 10.90.90.4 with SMTP id n4mr2857479agb.103.1229884475801;
        Sun, 21 Dec 2008 10:34:35 -0800 (PST)
Received: by 10.90.26.11 with HTTP; Sun, 21 Dec 2008 10:34:35 -0800 (PST)
In-Reply-To: <slrngkrv22.knd.sitaramc@sitaramc.homelinux.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103705>

Hello,
  Thanks a lot for your answer ! I was not aware of the option using a
newsreader like slrn to access the list via gmane.

The list I want to work with **does** have a gmane interface.
It is :
http://thread.gmane.org/gmane.linux.kernel.wireless.general

However, after I tried:
setenv NNTPSERVER gmane.linux.kernel.wireless.general
and
slrn -f /root/.jnewsrc --create
I got:
slrn 0.9.8.1pl2 [2005-02-17]

Reading startup file /etc/slrn.rc.
Using newsrc file /root/.jnewsrc for server gmane.linux.kernel.wireless.general.
Connecting to host gmane.linux.kernel.wireless.general ...
Failed to resolve gmane.linux.kernel.wireless.general

Run-Time Error
slrn fatal error:
Failed to initialize server.


I assume that this is some silly mistake I had done,.Any ideas?

Rgs,
Mark




On Sun, Dec 21, 2008 at 10:20 AM, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> On 2008-12-20, Mark Ryden <markryde@gmail.com> wrote:
>
>>   I am subscribed to some linux kernel subsystem mailing list; in this
>> list there are sometimes patchsets with more than
>> 30-40 patches.
>> I am using gmail web interface client.
>
> solution 1: see if that list is mirrored by gmane and use a
> newsreader like slrn to access the list via gmane
>
> solution 2: enable pop/imap access on your gmail account and
> pull emails from there using whatever command line mail
> client you like (like mutt maybe).  Not tested, but should
> work.  For some definition of "work" (not sure how gmail's
> "tags" map to imap folders, which might trip you...)
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
