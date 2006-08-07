From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: fast-import and unique objects.
Date: Mon, 7 Aug 2006 14:45:56 -0400
Message-ID: <9e4733910608071145i6cbfa9b2ub8ed52020614d9e7@mail.gmail.com>
References: <9e4733910608060532w51fca2c0r8038828df0d41eeb@mail.gmail.com>
	 <9e4733910608060853ua0eabc1w9b35b8414d3c9bae@mail.gmail.com>
	 <20060806180323.GA19120@spearce.org>
	 <9e4733910608062148u4341dabag451c3f49f1a792a1@mail.gmail.com>
	 <20060807050422.GD20514@spearce.org>
	 <9e4733910608070737k52aaea7clf871d716d16547c2@mail.gmail.com>
	 <eb7jr2$4ar$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 07 20:47:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAA7a-0003tn-8R
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 20:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWHGSqL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 14:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWHGSqL
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 14:46:11 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:49730 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932305AbWHGSqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 14:46:09 -0400
Received: by nf-out-0910.google.com with SMTP id p46so549442nfa
        for <git@vger.kernel.org>; Mon, 07 Aug 2006 11:45:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ewn24cK72FvHEFkLWV/Hi76i25p0BuuzdvMPsrE7vQhVaY355cIfdSXlunz5U/Afj8uKjPEIzk/3UHb5E0zrWd46w0DK5VG2qQx34DqdYIsOWKuSuNBZCqo/cP72X787fgEYToc2SZDY1NsCJdX6bVRoTZ27FwTEEYQQ6e84FzM=
Received: by 10.78.140.17 with SMTP id n17mr2490937hud;
        Mon, 07 Aug 2006 11:45:56 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Mon, 7 Aug 2006 11:45:56 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <eb7jr2$4ar$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25027>

On 8/7/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Jon Smirl wrote:
>
> > How about sending out a stream of add/change/delete operations
> > interspersed with commits? That would let fast-import track the tree
> > and only generate tree nodes when they change.
>
> The problem with CVS, which cvsps (CVS PatchSet) tries to address is that
> changes are to a file, and reconstructing which changes go together to make
> _one_ commit...

The cvs2svn code is also gathering CVS commits into change sets. The
advantage of the cvs2svn code is that it is written by some of the
original CVS developers. Those developers are familiar with the 1,000
different ways to break a CVS repository and cvs2svn tries to deal
with the breakage.

cvsps works for some repositories but it fails on the Mozilla one.
There is something about branches in the Mozilla repository that
confuses it. cvs2svn handles the Mozilla repository correctly as far
as I can tell.

-- 
Jon Smirl
jonsmirl@gmail.com
