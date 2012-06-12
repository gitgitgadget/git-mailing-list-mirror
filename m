From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 1/2] git-remote-mediawiki: import "File:" attachments
Date: Tue, 12 Jun 2012 14:05:21 -0700
Message-ID: <7vy5nsi6lq.fsf@alter.siamese.dyndns.org>
References: <1339532091-25232-1-git-send-email-Pavel.Volek@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 12 23:05:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeYHJ-0004ZR-3B
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 23:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709Ab2FLVFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 17:05:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60942 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752540Ab2FLVFY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 17:05:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98F3797AC;
	Tue, 12 Jun 2012 17:05:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3EvJsG+wR/auhCk3fy6uNwpuXLw=; b=jxy8XV
	Ga8IQZZOM5X0vmVH3M9vdBcQ8l85kkBffkV2bdw0aRg5lqRgBKG+sWaM/kdbEQHa
	5oCIHpUos11EB3loRBs6Zt1zURo2GAPHNpkZompQpueTxmlqpfKTovNUQ3a6eGGQ
	0nGu5uEj0nJeTmvb+fbfK9lCTrD25dGRGBT1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DRxqNvfGQ643nfFrTCdkGyzYsxtDA0HO
	v7ImSKLLaMA0RfRtTUKVwQIWB/YoajXo7pWLCOP3LpV0DYML5aLw1rgTJK6SNZ19
	uDZB3A+g4o3zMYy8z/jonxwai7LDZDC2iuXveo3jgvlYBHkOK90uyVJz+rpdrzew
	1FXsrA6GnsI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DE2997AB;
	Tue, 12 Jun 2012 17:05:23 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC93597A9; Tue, 12 Jun 2012
 17:05:22 -0400 (EDT)
