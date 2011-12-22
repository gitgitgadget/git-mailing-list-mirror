From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC/PATCH] i18n of multi-line messages
Date: Thu, 22 Dec 2011 18:07:57 +0100
Message-ID: <871urwsff6.fsf@thomas.inf.ethz.ch>
References: <7vr4zxeaz5.fsf@alter.siamese.dyndns.org>
	<CACBZZX7bgjFz7mvTySPKhR24coqOeVVy8+CsKHVj8Q3LF_-5ww@mail.gmail.com>
	<7vmxale9so.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 22 18:08:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rdm7m-0005Qh-LI
	for gcvg-git-2@lo.gmane.org; Thu, 22 Dec 2011 18:08:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755470Ab1LVRIF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Dec 2011 12:08:05 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:4166 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751966Ab1LVRIE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Dec 2011 12:08:04 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 22 Dec
 2011 18:07:59 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 22 Dec
 2011 18:08:00 +0100
In-Reply-To: <7vmxale9so.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 21 Dec 2011 16:20:55 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187609>

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I think the easiest way to tackle that sort of thing is to just do:
>>
>>     _("hint: %.*s\n")
>>
>> And have a TRANSLATORS comment indicating that the format string
>> should be kept, but that translators can move around the "hint", GNU
>> gettext also has a msgcheck feature to check that format strings are
>> compatible in the translations.
>
> Good point. Thanks.

Note that your commit message in pu still says

     - append each line in the result to localization of the "hint: " p=
refix.

even though you now fixed that to be more general.


(It also has a very weird case of mixed indentation when I view it with
'git show':

        advise(_("Please rename %s to something else"), gostak);
            advise(_("so that we can avoid distimming %s unnecessarily.=
"), doshes);

Apparently the first line is indented with a tab, and the second with 8
spaces.)

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
