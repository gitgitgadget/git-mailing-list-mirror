From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 23 Jan 2008 14:27:55 +1300
Message-ID: <46a038f90801221727t188b33a9t86ddd2747473b274@mail.gmail.com>
References: <alpine.LFD.1.00.0!801211407130.2957@woody.linux-foundation.org>
	 <alpine.LFD.1.00.0801211656130.2957@woody.linux-foundation.org>
	 <alpine.LFD.1.00.0801211702050.2957@woody.linux-foundati!on.org>
	 <34103945-2078-4983-B409-2D01EF071A8B@sb.org>
	 <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org>
	 <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org>
	 <20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu>
	 <alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org>
	 <98315FA6-CFEF-4BB1-997B-0B10BDBBE37B@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Theodore Tso" <tytso@mit.edu>, git@vger.kernel.org
To: "Kevin Ballard" <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 02:28:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHUPk-00026o-M6
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 02:28:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbYAWB16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 20:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751752AbYAWB15
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 20:27:57 -0500
Received: from hu-out-0506.google.com ([72.14.214.235]:2438 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbYAWB15 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 20:27:57 -0500
Received: by hu-out-0506.google.com with SMTP id 19so1122588hue.21
        for <git@vger.kernel.org>; Tue, 22 Jan 2008 17:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=v+tY70RWlvPIMwokwLVofQVREHf79QhcXxBPDEomdzY=;
        b=sA0TBNUMTEB2/xcPwqHr+5OsYHYHawKzNcb2gnBS3zYyLJMTdPKhvOfT8OEfsWcY5hqYORP7ewGSRMY94wUFPYQKI3NAS8rsrafMMKAFtob8VI9pGFORFmxQ1ZpAPXptzQgK71t7P3KszX4cXrOnKHdAVyEBI58lou/WSBWNRBs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c9MnzQQx1/O4nkF1Ar5xjSvveEcL/nK3B0grhN0L4BHHq+kw5hIfetaZsGpa8gzX+8xL9mFT603Nh3QJ67FMa7B6TMkiWeeHU7v0ZFytvTJ9gYDdp+m+fn5fJ+SdvbFFN63q8t7KBuo+gpLjOkwHCqgKcwg/srOW13bVqTkX9qU=
Received: by 10.66.233.14 with SMTP id f14mr266258ugh.84.1201051675361;
        Tue, 22 Jan 2008 17:27:55 -0800 (PST)
Received: by 10.66.252.2 with HTTP; Tue, 22 Jan 2008 17:27:55 -0800 (PST)
In-Reply-To: <98315FA6-CFEF-4BB1-997B-0B10BDBBE37B@sb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71485>

On Jan 23, 2008 2:16 PM, Kevin Ballard <kevin@sb.org> wrote:
> > If I connect
> > to a MacOS X server exporting an HFS file system, I can
> > "touch FOO" and then "rm foo" and the rm will work.

So this bit of insanity can affect users on other OSs too, if they use
git on an NFS mountpoint hosted on OSX/HFS+.

IIRC Apple does recommend UFS for servers though. I wonder how XServe
machines ship by default.



m