In-Reply-To: <1339532091-25232-1-git-send-email-Pavel.Volek@ensimag.imag.fr>
 (Pavel Volek's message of "Tue, 12 Jun 2012 22:14:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5324050A-B4D2-11E1-96E6-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199854>

Pavel Volek <Pavel.Volek@ensimag.imag.fr> writes:

> From: Pavel VOlek <Pavel.Volek@ensimag.imag.fr>

Did you really mean this?  It does not match your S-o-b: line below.

>
> The current version of the git-remote-mediawiki supports only import and export
> of the pages, doesn't support import and export of file attachments which are
> also exposed by MediaWiki API. This patch adds the functionality to import file
> attachments and description pages for these files.
>
> Chages version2 -> version3:
> Fixes in comments.
> Variable '$file' -> '$file_content' refactoring to be clearer.

These three lines do not belong here above the three-dash lines, I think.

> Signed-off-by: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
> Signed-off-by: NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>
> Signed-off-by: ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  contrib/mw-to-git/git-remote-mediawiki | 223 ++++++++++++++++++++++++++++++++-
>  1 file changed, 218 insertions(+), 5 deletions(-)
>
> diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
> index c18bfa1..04d3959 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki
> +++ b/contrib/mw-to-git/git-remote-mediawiki
> @@ -13,9 +13,6 @@
>  #
>  # Known limitations:
>  #
> -# - Only wiki pages are managed, no support for [[File:...]]
> -#   attachments.
> -#

Nice.

> @@ -71,6 +68,9 @@ chomp(@tracked_pages);
>  my @tracked_categories = split(/[ \n]/, run_git("config --get-all remote.". $remotename .".categories"));
>  chomp(@tracked_categories);
>  
> +# Import media files too.
> +my $import_media = run_git("config --get --bool remote.". $remotename .".mediaimport");
> +
>  my $wiki_login = run_git("config --get remote.". $remotename .".mwLogin");
>  # TODO: ideally, this should be able to read from keyboard, but we're
>  # inside a remote helper, so our stdin is connect to git, not to a
> @@ -225,6 +225,10 @@ sub get_mw_pages {
>  			get_mw_first_pages(\@slice, \%pages);
>  			@some_pages = @some_pages[51..$#some_pages];
>  		}
> +
> +		if ($import_media) {
> +			get_mw_pages_for_linked_mediafiles(\@tracked_pages, \%pages);
> +		}

I am guessing that the loop above is to avoid fetching and
processing too many pages at once.  Doesn't the call to
get_mw_pages_for_linked_mediafiles() need a similar consideration,
or what the function does is significantly different from what
get_mw_first_pages() does and there is no need to worry?

By the way, does it really have to be that overly long name?

> @@ -244,6 +248,11 @@ sub get_mw_pages {
>  			foreach my $page (@{$mw_pages}) {
>  				$pages{$page->{title}} = $page;
>  			}
> +
> +			if ($import_media) {
> +				my @titles = map $_->{title}, @{$mw_pages};
> +				get_mw_pages_for_linked_mediafiles(\@titles, \%pages);
> +			}
>  		}
>  	}
>  	if (!$user_defined) {
> @@ -263,10 +272,186 @@ sub get_mw_pages {
>  		foreach my $page (@{$mw_pages}) {
>  			$pages{$page->{title}} = $page;
>  		}
> +
> +		if ($import_media) {
> +			# Attach list of all pages for media files from the API,
> +			# they are in a different namespace, only one namespace
> +			# can be queried at the same moment
> +			my $mw_pages = $mediawiki->list({
> +				action => 'query',
> +				list => 'allpages',
> +				apnamespace => get_mw_namespace_id("File"),
> +				aplimit => 500
> +			});
> +			if (!defined($mw_pages)) {
> +				print STDERR "fatal: could not get the list of pages for media files.\n";
> +				print STDERR "fatal: '$url' does not appear to be a mediawiki\n";
> +				print STDERR "fatal: make sure '$url/api.php' is a valid page.\n";
> +				exit 1;
> +			}
> +			foreach my $page (@{$mw_pages}) {
> +				$pages{$page->{title}} = $page;
> +			}
> +		}

For categories you need to call pages-for-mediafiles with the titles
you learned (the hunk starting at l.224), but there is no need to
call pages-for-mediafiles in this hunk?

Not a rhetorical question to suggest that you should; just
wondering.

> +sub get_mw_pages_for_linked_mediafiles {
> +	my $titles = shift;
> +	my @titles = @{$titles};

Do you really need to make a copy of this array?  Wouldn't it
suffice to say

	my $mw_titles = join('|', @$titles);

at the only location in this function that uses this parameter?

> +	my $pages = shift;
> +
> +	# pattern 'page1|page2|...' required by the API
> +	my $mw_titles = join('|', @titles);

Nobody seems to be making sure there won't be more than 500 (I am
assuming that this script is considered a 'bot) pages in $mw_titles
variable.  Shouldn't the API call be split into such batches?

> +	# Media files could be included or linked from
> +	# a page, get all related
> +	my $query = {
> +		action => 'query',
> +		prop => 'links|images',
> +		titles => $mw_titles,
> +		plnamespace => get_mw_namespace_id("File"),
> +		pllimit => 500
> +	};
> +	my $result = $mediawiki->api($query);
> +
> +	while (my ($id, $page) = each(%{$result->{query}->{pages}})) {
> +		my @titles;
> +		if (defined($page->{links})) {
> +			my @link_titles = map $_->{title}, @{$page->{links}};
> +			push(@titles, @link_titles);
> +		}
> +		if (defined($page->{images})) {
> +			my @image_titles = map $_->{title}, @{$page->{images}};
> +			push(@titles, @image_titles);
> +		}
> +		if (@titles) {
> +			get_mw_first_pages(\@titles, \%{$pages});
> +		}
> +	}
> +}
> +
> +# Return MediaWiki id for a canonical namespace name.
> +# Ex.: "File", "Project".
> +# Looks for the namespace id in the local configuration
> +# variables, if it is not found asks MW API.
> +sub get_mw_namespace_id {
> +	mw_connect_maybe();
> +
> +	my $name = shift;
> +
> +	# Look at configuration file, if the record
> +	# for that namespace is already stored.
> +	# Namespaces are stored in form: "Name_of_namespace:Id_namespace",
> +	# Ex.: "File:6".
> +	my @tracked_namespaces = split(/[ \n]/, run_git("config --get-all remote.". $remotename .".namespaces"));
> +	chomp(@tracked_namespaces);
> +	if (@tracked_namespaces) {
> +		foreach my $ns (@tracked_namespaces) {
> +			my @ns_split = split(/:/, $ns);
> +			if ($ns_split[0] eq $name) {
> +				return $ns_split[1];
> +			}
> +		}
> +	}

Does it make sense to call out to run_git() every time this function
is called?  Shoudln't this part be caching the result in a hash,
something like

	if (!exists $namespace_id{$name}) {
		@temp = ... run_git() ...;
                foreach my $ns (@temp) {
			my ($n, $s) = split(/:/, $ns);
			$namespace_id{$n} = $s;
		}
	}

	if (!exists $namespace_id{$name}) {
		... similarly, ask MW API and store in %namespace_id{}
	}

        if (exists $namespace_id{$name}) {
        	return $namespace_id{$name};
	}
	die "No such namespace $name";
