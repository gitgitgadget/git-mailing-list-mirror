From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] Documentation: fix linkgit references
Date: Wed, 04 May 2016 10:28:51 -0700
Message-ID: <xmqqd1p1ivfw.fsf@gitster.mtv.corp.google.com>
References: <E4A56B4E-6F2E-44E3-870B-D1D3A71B2869@gmail.com>
	<1462351116-19308-1-git-send-email-larsxschneider@gmail.com>
	<1462351116-19308-2-git-send-email-larsxschneider@gmail.com>
	<F6210682-2FCA-423D-B6D3-06938C95D497@gmail.com>
	<5729DF25.7030503@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
	peff@peff.net, Matthieu.Moy@grenoble-inp.fr, sbeller@google.com
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed May 04 19:29:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay0bf-0001FH-5H
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 19:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754587AbcEDR24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 13:28:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58177 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753355AbcEDR2z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 13:28:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D746116F6D;
	Wed,  4 May 2016 13:28:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9kB6I03LVxRTHuaGWUFOR4WjRY4=; b=CrLveh
	h6T2cHZ+MsPMpKPYh9dZ+6bUAQlHO2S5X6dQULgEAyrfmx66u1gFRWKVhcUgrNmf
	qLqcYaiv/qJl5xTzrv32jucRcjvPkg6GyC+QjoGnW7TSR1HpFNBc8D0I7bwXD53/
	ENtqMiXEV8TP+miLWJz04FK4LZgbXOGKFgz7g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I/nBw335GTj4bsl8/q6CsdTiVSor5fYk
	mGbG5B6WegGVI0staGAIYRzN0H+wszT1WM7/4I3nxYmI9YAkJWusXSkR2+LNHlut
	DxNQq0AUhjAO/zVabfwtcibwRo0FzXsj8AfB5rSwvqrWzUGBtOlVOV/tCg23IQPH
	bzRpThO/Ugo=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CE8EC16F6C;
	Wed,  4 May 2016 13:28:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 432E716F6B;
	Wed,  4 May 2016 13:28:53 -0400 (EDT)
In-Reply-To: <5729DF25.7030503@ramsayjones.plus.com> (Ramsay Jones's message
	of "Wed, 4 May 2016 12:38:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AC2F4ED2-121D-11E6-ABE0-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293554>

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>>> diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
>>> index e94367a..9a85998 100644
>>> --- a/Documentation/git-check-ignore.txt
>>> +++ b/Documentation/git-check-ignore.txt
>>> @@ -112,7 +112,7 @@ EXIT STATUS
>>> SEE ALSO
>>> --------
>>> linkgit:gitignore[5]
>>> -linkgit:gitconfig[5]
>>> +linkgit:git-config[5]
>
> I think Junio already noted, git-config is in section 1 not 5.

Not just that, I am afraid.  This came from 368aa529 (add
git-check-ignore sub-command, 2013-01-06) and it added these:

+linkgit:gitignore[5]
+linkgit:gitconfig[5]
+linkgit:git-ls-files[5]

The last one was later corrected, but who knows what other mistakes
there are?

So I used the script attached at the bottom to audit the whole
thing, and the result is here.

-- >8 --
Documentation/config.txt:1497: nongit link: :git-gui[1]
Documentation/config.txt:1662: nongit link: curl[1]
Documentation/diff-options.txt:274: wrong section (should be 5): gitattributes[1]
Documentation/git-check-ignore.txt:115: no such source: gitconfig[5]
Documentation/git-filter-branch.txt:208: nongit link: rev-list[1]
Documentation/git-for-each-ref.txt:182: nongit link: :git-rev-list[1]
Documentation/git-notes.txt:405: wrong section (should be 1): git[7]
Documentation/technical/api-credentials.txt:246: wrong section (should be 1): git-credential[7]
Documentation/technical/api-credentials.txt:271: wrong section (should be 1): git-config[5]
-- 8< --

I do not think there is any false positive above, so perhaps the
checker script below can be used as the link checker we discussed?

-- >8 --
#!/bin/sh

git grep -l linkgit: Documentation/ |
while read path
do
	perl -e '
	sub report {
		my ($where, $what, $error) = @_;
		print "$where: $error: $what\n";
	}

	sub grab_section {
		my ($page) = @_;
		open my $fh, "<", "Documentation/$page.txt";
		my $firstline = <$fh>;
		chomp $firstline;
		close $fh;
		my ($section) = ($firstline =~ /.*\((\d)\)$/);
		return $section;
	}

	while (<>) {
		my $where = "$ARGV:$.";
		while (s/linkgit:((.*?)\[(\d)\])//) {
			my ($target, $page, $section) = ($1, $2, $3);

			# De-AsciiDoc
			$page =~ s/{litdd}/--/g;

			if ($page !~ /^git/) {
				report($where, $target, "nongit link");
				next;
			}
			if (! -f "Documentation/$page.txt") {
				report($where, $target, "no such source");
				next;
			}
			$real_section = grab_section($page); 
			if ($real_section != $section) {
				report($where, $target,
					"wrong section (should be $real_section)");
				next;
			}
		}
	}
        ' "$path"
done
