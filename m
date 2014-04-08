From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v10 11/12] Documentation: add documentation for 'git interpret-trailers'
Date: Tue, 08 Apr 2014 09:30:17 +0200
Message-ID: <5343A589.10503@alum.mit.edu>
References: <20140406163214.15116.91484.chriscool@tuxfamily.org> <20140406170204.15116.15559.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 09:32:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXQVs-0003K9-Ev
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 09:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756284AbaDHHcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 03:32:00 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:48746 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756242AbaDHHb7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Apr 2014 03:31:59 -0400
X-AuditID: 12074413-f79076d000002d17-b7-5343a5eeae46
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 29.DF.11543.EE5A3435; Tue,  8 Apr 2014 03:31:58 -0400 (EDT)
Received: from [192.168.69.148] (p5B156B83.dip0.t-ipconnect.de [91.21.107.131])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s387UIc2004724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 8 Apr 2014 03:30:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <20140406170204.15116.15559.chriscool@tuxfamily.org>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0zTUBj1rl1XxoqlIFynwVhf0TgUY2JNxAdibPxBDMSYKIqVFTbdCllb
	BH4YCPrDCQQNik4lKAgCBnQQX0iiCL6CRhFfKAR8TUFQ1ABREFsWkH/nfud85+TmfDhCjWiN
	uFWQeIfA2WhMj1K6yNmmvvPrY5YWF9OM23MEYXr+FqCMs/WwhsnIaUWYx0UnAFPYfkPDjBYl
	Mb2vSwAzdCAbYeqOF2FM89dMwNy+O32tgb3uatexLV8GMbatJ5zt7drM9n9sQ9lPOTcB+7Rl
	Dvv+yH0tW9y5ic3vGNWyZZ3dOvanO2SzYZvvqt2clBJjTRSWrN7la3Hf8mDJXRtTqxvK0AzQ
	uNIJfHBILocjngs6Lw6CTzqqMSfQ4xT5DMDm2krE+3isgedfto6pCHIh/OzMw1SMkvNg499c
	rYox0gTPZWdpnADHp5HRcPjRbK/cHz44+QFVcSC5HRa05OtUT4Q8hcCBzHNjPgFkLHR9qRrz
	oUgZFv4uR1TsQ66D5XXPMdUTksEwOzNaHSPkYtiX24l48Sx4tfc0kgf8XZPiXJNkrkmyIoBU
	gBDOJttNds5qE/l4kxjPCQLvMK0ItVulUN4su4G3voBr4MaDkAZA4oA2EKmNETGUlksR0+wN
	YDquoacRstIu5bc7yZxm4URLnEO28WIDgDhCBxLm9QpHmLm0dN6RNE7NwFE6mJhfsiCKIhM5
	id/L88m8Y5ydieM0JPJUU38Hn8inJlht0n9ag/uo5npjoMgLZt7ByZIlTi04TlQaVimDkrtD
	XSfEZM6uTL2rD4EJv3TlYqaGQoUkgTcGE00liohURRZZmIgYv9puEKz8OMBrZVBu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245917>

Sorry for reappearing in this thread after such a long absence.  I
wanted to see what is coming up (I think this interpret-trailers command
will be handy!) so I read this documentation patch carefully, and added
some questions and suggestions below.

On 04/06/2014 07:02 PM, Christian Couder wrote:
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-interpret-trailers.txt | 123 +++++++++++++++++++++++++++++++
>  1 file changed, 123 insertions(+)
>  create mode 100644 Documentation/git-interpret-trailers.txt
> 
> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
> new file mode 100644
> index 0000000..75ae386
> --- /dev/null
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -0,0 +1,123 @@
> +git-interpret-trailers(1)
> +=========================
> +
> +NAME
> +----
> +git-interpret-trailers - help add stuctured information into commit messages
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git interpret-trailers' [--trim-empty] [(<token>[(=|:)<value>])...]
> +
> +DESCRIPTION
> +-----------
> +Help add RFC 822-like headers, called 'trailers', at the end of the
> +otherwise free-form part of a commit message.
> +
> +This command is a filter. It reads the standard input for a commit
> +message and applies the `token` arguments, if any, to this
> +message. The resulting message is emited on the standard output.

s/emited/emitted/

> +
> +Some configuration variables control the way the `token` arguments are
> +applied to the message and the way any existing trailer in the message
> +is changed. They also make it possible to automatically add some
> +trailers.
> +
> +By default, a 'token=value' or 'token:value' argument will be added
> +only if no trailer with the same (token, value) pair is already in the
> +message. The 'token' and 'value' parts will be trimmed to remove
> +starting and trailing whitespace, and the resulting trimmed 'token'
> +and 'value' will appear in the message like this:
> +
> +------------------------------------------------
> +token: value
> +------------------------------------------------
> +
> +By default, if there are already trailers with the same 'token', the
> +new trailer will appear just after the last trailer with the same
> +'token'. Otherwise it will appear at the end of the message.

How are existing trailers recognized in the input commit message?  Do
trailers have to be configured to be recognized?  Or are all lines
matching a specific pattern considered trailers?  If so, it might be
helpful to include a regexp here that describes the trailer "syntax".

