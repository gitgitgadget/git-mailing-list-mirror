From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Fri, 23 Apr 2010 02:44:33 -0700
Message-ID: <7vsk6mzeny.fsf@alter.siamese.dyndns.org>
References: <201004150630.44300.chriscool@tuxfamily.org>
 <201004191243.24209.jnareb@gmail.com> <20100419115113.GC3563@machine.or.cz>
 <201004202014.19477.jnareb@gmail.com>
 <k2le72faaa81004211349o1628ed42s4fa0aa412006128@mail.gmail.com>
 <20100422202501.GJ10939@machine.or.cz>
 <7vwrvz2npn.fsf@alter.siamese.dyndns.org>
 <20100423071014.GL3563@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, Sam Vilain <sam@vilain.net>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Apr 23 11:45:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5FRY-00015w-Ov
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 11:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756878Ab0DWJo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 05:44:59 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36292 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756869Ab0DWJo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 05:44:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BA58EAD5ED;
	Fri, 23 Apr 2010 05:44:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UHNrcJ6Bm4dVpevAW6huWikLwxk=; b=a1WteA
	LI1FEjia4EYO8NHhB/ctFIp1YmCDloU+83bE+KZaN8VlX1Yk8ZwnBmia8u3G2Zb2
	+KcwBMbqdM7ENMU27q8VNS8MRKurPFY/irp23cEF1B1NyirBLvxRZdvPhBuHaXNS
	XD/C9WYFR3Betr3gALVKAsYwRYNjeVqP4Ddqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fsTvGQTNiy1CrUrOWG3uF6lb9352aXfz
	xWCCRIdk9wQ5WHRx5VmAtT1f/R2GPW0xUnCu5eOsJDHdf0Res8zCA/uBEVC1EBKH
	B3ys501IS+FcXFLwrst5Y2BCv3O+FHz1iK+V/Oo5qrvd4+Uffq/J1ZYgKb/Dnf0X
	494K4rC56do=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 14F2CAD5E9;
	Fri, 23 Apr 2010 05:44:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 39B4EAD5E8; Fri, 23 Apr
 2010 05:44:35 -0400 (EDT)
In-Reply-To: <20100423071014.GL3563@machine.or.cz> (Petr Baudis's message of
 "Fri\, 23 Apr 2010 09\:10\:14 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D9DE5042-4EBC-11DF-9E2C-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145607>

Petr Baudis <pasky@suse.cz> writes:

>   The original idea was to just have a git-gui replacement that runs
> within your browser, and that's what is getting implemented I think.

Ok.

>   I think WebDAV API would be very fine to have *in addition* to
> user-friendly web interface, but is useful in very different scenarios.
> You need something to frontend WebDAV anyway.

There are different "useful" projects that can happen in this area:

 - a project to create a general front-end to versioned WebDAV; or

 - a project to serve git repository to such front-end implementations; or

 - a project to build an ad-hoc "git only" system.

The first one doesn't have to be within the purview of the "git" project
per-se, and it can presumably work against anybody's versioned WebDAV
server implementation (e.g. RFC 3253).

The second one would be to build one such server.  It would be quite
specific to, hence suitable to be supported by, the "git" project.

The third?  It may look like a simplest way to get a working system, but
I see at least two downsides:

 - designing server-side working tree right is not trivial.  I don't know
   if existing proposed standard matches the semantics git users expect
   from the versioning system well, but I would expect that it would be a
   far better starting point to use than coming up with a random ad-hoc
   semantics in a hurry.

 - in the end, the users will be tied to one implementation of the server
   and the client (they are pretty much the same single ball of wax under
   the current proposal, no?).

You can punt by choosing not to do a per-client server-side working tree
and reduce the problem complexity somewhat, but at that point we will be
looking at a single-user ad-hoc system; it doesn't interest me very much,
personally [*1*].

[Footnote]

*1* It doesn't necessarily mean I'd vote the proposal down (git is not my
personal project)---it just means I wouldn't vote _for_ it.
