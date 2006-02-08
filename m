From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Handling large files with GIT
Date: Thu, 9 Feb 2006 11:35:36 +1300
Message-ID: <46a038f90602081435x49e53a1cgdc56040a19768adb@mail.gmail.com>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com>
	 <87slqty2c8.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 08 23:36:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6xuX-0000FX-HE
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 23:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965214AbWBHWfi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 17:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965213AbWBHWfi
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 17:35:38 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:40672 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965214AbWBHWfh convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Feb 2006 17:35:37 -0500
Received: by wproxy.gmail.com with SMTP id i22so1617253wra
        for <git@vger.kernel.org>; Wed, 08 Feb 2006 14:35:36 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NzFUVoOGyVNweVlPZTWUUJVn7cOtMgJSSm5CeieB7NS4KGRcGH4nUVGv+j4PQ4tjL0QjzEyVsSyhlcMw60/M7RhkWic9t1VM9hGZkaWsFy4rzH6+hMUonC2jiNV/fr9ntoS/sgw5hVgFU/o/6L7h7U7eapCHI+zUld3IAZiNxGQ=
Received: by 10.54.72.17 with SMTP id u17mr53282wra;
        Wed, 08 Feb 2006 14:35:36 -0800 (PST)
Received: by 10.54.71.8 with HTTP; Wed, 8 Feb 2006 14:35:36 -0800 (PST)
To: Florian Weimer <fw@deneb.enyo.de>
In-Reply-To: <87slqty2c8.fsf@mid.deneb.enyo.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15757>

On 2/9/06, Florian Weimer <fw@deneb.enyo.de> wrote:
> In your mbox case, you should simply try Maildir.  The tree object
> (which lists all files in the Maildir folder) will still be rather
> large (about 40 to 50 bytes per message stored), though.

I did suggest maildir,  where GIT is bound to do well as the content
of the emails doesn't change but they just move around a lot. Though
yes, trees are going to be nasty.

But the interesting case I gues is the general one of large files
changing slowly. My guess is that supporting delta transfers in the
git protocol would make it a lot more manageable. For local storage
git isn't so bad, and the problem is perhaps harder to resolve.

cheers,


martin
