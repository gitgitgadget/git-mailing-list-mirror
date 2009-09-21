From: Craig Taylor <c@gryning.com>
Subject: Re: install does not obey DESTDIR or --prefix for perl modules
Date: Mon, 21 Sep 2009 20:19:43 +0100
Message-ID: <20090921191943.GE8173@gryning.com>
References: <20090921160551.GD8173@gryning.com> <Ow6bpZou9Vi0tKlyAN-qfjlAAtXvMqpXEAiG54zZ3C8fLI_6_Bt3oA@cipher.nrlssc.navy.mil> <7vskeguqmb.fsf@alter.siamese.dyndns.org>
Reply-To: c@gryning.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 21:20:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpoQe-0003Uk-Gf
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 21:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300AbZIUTTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 15:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753298AbZIUTTx
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 15:19:53 -0400
Received: from 87-194-167-47.bethere.co.uk ([87.194.167.47]:51523 "EHLO
	jolt.ukmail.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbZIUTTx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 15:19:53 -0400
Received: from craigt by jolt.ukmail.org with local (Exim 4.63)
	(envelope-from <c@gryning.com>)
	id 1MpoQJ-0006MQ-TH; Mon, 21 Sep 2009 20:19:43 +0100
Content-Disposition: inline
In-Reply-To: <7vskeguqmb.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128901>

On Mon, Sep 21, 2009 at 10:58:20AM -0700, Junio C Hamano wrote:
> Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil> writes:
> 
> > Craig Taylor wrote:
> >> Hi all
> >> 
> >> I'm compiling/installing git in a Solaris environment without root.
> >> Using 'make DESTDIR=<some path> install' to stage an install to an
> >> alternate location.
> >> The perl module component of 'make DESTDIR=<some path> install' installs
> >> into the system perl lib path without prepending the forced install
> >> destination or my '--prefix'.
> >> This seems counter intuitive and I would consider a bug.
> >
> > Try 'make prefix=<some path>'.
> >
> > btw, this is in the first paragraph of the INSTALL document.
> 
> But is that what Craig is trying to do?
> 
> I think he wants to build git to be installed in /usr/bin/git or whatever,
> and he would say "prefix=/usr".  He however wants "make install" to write
> into /var/tmp/g/usr/bin/git, not /usr/bin/git, so that he can for example
> make a tarball with "cd /var/tmp/g && tar cf ../git.tar .", and extract it
> as root under the real '/'.  "make DESTDIR=/var/tmp/g" is exactly for
> that, and if it is not working I would say it is a bug.

Exactly as you describe here, different paths but same goal.
All binaries follow the DESTDIR path except the perl modules.

To register this as a bug do I need to do more than send this email?

Thanks
CraigT

-- 

c^ [c%5e]

No think. No Talk. Train.
