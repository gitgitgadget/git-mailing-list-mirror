From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 0/5] Moving gitweb documentation to manpages
Date: Tue, 18 Oct 2011 21:29:37 -0700
Message-ID: <7vfwipfvta.fsf@alter.siamese.dyndns.org>
References: <1318763255-23495-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 06:29:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGNmn-0001bm-Pn
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 06:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755054Ab1JSE3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 00:29:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45483 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754739Ab1JSE3m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 00:29:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26B6165DD;
	Wed, 19 Oct 2011 00:29:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=IkWCxEhKvsOVnOfrmrTLtnouLfk=; b=sxQdxCnazPSf4bUzOXPF
	5loRlZVFwfEbTUb9sQeug4cZQMpHXSqzQPZ3m6DEGiW1r1jtSL4bC6Af4usptaIe
	ShiE3DQyhpS3RByNNvFFYcTWHWTP7PMreATg4W1i75I4zcqKVoaDq8bMaWgI4yTJ
	Ft/cZewP4RkxK+5Hy7sGoSk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=HG/C+mcSmpVDPwOUqQpokOj04s7eYd323AOUbvjYbBrtSG
	dJFtXuE5zn9D7j+wtpzUDwlBwzbi7h+74DUboqlCmh7kQWTQJVVg5sp38gqPHG5k
	P4c33e2IxtdL3roTQiQIPDREzHZeTVPQfUzVcVEyWpFgAi+WjuITznkDFhqz0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D9F965DC;
	Wed, 19 Oct 2011 00:29:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 68DB765DB; Wed, 19 Oct 2011
 00:29:40 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F5F82938-FA0A-11E0-8297-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183913>

Jakub Narebski <jnareb@gmail.com> writes:

> The original patch adding manpage for /etc/gitweb.conf was sent by
> Drew Northup (as can be seen from shortlog); I have added manpage for
> gitweb itself, inspired by his patch.  Unfortunately Drew doesn't
> currently have time to work on this patch (patch series), so that is
> why it is me resending this series (yet again).
>
> The difference with previous version
>
>   [PATCHv5/RFC 0/6] Moving gitweb documentation to manpages
>   http://thread.gmane.org/gmane.comp.version-control.git/183166
>   http://marc.info/?l=git&m=131809875619259&w=2
>
> is that "Documentation: Preparation for gitweb manpages" (originally a
> first patch) got removed, and two main patches got improved.  Other
> patches are unchanged from previous version.
>
>
> Pull request:
> ~~~~~~~~~~~~~
> The following changes since commit 288396994f077eec7e7db0017838a5afbfbf81e3:
>
>   Sync with maint (2011-10-15 20:59:50 -0700)
>
> are available in the git repository at:
>
>   git://repo.or.cz/git/jnareb-git.git gitweb/doc

I fetched it and compared with the result of applying this series; it
appears that the version fetched from there is full of random whitespace
issues, e.g. ('$' added by "cat -e")

diff --git b/Documentation/gitweb.txt a/Documentation/gitweb.txt$
index 605a085..353e37f 100644$
--- b/Documentation/gitweb.txt$
+++ a/Documentation/gitweb.txt$
@@ -370,12 +370,12 @@ commitdiff::$
        view shows information about commit in more detail, the 'commitdiff'$
        action shows changeset for given commit.$
 $
-patch::$
+patch:: $
        Returns the commit in plain text mail format, suitable for applying with$
        linkgit:git-am[1].$

The series seems to have been rebased on a more recent 'master' and does
not match the "since commit..." stated above (not a major offense; just
mentioning as I noticed it).

In any case, I've queued the one from the mailing list. Thanks.
