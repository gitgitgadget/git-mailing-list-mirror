From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config.txt,diff-options.txt: porcelain vs. plumbing for
 color.diff
Date: Wed, 27 Apr 2011 11:30:16 -0700
Message-ID: <7vliyv7djb.fsf@alter.siamese.dyndns.org>
References: <7voc3sewpg.fsf@alter.siamese.dyndns.org>
 <24a6907cade7aedb51dc20ab5977603ca21e70bb.1303889849.git.git@drmicha.warpmail.net> <20110427090323.GA14849@elie> <7v7hafabsj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 20:30:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF9VR-0005FO-7P
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 20:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756702Ab1D0Sa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 14:30:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56131 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756214Ab1D0Sa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 14:30:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D0BD34458;
	Wed, 27 Apr 2011 14:32:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6ca4bC5V4UDu8y9VeinyWpX+U7I=; b=GwCmeS
	PjFaHagpPpECXN5CdXosEsGR7WWm+kEmPDjCgXYu/oYSETzn6viz9rIMUQKqSFce
	ylfoGy/NwVpYl9Q3FEYWEiOZLuRVRSTjj7bpjY3vVrTKUwWznN79iQQd9Kd4Ntij
	WnrBYcVqy2EYDma3aJQPR8Ju2BKLSCwRHHybo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yErl4XSHCKNVRyNHHVigxcufsfd1X0LA
	tyEzYQTgvIYnANu1kkCa+RHw2XUWsR//gcDte6EAHvGqmSwGGZ+iROrWlgsLhlAy
	1mQrqaCgF68yFdCXvDnV1CEkr5J0hTtXGNcwXcsZTBYNNtCYj7Cw6fGtWnc8EqWd
	5rqjW40eeX8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9FAE34455;
	Wed, 27 Apr 2011 14:32:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 48984444E; Wed, 27 Apr 2011
 14:32:21 -0400 (EDT)
In-Reply-To: <7v7hafabsj.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 27 Apr 2011 09:39:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B2D8DAD6-70FC-11E0-AC39-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172258>

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Michael J Gruber wrote:
>>
>>> Reading the diff-family and config man pages one may think that the
>>> color.diff and color.ui settings apply to all diff commands. Make it
>>> clearer that they do not apply to the plumbing variants
>>> diff-{files,index,tree}.
>>
>> Sounds like a good idea.  Quick reactions:
>> ...
>> Thanks, and hope that helps.
>
> Your text reads better at least to me.

I'll queue the following.

-- >8 --
From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] config.txt,diff-options.txt: porcelain vs. plumbing for color.diff

Reading the diff-family and config man pages one may think that the
color.diff and color.ui settings apply to all diff commands. Make it
clearer that they do not apply to the plumbing variants
diff-{files,index,tree}.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt       |   27 +++++++++++++++++++--------
 Documentation/diff-options.txt |   15 +++++++++++----
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 750c86d..3967b1a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -708,9 +708,16 @@ second is the background.  The position of the attribute, if any,
 doesn't matter.
 
 color.diff::
-	When set to `always`, always use colors in patch.
-	When false (or `never`), never.  When set to `true` or `auto`, use
-	colors only when the output is to the terminal. Defaults to false.
+	Whether to use ANSI escape sequences to add color to patches.
+	If this is set to `always`, linkgit:git-diff[1],
+	linkgit:git-log[1], and linkgit:git-show[1] will use color
+	for all patches.  If it is set to `true` or `auto`, those
+	commands will only use color when output is to the terminal.
+	Defaults to false.
++
+This does not affect linkgit:git-format-patch[1] nor the
+'git-diff-{asterisk}' plumbing commands.  Can be overridden on the
+command line with the `--color[=<when>]` option.
 
 color.diff.<slot>::
 	Use customized color for diff colorization.  `<slot>` specifies
@@ -796,11 +803,15 @@ color.status.<slot>::
 	color.branch.<slot>.
 
 color.ui::
-	When set to `always`, always use colors in all git commands which
-	are capable of colored output. When false (or `never`), never. When
-	set to `true` or `auto`, use colors only when the output is to the
-	terminal. When more specific variables of color.* are set, they always
-	take precedence over this setting. Defaults to false.
+	This variable determines the default value for variables such
+	as `color.diff` and `color.grep` that control the use of color
+	per command family. Its scope will expand as more commands learn
+	configuration to set a default for the `--color` option.  Set it
+	to `always` if you want all output not intended for machine
+	consumption to use color, to `true` or `auto` if you want such
+	output to use color when written to the terminal, or to `false` or
+	`never` if you prefer git commands not to use color unless enabled
+	explicitly with some other configuration or the `--color` option.
 
 commit.status::
 	A boolean to enable/disable inclusion of status information in the
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index c93124b..c26e494 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -120,12 +120,19 @@ any of those replacements occurred.
 
 --color[=<when>]::
 	Show colored diff.
-	The value must be always (the default), never, or auto.
+	The value must be `always` (the default for `<when>`), `never`, or `auto`.
+	The default value is `never`.
+ifdef::git-diff[]
+	It can be changed by the `color.ui` and `color.diff`
+	configuration settings.
+endif::git-diff[]
 
 --no-color::
-	Turn off colored diff, even when the configuration file
-	gives the default to color output.
-	Same as `--color=never`.
+	Turn off colored diff.
+ifdef::git-diff[]
+	This can be used to override configuration settings.
+endif::git-diff[]
+	It is the same as `--color=never`.
 
 --word-diff[=<mode>]::
 	Show a word diff, using the <mode> to delimit changed words.
-- 
1.7.5.208.g75460
