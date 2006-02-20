From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 2/2] Add 'stg uncommit' command
Date: Mon, 20 Feb 2006 18:30:48 +0100
Message-ID: <20060220173048.GC23501@diana.vm.bytemark.co.uk>
References: <20060217042728.14175.39928.stgit@backpacker.hemma.treskal.com> <20060217043128.14175.60168.stgit@backpacker.hemma.treskal.com> <43F84D9A.2010905@gmail.com> <20060219134558.GA4784@diana.vm.bytemark.co.uk> <20060219144752.GA5541@diana.vm.bytemark.co.uk> <b0943d9e0602200920v10ef8788o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 20 18:31:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBEsF-0006aG-Ia
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 18:31:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161069AbWBTRa5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 20 Feb 2006 12:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161070AbWBTRa4
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 12:30:56 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:37381 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1161069AbWBTRa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 12:30:56 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1FBEs4-0006Xs-00; Mon, 20 Feb 2006 17:30:48 +0000
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0602200920v10ef8788o@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16486>

On 2006-02-20 17:20:47 +0000, Catalin Marinas wrote:

> On 19/02/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > By the way, it seems like my name got munged when you edited the
> > commit.
>
> I fixed the escaping in the name_email* functions (I'll push it
> tonight). It was adding a \ for every character it didn't know. It
> now only escapes the quotes and back-slashes. This is needed when
> passing the strings via the GIT_AUTHOR_* variables.

It put curly braces around the name as well.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
