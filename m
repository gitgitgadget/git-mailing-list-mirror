From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [MERGE PATCH 3/3] Merge branch 'master' (early part) into
 pd/bash-4-completion
Date: Wed, 15 Dec 2010 00:42:35 -0600
Message-ID: <20101215064235.GD20492@burratino>
References: <1291236582-28603-1-git-send-email-peter@avirtualhome.com>
 <20101202091624.GB1771@burratino>
 <20101202091613.6ac8f816@MonteCarlo.grandprix.int>
 <20101202210207.GA4994@burratino>
 <20101207160747.GD1867@neumann>
 <20101207194923.GD22587@burratino>
 <7v1v5tpa7b.fsf@alter.siamese.dyndns.org>
 <20101215062403.GA20492@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Peter van der Does <peter@avirtualhome.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Marc Branchaud <marcnarc@xiplink.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 07:43:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSl4q-00018v-R2
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 07:43:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237Ab0LOGmu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 01:42:50 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60862 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222Ab0LOGms convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Dec 2010 01:42:48 -0500
Received: by yxt3 with SMTP id 3so859744yxt.19
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 22:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=VKE1J3E+ZAvd2g6Vh57+/NWaqHMlP7MtVJ/HlwBp7oM=;
        b=YK/faEvmv4JTal8J3QrEiIUb4oFDMFMdJtAPyBY9AUTLJurFmfLmKjbgr+izIgI8mx
         fba25c9te09eU81YDgycxL/8c23bb3vsKjtJf9RKW7XeNjFbFK95l2sMNmdVQbP5Ydp+
         lsUJMZpvpsImxH2AlDUPZkMH3zZzYeSSTv5xY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=AY+WmyeMGgxVjFgNxj6Uth80Ovann8pGaKc8q5xAdLnHJWy7ktQ3JXZp5U2T4mdAWD
         Lf1+/MW9EtYm/HfIhfp6vAFv4o4+yfYZnRhTP824nHlufkFjSYw3yQmi7R0Zop3yfq/n
         gDRjxnVm4P3TcbNwK3IBfajx9CfYw4TwXaF0Q=
Received: by 10.151.26.1 with SMTP id d1mr9518473ybj.295.1292395367634;
        Tue, 14 Dec 2010 22:42:47 -0800 (PST)
Received: from burratino (adsl-69-209-48-248.dsl.chcgil.ameritech.net [69.209.48.248])
        by mx.google.com with ESMTPS id v8sm645467yba.14.2010.12.14.22.42.45
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 14 Dec 2010 22:42:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101215062403.GA20492@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163736>

* 'master' (early part): (529 commits)
  completion: fix zsh check under bash with 'set -u'
  Fix copy-pasted comments related to tree diff handling.
  Git 1.7.3.2
  {cvs,svn}import: use the new 'git read-tree --empty'
  t/t9001-send-email.sh: fix stderr redirection in 'Invalid In-Reply-To=
'
  Clarify and extend the "git diff" format documentation
  git-show-ref.txt: clarify the pattern matching
  documentation: git-config minor cleanups
  Update test script annotate-tests.sh to handle missing/extra authors
  ...

Conflicts:
	GIT-VERSION-GEN
	RelNotes
	contrib/completion/git-completion.bash
---
Suggestions for further work:

 - check edge cases:

	git log --pretty m<tab><tab>		should complete formats
	git log --pretty =3D<tab><tab>		should complain
	git log --pretty=3D m<tab><tab>		should complete commits

 - use a custom function to avoid repeating

	_get_comp_words_by_ref -n =3D:

   As an application, consider teaching git to complete

	git show HEAD@{<tab><tab>		completes to numbers and "upstream"

   Would the argument to -n need an @ for that?

 - get the zsh completion to actually work. :)  Even without this
   series, it seems it is willing to complete subcommand names and
   switches for git but nothing more.

 - adopt the rest of bash_completion's _get_comp_words_by_ref logic,
   so

	git log --pretty=3Dm<cursor>master <tab><tab>

   completes formats starting with 'm', not formats starting with 'mmas=
ter'.

If something turned out buggy, I'd be glad to fix it, but aside from
that I probably will not be working much more on this topic.  (Perhaps
an actual tab completion user would have a better sense of which
aspects are worth working on.)  Please feel free to pick it up and run
in whatever direction you please.

Good night,
Jonathan

diff --cc contrib/completion/git-completion.bash
index 1747091,168669b..d117055
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@@ -321,135 -327,6 +327,162 @@@ __gitcomp_1 (
  	done
  }
 =20
 +# The following function is based on code from:
 +#
 +#   bash_completion - programmable completion functions for bash 3.2+
 +#
 +#   Copyright =C2=A9 2006-2008, Ian Macdonald <ian@caliban.org>
 +#             =C2=A9 2009-2010, Bash Completion Maintainers
 +#                     <bash-completion-devel@lists.alioth.debian.org>
 +#
 +#   This program is free software; you can redistribute it and/or mod=
ify
 +#   it under the terms of the GNU General Public License as published=
 by
 +#   the Free Software Foundation; either version 2, or (at your optio=
n)
 +#   any later version.
 +#
 +#   This program is distributed in the hope that it will be useful,
 +#   but WITHOUT ANY WARRANTY; without even the implied warranty of
 +#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 +#   GNU General Public License for more details.
 +#
 +#   You should have received a copy of the GNU General Public License
 +#   along with this program; if not, write to the Free Software Found=
