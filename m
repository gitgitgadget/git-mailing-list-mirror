From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v1.9-rc0
Date: Mon, 27 Jan 2014 14:56:28 -0800
Message-ID: <xmqqy521m3tv.fsf@gitster.dls.corp.google.com>
References: <xmqq61pjzljn.fsf@gitster.dls.corp.google.com>
	<xmqqha8xt22p.fsf@gitster.dls.corp.google.com>
	<CALZVapmqcFjjKeURHdP4chkB+T2--caJZYiJBzdwq7Ou=HzO5w@mail.gmail.com>
	<52DFE882.2040605@atlas-elektronik.com>
	<xmqq7g9syp1m.fsf@gitster.dls.corp.google.com>
	<CAFFjANTNLnc4GcVeSEvuWpfYVXJchJqkHwvUVdREdXmWx6e4=Q@mail.gmail.com>
	<xmqqlhy7yjjp.fsf@gitster.dls.corp.google.com>
	<20140122203030.GB14211@milliways>
	<20140123020913.GF17254@sigill.intra.peff.net>
	<xmqqha8uva2i.fsf@gitster.dls.corp.google.com>
	<20140124233635.GA31371@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ken Moffat <zarniwhoop@ntlworld.com>,
	Vicent =?utf-8?Q?Mart=C3=AD?= <tanoku@gmail.com>,
	Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>,
	Javier Domingo Cansino <javierdo1@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: linux-kernel-owner@vger.kernel.org Mon Jan 27 23:56:44 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1W7v6h-0006P7-Sc
	for glk-linux-kernel-3@plane.gmane.org; Mon, 27 Jan 2014 23:56:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754460AbaA0W4g (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 27 Jan 2014 17:56:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47915 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753722AbaA0W4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jan 2014 17:56:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABD5A675F5;
	Mon, 27 Jan 2014 17:56:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zqCsY8/UIDmQDAHLh5iUlKAHi0s=; b=Tux+bZ
	CWwMr+BTILqfKGvaHhTw76QJVzleRbTG/FKOfTHfltqltQ6RyCzNJXu1VosIzwO5
	GgfFwNIzw5jdAtD22o1eupPANW1t1+4q33l6V9xtjGUD5QM4CJQUyCd7gb12drjf
	DWO0CM1+WbqfnghiMgWg7hPkn1E3bMss9gVIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xAWgMtpBnnqFozUiwsWaO/8xTQUYlb9W
	iQrMvgvubCXPSZvz1+EwsMNpgmkEkKp9J+DKURqtiCylNqj9Qr5O90TGjfM4kjek
	frXOmkh4QXeuW8Uc1N/VZxNU7VguoBojUh12H2R/j8/WYYbKWa+3LPtZWiqwPMm5
	72wBf5yXn3g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A944675F4;
	Mon, 27 Jan 2014 17:56:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 173B0675F2;
	Mon, 27 Jan 2014 17:56:32 -0500 (EST)
In-Reply-To: <20140124233635.GA31371@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 24 Jan 2014 18:36:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 43C6EC3C-87A6-11E3-9200-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241164>

Jeff King <peff@peff.net> writes:

> On Thu, Jan 23, 2014 at 10:15:33AM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > Junio, since you prepare such tarballs[1] anyway for kernel.org, it
>> > might be worth uploading them to the "Releases" page of git/git.  I
>> > imagine there is a programmatic way to do so via GitHub's API, but I
>> > don't know offhand. I can look into it if you are interested.
>> 
>> I already have a script that takes the three tarballs and uploads
>> them to two places, so adding GitHub as the third destination should
>> be a natural and welcome way to automate it.
>
> I came up with the script below, which you can use like:
>
>   ./script v1.8.2.3 git-1.8.2.3.tar.gz
>
> It expects the tag to already be pushed up to GitHub.  I'll leave
> sticking it on the "todo" branch and integrating it into RelUpload to
> you. This can also be used to backfill the old releases (though I looked
> on k.org and it seems to have only partial coverage).
>
> It sets the "prerelease" flag for -rc releases, but I did not otherwise
> fill in any fields, including the summary and description. GitHub seems
> to display reasonably if they are not set.

Thanks.

> -- >8 --
> #!/bin/sh
> #
> # usage: $0 <tag> <tarball>
>
> repo=git/git
>
> # replace this with however you store your oauth token
> # if you don't have one, make one here:
> # https://github.com/settings/tokens/new
> token() {
>   pass -n github.web.oauth

Hmph, what is this "pass" thing?

> }
>
> post() {
>   curl -H "Authorization: token $(token)" "$@"
> }
>
> # usage: create <tag-name>
> create() {
>   case "$1" in
>   *-rc*)
>     prerelease=true
>     ;;
>   *)
>     prerelease=false
>     ;;
>   esac
>
>   post -d '
>   {
>     "tag_name": "'"$1"'",
>     "prerelease": '"$prerelease"'
>   }' "https://api.github.com/repos/$repo/releases"
> }
>
> # use: upload <release-id> <filename>
> upload() {
>   url="https://uploads.github.com/repos/$repo/releases/$1/assets" &&
>   url="$url?name=$(basename $2)" &&
>   post -H "Content-Type: $(file -b --mime-type "$2")" \
>        --data-binary "@$2" \
>        "$url"
> }
>
> # This is a hack. If you don't mind a dependency on
> # perl's JSON (or another parser), we can do a lot better.
> extract_id() {
>   perl -lne '/"id":\s*(\d+)/ or next; print $1; exit 0'
> }
>
> create "$1" >release.json &&
> id=$(extract_id <release.json) &&
> upload "$id" "$2" >/dev/null &&
> rm -f release.json
