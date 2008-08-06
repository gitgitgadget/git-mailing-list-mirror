From: "srinivas naga vutukuri" <srinivas.vutukuri@gmail.com>
Subject: Re: git problem: pack has bad object at offset 77100841: inflate returned -3
Date: Wed, 6 Aug 2008 20:34:38 +0530
Message-ID: <ace3f33d0808060804s7df2f58fqb5480af36fecde64@mail.gmail.com>
References: <ace3f33d0808060015t25d9c21epc31e48e3c1d041b1@mail.gmail.com>
	 <20080806143310.GB28231@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 06 17:06:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQka8-0004ji-Kw
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 17:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015AbYHFPEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 11:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753792AbYHFPEl
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 11:04:41 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:36507 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003AbYHFPEk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 11:04:40 -0400
Received: by yx-out-2324.google.com with SMTP id 8so317572yxm.1
        for <git@vger.kernel.org>; Wed, 06 Aug 2008 08:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3Za6mj7p//RMpo3Sq2UJubOpaiMXDMFlSrWiEqsabzA=;
        b=q+aDSbnTLYpiIhfQ/AFMJaGCLyj/bhyUqMzEv2h7fdC5eJ8yRp1uUFC5sW9qCW6KZn
         TjdF4CETrHUnfS5q9XDLVZTj0B7bhufRcoVvWDC8e4V6A+ACD7cDz8AMewMBUGo3ZIiW
         ac+imJSCEebqHiDED8FtLIGe9auNxtmlC+9tc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=NZgNrzXqvb+sz0/tdKA2vi9d7fP3Htrx+jCH8vlkKHeQEnQ5psW2bbJAlJ6KI+K/dn
         e9UR1ZQr9WEks4SBSZyf4vwXN7NP0yfT8gMNidocbsWRKjJcVddgEDzT9Xn57SbAxZC+
         TMaAcOhiZj+nxhB0ukppQZOFWtsuvxVhFVWec=
Received: by 10.151.11.17 with SMTP id o17mr3568846ybi.20.1218035078388;
        Wed, 06 Aug 2008 08:04:38 -0700 (PDT)
Received: by 10.150.145.18 with HTTP; Wed, 6 Aug 2008 08:04:38 -0700 (PDT)
In-Reply-To: <20080806143310.GB28231@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91517>

Hi,

On Wed, Aug 6, 2008 at 8:03 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> srinivas naga vutukuri <srinivas.vutukuri@gmail.com> wrote:
>> remote: Counting objects: 879862, done.
>> remote: Compressing objects: 100% (156686/156686), done.
>> fatal: pack has bad object at offset 77100841: inflate returned -3
>> fatal: index-pack failed
>>
>> while doing "git clone" of linux kernel of latest 2.6.27-rc2.
>> But am able to do the latest stable successfully.
> ...
>> I am using cygwin, git 1.5.6.4
>
> Where are you cloning from?
>
> This is an indication that the data sent to your system from the
> remote side is corrupt.  Possibly a bad network link?
>
> Remote side corruption should have been detected by the remote
> server as it was writing the data out.  The message above however
> came from your client, so the server seems to be OK.
>
> --
> Shawn.
>
I am gone to the site: http://www.kernel.org

from this place
http://git.kernel.org/?p=linux%2Fkernel%2Fgit%2Ftorvalds%2Flinux-2.6.git;a=summary

trying out, for 2.6.27-rc2
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

which is causing the problem,

But, from the place,
http://git.kernel.org/?p=linux%2Fkernel%2Fgit%2Fstable%2Flinux-2.6.26.y.git;a=summary
trying for stable.
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.26.y.git
is working fine...

Could any possible clue from this...

best regards,
srinivas.