What about blank lines?  I see that you try to add a blank line before
new trailers.  But what about on input?  Do the trailer lines have to be
separated from the free-form comment by a blank line to be recognized?
What if there are blank lines between trailer lines, or after them?  Is
it allowed to have non-trailer lines between or after trailer lines?

> +
> +Note that 'trailers' do not follow and are not intended to follow many
> +rules that are in RFC 822. For example they do not follow the line
> +breaking rules, the encoding rules and probably many other rules.
> +
> +OPTIONS
> +-------
> +--trim-empty::
> +	If the 'value' part of any trailer contains only whitespace,
> +	the whole trailer will be removed from the resulting message.

Does this apply to existing trailers, new trailers, or both?  If it
applies to existing trailers, then it seems a bit dangerous, in the
sense that the command might end up changing trailers that are unrelated
to the one that the command is trying to add.

> +
> +CONFIGURATION VARIABLES
> +-----------------------
> +
> +trailer.<token>.key::
> +	This 'key' will be used instead of 'token' in the
> +	trailer. After some alphanumeric characters, it can contain

Trailer keys can also contain '-', right?

> +	some non alphanumeric characters like ':', '=' or '#' that will
> +	be used instead of ':' to separate the token from the value in
> +	the trailer, though the default ':' is more standard.

Above it looks like the default separator is not ':' but rather ': '
(with a space).  Is the space always added regardless of the value of
this configuration variable, or should the configuration value include
the trailing space if it is desired?  Is there any way to get a trailer
that doesn't include a space, like

    foo=bar

?  (Changing this to "foo= bar" would look pretty ugly.)

If a commit message containing trailer lines with separators other than
':' is input to the program, will it recognize them as trailer lines?
Do such trailer lines have to have the same separator as the one listed
in this configuration setting to be recognized?

I suppose that there is some compelling reason to allow non-colon
separators here.  If not, it seems like it adds a lot of complexity and
should maybe be omitted, or limited to only a few specific separators.

> +
> +trailer.<token>.where::
> +	This can be either `after`, which is the default, or
> +	`before`. If it is `before`, then a trailer with the specified
> +	token, will appear before, instead of after, other trailers
> +	with the same token, or otherwise at the beginning, instead of
> +	at the end, of all the trailers.

Brainstorming: some other options that might make sense here someday:

`end`: add new trailer after all existing trailers (even those with
different keys).  This would allow trailers to be kept in chronological
order.

`beginning`: add new trailer before the first existing trailer (allows
reverse chronological order).

`sorted`: add new trailer among the existing trailers with the same key
so as to keep their values in lexicographic order.

> +
> +trailer.<token>.ifexist::
> +	This option makes it possible to choose what action will be
> +	performed when there is already at least one trailer with the
> +	same token in the message.
> ++
> +The valid values for this option are: `addIfDifferent` (this is the
> +default), `addIfDifferentNeighbor`, `add`, `overwrite` or `doNothing`.

Are these option values case sensitive?  If so, it might be a little bit
confusing because the same camel-case is often used in documentation for
configuration *keys*, which are not case sensitive [1], and users might
have gotten used to thinking of strings that look like this to be
non-case-sensitive.

> ++
> +With `addIfDifferent`, a new trailer will be added only if no trailer
> +with the same (token, value) pair is already in the message.
> ++
> +With `addIfDifferentNeighbor`, a new trailer will be added only if no
> +trailer with the same (token, value) pair is above or below the line
> +where the new trailer will be added.
> ++
> +With `add`, a new trailer will be added, even if some trailers with
> +the same (token, value) pair are already in the message.
> ++
> +With `overwrite`, the new trailer will overwrite an existing trailer
> +with the same token.

What if there are multiple existing trailers with the same token?  Are
they all overwritten?

> ++
> +With `doNothing`, nothing will be done, that is no new trailer will be
> +added if there is already one with the same token in the message.
> +
> +trailer.<token>.ifmissing::
> +	This option makes it possible to choose what action will be
> +	performed when there is not yet any trailer with the same
> +	token in the message.
> ++
> +The valid values for this option are: `add` (this is the default) and
> +`doNothing`.
> ++
> +With `add`, a new trailer will be added.
> ++
> +With `doNothing`, nothing will be done.
> +
> +trailer.<token>.command::
> +	This option can be used to specify a shell command that will
> +	be used to automatically add or modify a trailer with the
> +	specified 'token'.
> ++
> +When this option is specified, it is like if a special 'token=value'
> +argument is added at the end of the command line, where 'value' will
> +be given by the standard output of the specified command.

Maybe reword to

    When this option is specified, the behavior is as if a special
    'token=value' argument were added at the end of the command line,
    where 'value' is taken to be the standard output of the specified
    command.

And if it is the case, maybe add "with leading and trailing whitespace
trimmed off" at the end of the sentence.

> ++
> +If the command contains the `$ARG` string, this string will be
> +replaced with the 'value' part of an existing trailer with the same
> +token, if any, before the command is launched.

What if the key appears multiple times in existing trailers?

> +
> +SEE ALSO
> +--------
> +linkgit:git-commit[1]
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
> 

Doesn't this command have to be added to command-list.txt?

Michael

[1] Anti-nitpick declaration: yes, I know that the middle part of
configuration keys is case-sensitive.

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
