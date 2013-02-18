From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Mon, 18 Feb 2013 14:37:35 -0800
Message-ID: <7vehgd9rkg.fsf@alter.siamese.dyndns.org>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
 <20130218174239.GB22832@sigill.intra.peff.net>
 <20130218193424.GC3234@elie.Belkin>
 <CALkWK0mKZLotuu7pEM_3Of3i6JzU12QV_pHxOZTUr22TOq3PeQ@mail.gmail.com>
 <20130218210709.GC27308@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Barr <b@rr-dav.id.au>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 18 23:38:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7ZLW-0003v5-QO
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 23:38:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757439Ab3BRWhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 17:37:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51204 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757240Ab3BRWhi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 17:37:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84FD5B372;
	Mon, 18 Feb 2013 17:37:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vN3qiH+5E39go3AQM3Zd3VyC4do=; b=xvws8/
	861iluBuCmSjKIWelT/RWiS5tJC1G6g89HZbbnpC0lLJTGyZH0h7bn6Wb9LTdIsp
	QeZqK5iQ6om0cGf9NmAEYh6XRttBqjQ5RLkFwgObKjSrwxChsBh3G1tdDmleydLN
	mWKpemzSj1IXLi/c12Baw6zIzvHfpYAH6W8Qs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=volUXbTjKWeTHUCdeev4GvLHUpJZ5ofY
	Z+ltvkC0eo0HZnTVtf7UZiU3XAOMaLUQvK2yNrUN77i1tuWlFpdKZvzI/4LoHXJb
	GUfLaTVULjasEBnHkCCBTZumLAHhEzSTb/dEYfRb4/dPFhE4BBhBySQpk597DfDW
	7G8iEU2IcBI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77EEEB371;
	Mon, 18 Feb 2013 17:37:37 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB61CB370; Mon, 18 Feb 2013
 17:37:36 -0500 (EST)
In-Reply-To: <20130218210709.GC27308@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 18 Feb 2013 16:07:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CB57CE3A-7A1B-11E2-B579-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216541>

Jeff King <peff@peff.net> writes:

> This is not related to GSoC anymore, but I think handling multiple
> versions is already pretty easy. You can just install to
> "$HOME/local/git/$TAGNAME" or similar, and then symlink the "bin/git"
> binary from there into your PATH as git.$TAGNAME (e.g., git.v1.7.8). Git
> already takes care of the messy bits, like making sure sub-programs are
> invoked from the same git version.
>
> I already do this automagically with this script:
>
>   https://github.com/peff/git/blob/meta/install/prefix
>
> I just set "prefix" in the Makefile based on the script, and when I
> "make install" tags or topic branches, they go to the right place (and
> the "links" script in the same directory maintains the symlinks for me).
>
> I never bothered to even submit those scripts to contrib, because I
> figured they were so specific to my setup, and to keeping dozens of git
> versions around (when debugging, it's nice to be able to check an old
> version's behavior without even having to build it).

Yeah, I have been using the Make (in the todo branch, to be checked
out in Meta/ subdirectory of the working tree) script for exactly
this.  After tagging a release, I'd do

	git checkout -B snap v1.8.1.3
        Meta/Make install install-doc

to install them in $inst_prefix/git-snap-v1.8.1.3.  A "rungit"
script can then be used like:

	rungit v1.7.0 checkout blah

-- rungit script -- >8 -- rungit script --
#!/bin/sh
# Run various vintage of git

variant="${0##*/}" &&
: ${RUNGIT_BASE=$HOME/g/$(getarch)} &&
case "$variant" in
rungit)
	case $# in 
	0)
		echo >&2 "which version?"
		exit 1
		;;
	esac
	variant=$1
	shift
	;;
esac &&
case "$variant" in
-l)
	for d in "$RUNGIT_BASE/"git-*/bin/git
	do
		d=$(basename ${d%/bin/git})
		d=${d#git-}
		d=${d#snap-}
		echo "$d"
	done
	exit
	;;
git-*)
	variant=${variant#git-} ;;
v[0-9]*)
	variant=snap-$variant ;;
esac &&
d="$RUNGIT_BASE/git-$variant" &&
if test -f "$d/bin/git"
then
	exec "$d/bin/git" "$@"
else
	echo >&2 "$variant: No such variant for $a"
	exit 1
fi
