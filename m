From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] l10n: Fix to Swedish translation
Date: Tue, 02 Oct 2012 12:39:45 -0700
Message-ID: <7vlifo7jem.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.00.1210020821390.30557@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Oct 02 21:40:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ8Jz-0005w7-Ok
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 21:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294Ab2JBTjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 15:39:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42779 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752051Ab2JBTjs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 15:39:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E77338B23;
	Tue,  2 Oct 2012 15:39:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y+vsSFgQnbwdUAOFbIdOmXUySl0=; b=Yxt1Ui
	5D+C1zgYhYUooLh3cKkGTuln3TfQUYl/asPoHePkS9+/gzpfXNVUZiMMWjTYoFFt
	mW5trSRQ0KtmGLCchUN0sPEPdmlH9IOo0JOiXNSwFP+88mckQbwmEbO8ZMBIZ/9m
	jVVHkEwstngi9LDzwVdPwCGtAnzrQO592pUy0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k/M6fEZDn0pnxMXgDvzXW8+/xgUrDD8m
	mdztm0HRQljo09q2lGBB9n4IU1NYDiJbHogCqAiYBK+ME7UsCMJo6XioJ1Q6jSnE
	BKROEovcbOYoH4FRq1eiqh5my/F8Hk9BjzhnrQ4vZIfz5iG6sA9gp1mpigzy3pdA
	ZD1ygjg1mig=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4C9D8B21;
	Tue,  2 Oct 2012 15:39:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 251748B20; Tue,  2 Oct 2012
 15:39:47 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.00.1210020821390.30557@ds9.cixit.se> (Peter
 Krefting's message of "Tue, 2 Oct 2012 08:25:32 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EC46EF10-0CC8-11E2-96AB-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206839>

Peter Krefting <peter@softwolves.pp.se> writes:

> a fix for the most embarrasing typo in the Swedish translation
> ("Receiveing" became "Deleting"). The fix is already in the big
> pull-request slated for the next feature release, but I would
> appreciate if a 1.17.12.3 did contain this...

Surely, and thanks.  

I do not think there is any issue with conflicting patch or merge
caused by applying this to maint, but I CC'ed Jiang to let him know
what is going on.

>
> diff --git a/po/sv.po b/po/sv.po
> index b327a0e..141b8d5 100644
> --- a/po/sv.po
> +++ b/po/sv.po
> @@ -8,7 +8,7 @@
>  "Project-Id-Version: git 1.7.12\n"
>  "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
>  "POT-Creation-Date: 2012-08-06 23:47+0800\n"
> -"PO-Revision-Date: 2012-08-14 09:58+0100\n"
> +"PO-Revision-Date: 2012-10-02 08:15+0100\n"
>  "Last-Translator: Peter Krefting <peter@softwolves.pp.se>\n"
>  "Language-Team: Swedish <tp-sv@listor.tp-sv.se>\n"
>  "Language: sv\n"
> @@ -3381,7 +3381,7 @@
>
>  #: builtin/index-pack.c:986
>  msgid "Receiving objects"
> -msgstr "Tar bort objekt"
> +msgstr "Tar emot objekt"
>
>  #: builtin/index-pack.c:986
>  msgid "Indexing objects"
