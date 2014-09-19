From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: add configurable tab size to the diff view git-gui - why not added to git-gui ?
Date: Fri, 19 Sep 2014 09:56:34 -0700
Message-ID: <xmqqd2aro8fx.fsf@gitster.dls.corp.google.com>
References: <lvhesi$qqs$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>
To: pb158 <pb158@tlen.pl>
X-From: git-owner@vger.kernel.org Fri Sep 19 18:56:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XV1UL-0006wO-9H
	for gcvg-git-2@plane.gmane.org; Fri, 19 Sep 2014 18:56:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757524AbaISQ4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2014 12:56:44 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54541 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757517AbaISQ4m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2014 12:56:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B903D39CCC;
	Fri, 19 Sep 2014 12:56:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DMjbcsXwzJMfjOXRjprxVZI1Y60=; b=Lx+0za
	6qTwOPzkmzHQFgo9lT6bt40BCY765aBDeh066SIS9/UsLejoVzRRNTvep0cjEuLm
	00NTcJjMee7cGYbyCAzjY6cqNfnP69OJaKALbO25E9HWnpRZnzsiFifMoW3kLmpX
	Eg+IplFmByOecvKrEMMRBQfZipiYlo+ZpX7lw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yZ8Qi/gu5kTbomYWsVr94Vkp8b7pB3+F
	LdCNifcrH4B9d5o6DI2gkZbpwUMMsVcTHRdSN7E7NZXwE1wP8CDo6LrKd4Hbk07T
	76v4VCPPxjvDRjjPr81bRhLwt+1Uw5b4vBtNpxmYgyxlAwKsSaaj9j7Uk1J1Pyvt
	WqPTIneDQ78=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AF68B39CCB;
	Fri, 19 Sep 2014 12:56:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3242439CCA;
	Fri, 19 Sep 2014 12:56:36 -0400 (EDT)
In-Reply-To: <lvhesi$qqs$1@ger.gmane.org> (pb's message of "Fri, 19 Sep 2014
	16:33:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EA9A63EC-401D-11E4-8A9C-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257289>

pb158 <pb158@tlen.pl> writes:

> Home of the original description and the author of the patch:
>
> http://www.spinics.net/lists/git/msg174415.html
>
> Why not added this useful little patch for git-gui ?
>
> ( this patch resolve my problem with 8 spaces tab Linux Eclipse + Java
> program source + git gui
> and I apply locally it to each new version git before source compilation )
>
> original content of the message from the link above:
>

I do not use git-gui, and I do not speak very good tcl/tk either, so
I won't comment on the patch itself (Cc'ed its maintainer Pat), but
thanks for trying to relay, anyway.

> ----------------------
>
> For Tk 8.5 the "wordprocessor" mode allows us to get a bit fancy for merge
> diffs and intend the tabs by one to compensate for the additional diff
> marker at the line start.
>
> The code is heavily based on how gitk handles tabs.
>
> Signed-off-by: Michael Lutz <michi@xxxxxxxxxxxxxx>

With this, the author refuses to be contacted if/when any question
arises wrt the provenance of the patch, which is not a usable form
of a sign-off.  When you relay a change from somebody else who
claims that he has rights to contribute the change to the project,
and you have the rights to relay that change to the project, please
also add your own sign-off.  For further details, please check "(5)
Sign your work" section of Documentation/SubmittingPatches.  I am
guessing that Michael is asserting DCO 1.1 (a) and (d), and you
without a name but only a number are asserting DCO 1.1 (c) and (d).

Thanks.

> ---
>  git-gui.sh     |    1 +
>  lib/diff.tcl   |   20 +++++++++++++++++++-
>  lib/option.tcl |    1 +
>  3 files changed, 21 insertions(+), 1 deletions(-)
>
> diff --git a/git-gui.sh b/git-gui.sh
> index ba4e5c1..22d7665 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -892,6 +892,7 @@ set default_config(gui.fontdiff) [font configure
> font_diff]
>  set default_config(gui.maxfilesdisplayed) 5000
>  set default_config(gui.usettk) 1
>  set default_config(gui.warndetachedcommit) 1
> +set default_config(gui.tabsize) 8
>  set font_descs {
>  	{fontui   font_ui   {mc "Main Font"}}
>  	{fontdiff font_diff {mc "Diff/Console Font"}}
> diff --git a/lib/diff.tcl b/lib/diff.tcl
> index ec44055..f314197 100644
> --- a/lib/diff.tcl
> +++ b/lib/diff.tcl
> @@ -1,6 +1,19 @@
>  # git-gui diff viewer
>  # Copyright (C) 2006, 2007 Shawn Pearce
>
> +proc apply_tab_size {{firsttab {}}} {
> +	global have_tk85 repo_config ui_diff
> +
> +	set w [font measure font_diff "0"]
> +	if {$have_tk85 && $firsttab != 0} {
> +		$ui_diff configure -tabs [list [expr {$firsttab * $w}]
> [expr {($firsttab + $repo_config(gui.tabsize)) * $w}]]
> +	} elseif {$have_tk85 || $repo_config(gui.tabsize) != 8} {
> +		$ui_diff configure -tabs [expr {$repo_config(gui.tabsize) * $w}]
> +	} else {
> +		$ui_diff configure -tabs {}
> +	}
> +}
> +
>  proc clear_diff {} {
>  	global ui_diff current_diff_path current_diff_header
>  	global ui_index ui_workdir
> @@ -105,6 +118,8 @@ proc show_diff {path w {lno {}} {scroll_pos {}}
> {callback {}}} {
>
>  	set cont_info [list $scroll_pos $callback]
>
> +	apply_tab_size 0
> +
>  	if {[string first {U} $m] >= 0} {
>  		merge_load_stages $path [list show_unmerged_diff $cont_info]
>  	} elseif {$m eq {_O}} {
> @@ -398,7 +413,10 @@ proc read_diff {fd conflict_size cont_info} {
>
>  		# -- Automatically detect if this is a 3 way diff.
>  		#
> -		if {[string match {@@@ *} $line]} {set is_3way_diff 1}
> +		if {[string match {@@@ *} $line]} {
> +			set is_3way_diff 1
> +			apply_tab_size 1
> +		}
>
>  		if {$::current_diff_inheader} {
>
> diff --git a/lib/option.tcl b/lib/option.tcl
> index 0cf1da1..b940c44 100644
> --- a/lib/option.tcl
> +++ b/lib/option.tcl
> @@ -159,6 +159,7 @@ proc do_options {} {
>  		{c gui.encoding {mc "Default File Contents Encoding"}}
>  		{b gui.warndetachedcommit {mc "Warn before committing
> to a detached head"}}
>  		{s gui.stageuntracked {mc "Staging of untracked
> files"} {list "yes" "no" "ask"}}
> +		{i-1..99 gui.tabsize {mc "Tab spacing"}}
>  		} {
>  		set type [lindex $option 0]
>  		set name [lindex $option 1]
>
> ---------------
>
> Regards,
>
> Krzysztof
