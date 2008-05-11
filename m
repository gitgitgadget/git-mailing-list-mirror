From: "Steve French" <smfrench@gmail.com>
Subject: Re: CIFS fixes
Date: Sun, 11 May 2008 11:42:00 -0500
Message-ID: <524f69650805110942k7ccb065bm2c1e60f1a509af5a@mail.gmail.com>
References: <524f69650805082054g43823f85i623cb2c11cd01039@mail.gmail.com>
	 <alpine.LFD.1.10.0805090810390.3142@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun May 11 18:43:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvEdU-0000ES-3c
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 18:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbYEKQmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 12:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbYEKQmF
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 12:42:05 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:49621 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbYEKQmD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 12:42:03 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1492290fgg.17
        for <git@vger.kernel.org>; Sun, 11 May 2008 09:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=1l1j+ShXCeKkFIVxODystEY/1/De5at+EY66lAdPpJs=;
        b=Ye7nnUTHn1AS+80/D73rTHHcxjr9UeQMNFfE01jH9LrRo3G3w7G8/RpO7W+ZVYS0iS4i13ea+HLaIMccxZsE3A5Xt1uKTJlN0tAZaiK6420K7a3bUU0v4g1TxqisP4JWPnbVPHe6ccj+ws2r0nm8HYd/NTED0tLBkb6g4O+vOSk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PPFXsE+10g/Zz/JUaKbQ/xDKa+mGkAL8jZSOI1HNYGYB/nlXD9YNb/qznP7BdR0A3TghiDaymMQbQMyI7Stq9s2HgNWozrZkyhzz1j5FSpjrqqYKEFkWECJV6yemod+DgiPkyob/X6JFMep5kz3hsHaYN5yL79wvmqvoHB2BcJI=
Received: by 10.78.182.17 with SMTP id e17mr1700226huf.57.1210524120459;
        Sun, 11 May 2008 09:42:00 -0700 (PDT)
Received: by 10.78.141.1 with HTTP; Sun, 11 May 2008 09:42:00 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0805090810390.3142@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81791>

I am puzzled why I see multiple messages like:

Merge branch 'master' of /.../torvalds/linux-2.6

when using:

git-request-pull origin
git://git.kernel.org/pub/scm/linux/kernel/git/sfrench/cifs-2.6.git

I only pulled once (the initial pull after your previous merge of
cifs-2.6.git tree, but before I added more patches).

On Fri, May 9, 2008 at 10:12 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
>  On Thu, 8 May 2008, Steve French wrote:
>  >
>  > are available in the git repository at:
>  >
>  >   git://git.kernel.org/pub/scm/linux/kernel/git/sfrench/cifs-2.6.git master
>
>  Ugh. Lots of just merging my code back (a third of all the commits were
>  just merges). Were there really conflicts going on that required that? It
>  makes the history harder to read..
>
>  But pulled.
>
>                 Linus
>



-- 
Thanks,

Steve
