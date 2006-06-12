From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: svn to git, N-squared?
Date: Mon, 12 Jun 2006 14:06:00 -0400
Message-ID: <9e4733910606121106ta925b6er49fe68bf3c1031f5@mail.gmail.com>
References: <20060612043949.20992.qmail@science.horizon.com>
	 <9e4733910606120832xaf74e77pad7f70df864541fc@mail.gmail.com>
	 <Pine.LNX.4.64.0606120843340.5498@g5.osdl.org>
	 <9e4733910606120855p1cec9acfy62dadb89c11756b4@mail.gmail.com>
	 <Pine.LNX.4.64.0606120906210.5498@g5.osdl.org>
	 <9e4733910606120922g181a5aaal623fd3f29b839f4c@mail.gmail.com>
	 <Pine.LNX.4.64.0606120938490.5498@g5.osdl.org>
	 <9e4733910606120944p4deb170ejc2863846685917f6@mail.gmail.com>
	 <Pine.LNX.4.64.0606120958230.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux@horizon.com" <linux@horizon.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 20:06:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fpqnq-000357-0y
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 20:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWFLSGE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 14:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbWFLSGD
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 14:06:03 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:14876 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750802AbWFLSGB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 14:06:01 -0400
Received: by nz-out-0102.google.com with SMTP id m7so823027nzf
        for <git@vger.kernel.org>; Mon, 12 Jun 2006 11:06:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IxlrB4i5wqwgAeBHmKRgnZTH5bntFFdvd+L+oPij05steSzahuWgtahu1cL6aiiF9QZ4pnkVmj4HyxpnRFe1b1/GrnETOyhcpClUXSnIy/mrmjNaKpxyhoRIh+iNIYT0tV+t2AATW/7yeBhmRlPdGiSXnaC79pvGFjD1aw4D+ac=
Received: by 10.36.215.18 with SMTP id n18mr9169325nzg;
        Mon, 12 Jun 2006 11:06:00 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Mon, 12 Jun 2006 11:06:00 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606120958230.5498@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21720>

On 6/12/06, Linus Torvalds <torvalds@osdl.org> wrote:
> Having that many files in a single directory (or two) is a total disaster.
> That said, it works well enough if you don't create new files very often
> (and _preferably_ don't look them up either, although that is effectively
> helped by indexing). I _suspect_ that

Posted to the svn list, they said that 220K files is normal. They told
me to turn on the ext2 dir_index option. Cheking my system I see that
none of partitions have it turned on so it must not be the default for
FC5.

I have to unmount the drive to convert existing directories. I can
trying doing the file move trick while the process is running since
new directories will use it.

-- 
Jon Smirl
jonsmirl@gmail.com
