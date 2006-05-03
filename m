From: "Josh Boyer" <jwboyer@gmail.com>
Subject: Re: git-unpack-objects
Date: Wed, 3 May 2006 12:44:18 -0500
Message-ID: <625fc13d0605031044y2ff03ed2h261db5455b234254@mail.gmail.com>
References: <625fc13d0605011552j4189338bx14083657acffc18e@mail.gmail.com>
	 <7vu089qr4t.fsf@assigned-by-dhcp.cox.net>
	 <625fc13d0605031035l721ab08dmee6f870abb49f4e4@mail.gmail.com>
	 <Pine.LNX.4.64.0605031041150.4086@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 19:44:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbLOg-0007D1-VC
	for gcvg-git@gmane.org; Wed, 03 May 2006 19:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbWECRoU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 13:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbWECRoU
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 13:44:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:60551 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030268AbWECRoT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 13:44:19 -0400
Received: by ug-out-1314.google.com with SMTP id m3so139533ugc
        for <git@vger.kernel.org>; Wed, 03 May 2006 10:44:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T51KhQT2jcBqKx7WpkDiNUNkbzRjhEgQeD3ooRsBMNA6vTpR506mtGkWzTGn/hW3Ij3v8Z0y7HEneC6SbPuvzu/xDL+rfNS1d+ZJd5xb3WqlPbCsocCzzpy0tPI79yDBqHA46FM7AP5pd5w0bEDalOsmroJ+Fut1fy3lRJvJSY8=
Received: by 10.78.57.11 with SMTP id f11mr5377hua;
        Wed, 03 May 2006 10:44:18 -0700 (PDT)
Received: by 10.78.29.19 with HTTP; Wed, 3 May 2006 10:44:18 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605031041150.4086@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19507>

On 5/3/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Wed, 3 May 2006, Josh Boyer wrote:
> >
> > Hm..  so it seems that git-unpack-objects is more intended to unpack a
> > pack one has gotten with git-fetch-pack, right?
>
> Yeah. And for testing. I don't think it ever gets used directly.
>
> > I was looking for something more along the lines of an
> > "un-git-repack", where you have existing pack(s) and want to undo
> > them.  Maybe you want to repack everything into a single pack or
> > something like that.
>
> That's what you just do "git repack -a -d" for.

But that doesn't roll exsisting packs into a new pack, does it?  I
thought it just packed loose objects into a new pack and deleted them.
 I ran that on a repo that already had a couple packs in it, and the
old packs were still there.

josh
