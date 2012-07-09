From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Student project in Ensimag: thanks all!
Date: Mon, 09 Jul 2012 10:11:10 -0700
Message-ID: <7vbojolv0x.fsf@alter.siamese.dyndns.org>
References: <vpq7gudxg9h.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>,
	Kim Thuat NGUYEN <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	Javier ROUCHER IGLESIAS 
	<Javier.Roucher-Iglesias@ensimag.imag.fr>,
	Pavel VOLEK <Pavel.Volek@ensimag.imag.fr>,
	Simon CATHEBRAS <Simon.Cathebras@ensimag.imag.fr>,
	Julien KHAYAT <Julien.Khayat@ensimag.imag.fr>,
	Simon PERRAT <Simon.Perrat@ensimag.imag.fr>,
	Charles ROUSSEL <Charles.Roussel@ensimag.imag.fr>,
	Guillaume SASDY <Guillaume.Sasdy@ensimag.imag.fr>,
	Valentin DUPERRAY <Valentin.Duperray@phelma.grenoble-inp.fr>,
	Franck JONAS <Franck.Jonas@phelma.grenoble-inp.fr>,
	Lucien KONG <Lucien.Kong@phelma.grenoble-inp.fr>,
	Thomas NGUY <Thomas.Nguy@phelma.grenoble-inp.fr>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@phelma.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 09 19:11:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoHUe-0004UT-V0
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 19:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648Ab2GIRLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 13:11:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61050 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549Ab2GIRLN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 13:11:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 930349AB1;
	Mon,  9 Jul 2012 13:11:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kPR7+mh+CpaZ/gQQFCoFKOmwFG0=; b=cTiKQ+
	9wNRXpz8smZeeFJefMH8kLwxhaRixqepOqDukoHTEbMIErnXKd2DLdm6rUWlpjeG
	LNftSV8eBI+q3XqkdEYxPE2WoGy91TlXSOD65TIkzRHq/KfqbRli7LdZVhfqNwUJ
	MvCdVPx8VHLvA3j+jhrDw447cVfLIZPvlcTS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xG7gEv5KLeyOx4ChdhNyjbP87E7YbNEo
	jnWXu+wXobdSQHP9ECFkMXbypklI6799eBx8rTyPoxnhGVXbLEcLo5RvwY6XgZ8V
	lQx1E3924GpFek4dH7hHZgCPm1PVTMZMAxUQrzUQaOPgZe2C2FI88ca3YsIyzD8C
	huWPz/5MGhU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86A959AB0;
	Mon,  9 Jul 2012 13:11:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1734E9AAF; Mon,  9 Jul 2012
 13:11:12 -0400 (EDT)
In-Reply-To: <vpq7gudxg9h.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon, 09 Jul 2012 14:36:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 15663DEC-C9E9-11E1-A678-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201211>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> For the third year, I offered my students to contribute to open-source
> software as part of a school project. This year, we had one team on the
> core of Git (who implemented better advices for "git status", the XDG
> configuration directory, and "git rebase -i --exec"), and two working on
> the Git-mediawiki interface (one worked on new features like support for
> mediafiles and authentication using the git credentials mechanism, and
> another on an automated testsuite).
>
> The project itself ended a while ago, but some of the patch series
> needed extra care to end up in pu. This is now done :-).

Thanks for introducing your students to the development community.
I enjoyed interactions with new contributors, wish them luck, and
hope (at least some of) them who are interested to remain here.

> A few series have been abandoned ("bisect old/new", and "warn before
> rebase/commit"), I've added pointers to the gmane threads on the page
> https://git.wiki.kernel.org/index.php/SmallProjectsIdeas
> in case someone wants to continue the work.

Thanks.