ation,
 +#   Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 +#
 +#   The latest version of this software can be obtained here:
 +#
 +#   http://bash-completion.alioth.debian.org/
 +#
 +#   RELEASE: 2.x
 +
 +# This function can be used to access a tokenized list of words
 +# on the command line:
 +#
 +#	__git_reassemble_comp_words_by_ref '=3D:'
 +#	if test "${words_[cword_-1]}" =3D -w
 +#	then
 +#		...
 +#	fi
 +#
 +# The argument should be a collection of characters from the list of
 +# word completion separators (COMP_WORDBREAKS) to treat as ordinary
 +# characters.
 +#
 +# This is roughly equivalent to going back in time and setting
 +# COMP_WORDBREAKS to exclude those characters.  The intent is to
 +# make option types like --date=3D<type> and <rev>:<path> easy to
 +# recognize by treating each shell word as a single token.
 +#
 +# It is best not to set COMP_WORDBREAKS directly because the value is
 +# shared with other completion scripts.  By the time the completion
 +# function gets called, COMP_WORDS has already been populated so loca=
l
 +# changes to COMP_WORDBREAKS have no effect.
 +#
 +# Output: words_, cword_, cur_.
 +
 +__git_reassemble_comp_words_by_ref()
 +{
 +	local exclude i j first
 +	# Which word separators to exclude?
 +	exclude=3D"${1//[^$COMP_WORDBREAKS]}"
 +	cword_=3D$COMP_CWORD
 +	if [ -z "$exclude" ]; then
 +		words_=3D("${COMP_WORDS[@]}")
 +		return
 +	fi
 +	# List of word completion separators has shrunk;
 +	# re-assemble words to complete.
 +	for ((i=3D0, j=3D0; i < ${#COMP_WORDS[@]}; i++, j++)); do
 +		# Append each nonempty word consisting of just
 +		# word separator characters to the current word.
 +		first=3Dt
 +		while
 +			[ $i -gt 0 ] &&
 +			[ -n "${COMP_WORDS[$i]}" ] &&
 +			# word consists of excluded word separators
 +			[ "${COMP_WORDS[$i]//[^$exclude]}" =3D "${COMP_WORDS[$i]}" ]
 +		do
 +			# Attach to the previous token,
 +			# unless the previous token is the command name.
 +			if [ $j -ge 2 ] && [ -n "$first" ]; then
 +				((j--))
 +			fi
 +			first=3D
 +			words_[$j]=3D${words_[j]}${COMP_WORDS[i]}
 +			if [ $i =3D $COMP_CWORD ]; then
 +				cword_=3D$j
 +			fi
 +			if (($i < ${#COMP_WORDS[@]} - 1)); then
 +				((i++))
 +			else
 +				# Done.
 +				return
 +			fi
 +		done
 +		words_[$j]=3D${words_[j]}${COMP_WORDS[i]}
 +		if [ $i =3D $COMP_CWORD ]; then
 +			cword_=3D$j
 +		fi
 +	done
 +}
 +
 +if ! type _get_comp_words_by_ref >/dev/null 2>&1; then
++if [[ -z ${ZSH_VERSION:+set} ]]; then
 +_get_comp_words_by_ref ()
 +{
 +	local exclude cur_ words_ cword_
 +	if [ "$1" =3D "-n" ]; then
 +		exclude=3D$2
 +		shift 2
 +	fi
 +	__git_reassemble_comp_words_by_ref "$exclude"
 +	cur_=3D${words_[cword_]}
 +	while [ $# -gt 0 ]; do
 +		case "$1" in
 +		cur)
 +			cur=3D$cur_
 +			;;
 +		prev)
 +			prev=3D${words_[$cword_-1]}
 +			;;
 +		words)
 +			words=3D("${words_[@]}")
 +			;;
 +		cword)
 +			cword=3D$cword_
 +			;;
 +		esac
 +		shift
 +	done
 +}
++else
++_get_comp_words_by_ref ()
++{
++	while [ $# -gt 0 ]; do
++		case "$1" in
++		cur)
++			cur=3D${COMP_WORDS[COMP_CWORD]}
++			;;
++		prev)
++			prev=3D${COMP_WORDS[COMP_CWORD-1]}
++			;;
++		words)
++			words=3D("${COMP_WORDS[@]}")
++			;;
++		cword)
++			cword=3D$COMP_CWORD
++			;;
++		-n)
++			# assume COMP_WORDBREAKS is already set sanely
++			shift
++			;;
++		esac
++		shift
++	done
++}
++fi
 +fi
 +
  # __gitcomp accepts 1, 2, 3, or 4 arguments
  # generates completion reply with compgen
  __gitcomp ()
@@@ -2522,10 -2345,13 +2555,15 @@@ _git (
  {
  	local i c=3D1 command __git_dir
 =20
+ 	if [[ -n ${ZSH_VERSION-} ]]; then
+ 		emulate -L bash
+ 		setopt KSH_TYPESET
+ 	fi
+=20
 -	while [ $c -lt $COMP_CWORD ]; do
 -		i=3D"${COMP_WORDS[c]}"
 +	local cur words cword
 +	_get_comp_words_by_ref -n =3D: cur words cword
 +	while [ $c -lt $cword ]; do
 +		i=3D"${words[c]}"
  		case "$i" in
  		--git-dir=3D*) __git_dir=3D"${i#--git-dir=3D}" ;;
  		--bare)      __git_dir=3D"." ;;
@@@ -2568,9 -2394,14 +2606,14 @@@
 =20
  _gitk ()
  {
+ 	if [[ -n ${ZSH_VERSION-} ]]; then
+ 		emulate -L bash
+ 		setopt KSH_TYPESET
+ 	fi
+=20
  	__git_has_doubledash && return
 =20
 -	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
 +	local cur
  	local g=3D"$(__gitdir)"
  	local merge=3D""
  	if [ -f "$g/MERGE_HEAD" ]; then
