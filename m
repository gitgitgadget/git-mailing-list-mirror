From: David Kastrup <dak@gnu.org>
Subject: Re: Git and OpenDocument (OpenOffice.org) files
Date: Mon, 27 Aug 2007 17:05:57 +0200
Message-ID: <86bqctqap6.fsf@lola.quinscape.zz>
References: <vpqk5rh5mp5.fsf@bauges.imag.fr> <7vps19jnm1.fsf@gitster.siamese.dyndns.org> <vpqtzql17gd.fsf@bauges.imag.fr> <20070827130346.GA8821@glandium.org> <Pine.LNX.4.64.0708271440500.28586@racer.site> <866431rser.fsf@lola.quinscape.zz>  =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?200708271416=0400.?= =?ISO-8859-1?Q?GA11000@glandium?=
	=?ISO-8859-1?Q?.org>?=
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 27 17:06:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPgAb-0007Tj-Ad
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 17:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630AbXH0PGU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 11:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752227AbXH0PGU
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 11:06:20 -0400
Received: from main.gmane.org ([80.91.229.2]:40386 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751243AbXH0PGT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 11:06:19 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IPgAJ-0002Mu-Vf
	for git@vger.kernel.org; Mon, 27 Aug 2007 17:06:08 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 17:06:07 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 17:06:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:3oXvGYaDUpx8OShqeOfApXT/YpY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56845>

Mike Hommey <mh@glandium.org> writes:

> On Mon, Aug 27, 2007 at 03:58:04PM +0200, David Kastrup <dak@gnu.org> wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > On Mon, 27 Aug 2007, Mike Hommey wrote:
>> >
>> >> BTW, wouldn't it be more efficient to store the odf files unzipped ?
>> >
>> > Efficient how?  Speed-wise: no.  Space-wise: yes.
>> 
>> Huh?  At least the "Space-wise: yes" seems rather nonsensical.
>
> A zipped file will be 100% different at each revision.
> The unzipped counterpart may be similar for 90% or more between revisions.

Ah, right.

This applies however to gzipped files or single-file zip files, and
not zipped files in general: a zip file compresses each file
individually, so unchanged single files inside of the zip will deltify
reasonably well, as opposed to unchanged single files in a .tar.gz
file.

But that's a minor point not relevant here, and of course you are
right.  I just somehow did not register that "store the odf files" was
supposed to mean "get checked into git in numerous versions".

-- 
David Kastrup
