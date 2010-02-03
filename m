From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-gui translation updates needed
Date: Tue, 02 Feb 2010 17:09:35 -0800
Message-ID: <7vy6jbunu8.fsf@alter.siamese.dyndns.org>
References: <20100201151647.GB8916@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 03 02:09:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcTka-0005yK-Ui
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 02:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756024Ab0BCBJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 20:09:44 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42860 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754808Ab0BCBJn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 20:09:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7502496BB6;
	Tue,  2 Feb 2010 20:09:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ilagRkTKyf1FbGdqN4pH9dAURK8=; b=IHMgjb
	DbZMG/6vVyp3ZTJzD5v5hJfFsj/nYGmFtrjFfQ3Wt+X8crq6mYxDgW17nVS+ulUX
	4VgIlTgYRcWmP1Axn0elO58/S1q8DMmcn4hP4Zr7LXwpOI/5Sy1z9gpFPIyGbeNR
	XQS4kZfI69KD8/GWLfc92P1M4AZtG9i4IliuY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U4joyII2qpsEwIBNsYxZupCSADGUyVKR
	oYGmMAIX3cUy4arBFE1FznIBcKZdyVNEklAVAEL6rRwoKQKjOHnq9brKnFyLIp8z
	J8pJ1KJzLrIhTQwE5vVfdhehnjsih7kxlT9z3y5fJksInom8wlmNvq5aSIo9GVaQ
	UwEWMfmieAo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5347B96BB3;
	Tue,  2 Feb 2010 20:09:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8127696BB2; Tue,  2 Feb
 2010 20:09:36 -0500 (EST)
In-Reply-To: <20100201151647.GB8916@spearce.org> (Shawn O. Pearce's message
 of "Mon\, 1 Feb 2010 07\:16\:47 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CD627B62-1060-11DF-BEAB-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138795>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> git-gui has picked up a few new strings.  Junio and I would like
> to see the new version in git 1.7.0, which means we need to get
> the new messages translated.
>
> If you maintain a translation file for git-gui, please grab the
> latest sources and send a patch for your .po file:
>
>   git://git.spearce.org/git-gui.git master
>
> Thus far I think I have German, Italian and Swedish (thanks Christian
> Stimming, Christian Stimming, Christian Stimming).

I grabbed the current one and took a quick look.

"git grep POT-Creation-Date" reveals:

el.po		"POT-Creation-Date: 2008-03-14 07:18+0100\n"
zh_cn.po        "POT-Creation-Date: 2008-03-14 07:18+0100\n"
nb.po		"POT-Creation-Date: 2008-11-16 13:56-0800\n"
hu.po		"POT-Creation-Date: 2008-12-08 08:31-0800\n"
ru.po		"POT-Creation-Date: 2008-12-08 08:31-0800\n"

git-gui.pot	"POT-Creation-Date: 2010-01-26 15:47-0800\n"
fr.po		"POT-Creation-Date: 2010-01-26 15:47-0800\n"
it.po		"POT-Creation-Date: 2010-01-26 15:47-0800\n"
ja.po		"POT-Creation-Date: 2010-01-26 15:47-0800\n"
sv.po		"POT-Creation-Date: 2010-01-26 15:47-0800\n"
de.po		"POT-Creation-Date: 2010-01-26 22:22+0100\n"

The build says:

    MSGFMT    po/el.msg 381 translated, 4 fuzzy, 6 untranslated.
    MSGFMT po/zh_cn.msg 366 translated, 7 fuzzy, 17 untranslated.
    MSGFMT    po/nb.msg 474 translated, 39 untranslated.
    MSGFMT    po/hu.msg 514 translated.
    MSGFMT    po/ru.msg 513 translated, 2 untranslated.
    MSGFMT    po/it.msg 519 translated, 1 untranslated.

A few observations:

 - It is curious that de.po is based on a version of .pot that is
   different from the official git-gui.pot, even though it seems to be
   up-to-date (no, I don't read German, but running "msgmerge -U po/de.po
   po/git-gui.pot" doesn't seem to detect anything missing).

   Build log for "de" also says that has 520 messages all translated.

 - I am seeing "1 untranslated", even though it.po is based on the latest
   git-gui.pot.  It translates "buckets" to an empty string; somebody who
   care about Italian may need to double check.

 - Greek and Chinese are way out of date and Nowegian, Hungarian, and
   Russian are more than one year old.

If people who can read/write Greek, Chinese, Nowegian, Hungarian, or
Russian and who do use git-gui on regular basis want to step forward to
help, it is the time.

Thanks.
