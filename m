From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] Update Japanese translation (Git-gui)
Date: Thu, 18 Jul 2013 11:39:19 -0700
Message-ID: <7vzjtj1zmw.fsf@alter.siamese.dyndns.org>
References: <CAPM==H+fCx3k-iL2x4GQLtVxg662CqiPuD0g4v2+_a8MTrG4gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org
To: =?iso-2022-jp?B?GyRCMC1LYkxuNkxDY0w1GyhC?= 
	<devil.tamachan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 20:39:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzt6t-000783-1D
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 20:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759125Ab3GRSjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 14:39:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40081 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758775Ab3GRSjW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 14:39:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2676632A2A;
	Thu, 18 Jul 2013 18:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PbD56ib3R1hmTvZMKrA4JYT0GlE=; b=SvXyKS
	Ni5y2xyGAq6bcc2WDYp3VaX69SoOsFbK07HDaBP5dTGd6d8UP7O8d6l2RcTiiumx
	ktZ3w0ysmscfrtDWf5/39R49pgF1PtozMfOXFk/X69CHLe1s9BpqmAuFbOtJDsQ7
	bzZkVLLpUXyivc+AV7xX0fRYupKl1WADAKKqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ulGGrOUbzDsyxyS9l1KgW2GXtKbZ/4j6
	H46la7YAwFe2Z8/Bi1KS6fbX4blH0XyD40Ti4eAUMU23/xb83qhl6uW76AJZZJWl
	7C3TolWKVvDXYPMUSBJIpRdIkU0TQQJEtoX1Oe5n4hPcvBMmVHHqEHzw1KD72GGE
	oGpZtpPXdrY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BD0132A28;
	Thu, 18 Jul 2013 18:39:22 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 60DA232A25;
	Thu, 18 Jul 2013 18:39:21 +0000 (UTC)
In-Reply-To: <CAPM==H+fCx3k-iL2x4GQLtVxg662CqiPuD0g4v2+_a8MTrG4gQ@mail.gmail.com>
	(=?iso-2022-jp?B?IhskQjAtS2JMbjZMQ2NMNRsoQiIncw==?= message of "Fri, 19 Jul
 2013 02:15:50 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5C8A82C0-EFD9-11E2-8C87-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230722>

悪魔野玉茶無  <devil.tamachan@gmail.com> writes:

> @@ -124,26 +127,23 @@ msgstr "コミット予定済、ファイル無し"
>
>  #: git-gui.sh:2087
>  msgid "File type changed, not staged"
> -msgstr "ファイル型変更、コミット未予定"
> +msgstr "ファイルタイプ変更、コミット未予定"

There are good changes like this in this patch, and ...

>  #: git-gui.sh:3095
>  #, tcl-format
>  msgid "fatal: cannot stat path %s: No such file or directory"
> -msgstr ""
> -"致命的: パス %s が stat できません。そのようなファイルやディレクトリはありま"
> -"せん"
> +msgstr "致命的: パス %s が stat できません。そのようなファイルやディレクトリはありません"

dubious ones like this (there is no change to the string, just the
way msgstr is formatted to make them all overlong single strings).

>  #: git-gui.sh:2088 git-gui.sh:2089
> -#, fuzzy
>  msgid "File type changed, old type staged for commit"
> -msgstr "ファイル型変更、コミット未予定"
> +msgstr "ファイルタイプ変更、コミット予定の形式が古い"

Is this correct?  I do not personally use git-gui, but I _think_
this message is given when you did something like this:

	edit file ;# "file" is a regular file
        git add file
        rm file
        ln -s something file ;# "file" is now a symbolic link

at this point, "git status" would say "MT file".  The latter half of
the translated Japanese reads "format planned to commit is ancient".

Perhaps "元のファイルタイプでの変更をコミット予定済", or something?

In any case, I think the organization of the series should be

	[PATCH 1/3] git-gui: mark yes/no/ask for translation

which is your 3/4, and then

	[PATCH 2/3] git-gui: update git-gui/po/git-gui.pot

which is your 1/4, and then

	[PATCH 3/3] git-gui: update Japanese translation

which is all the changes to git-gui/po/ja.po in your 2/4 and 4/4.

Also I forgot to notice when I was reading the earlier patches, but
git-gui has a separate root commit, so please base your work on
Pat Thoyts's tree at:

    git://repo.or.cz/git-gui

Thanks.
