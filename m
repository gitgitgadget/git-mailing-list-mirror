From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re*: [PATCH/RFC] Change t0204-gettext-reencode-sanity.sh to pass
 under Mac OSX
Date: Mon, 12 Mar 2012 14:25:05 -0700
Message-ID: <7vmx7lpl5a.fsf@alter.siamese.dyndns.org>
References: <201203052039.16893.tboegi@web.de>
 <7vzkbuzss7.fsf@alter.siamese.dyndns.org>
 <CACBZZX4P=JSdP_vLOMx5r3R+YO8SMSs5W8+vf2DMibKMwBx_Vg@mail.gmail.com>
 <7vfwdkm6xs.fsf@alter.siamese.dyndns.org>
 <CACBZZX4q0Da=H=-fO86f2YN+CmE25QfEgAp8Efmdyf65CGckiQ@mail.gmail.com>
 <7v4nu0m5tb.fsf@alter.siamese.dyndns.org>
 <CACBZZX6W=-ZchaCsLGdpZ420L_9=w8AHD8BNVb7XV5M-hc0Qhg@mail.gmail.com>
 <7vd38okmp0.fsf@alter.siamese.dyndns.org>
 <7vlin94dbc.fsf_-_@alter.siamese.dyndns.org> <4F5BD585.5050007@web.de>
 <4F5CC08C.90703@web.de> <7vzkbnvt6m.fsf@alter.siamese.dyndns.org>
 <4F5D14CD.6080507@web.de> <7vzkbmvmvx.fsf@alter.siamese.dyndns.org>
 <4F5E6362.7050001@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 12 22:25:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Ck1-0007vx-Cs
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 22:25:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757044Ab2CLVZK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Mar 2012 17:25:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39030 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755921Ab2CLVZJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Mar 2012 17:25:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9485179D0;
	Mon, 12 Mar 2012 17:25:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=yJAqLrx6R/Z/
	IVreXRzbhrpxqnY=; b=lpXtciKWzAEFiRegFSWJk77vpIggv2cWXg9MQQl67eKw
	Zs0HTTaH3Zr+2laA42WdlH5hgd4WO3vFiz4Yo6AZqtJZX4tED5tCaT1wr05yg3d8
	QgN7122zsaF2RjlXVCmXOXAC2gU3Q9hIYWwj6CTQHQyRD0TaK5WehMzIQ8lvJZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MqK8jL
	kljcC927JzD8TQdx6mZSP1yNCnq+KEE+RjV45uGDks1Ft33V4jcmbhNoaxDzVVru
	OG29y5EubpFur5JoavOv2bqV/oHiZGTtwe9tTmjo6MpgUHFSNfj9UDsoQG94q04h
	8jkLjbCLOQVZQBfli2aJhfiCl+HJG4+7JrvII=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BC6F79CF;
	Mon, 12 Mar 2012 17:25:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DF0A79CE; Mon, 12 Mar 2012
 17:25:06 -0400 (EDT)
In-Reply-To: <4F5E6362.7050001@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Mon, 12 Mar 2012 21:58:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D6F755E4-6C89-11E1-A82A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192949>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> [snip]
>  (. gettext.sh; eval_gettext frotz; echo $?)
> frotz0

So your system can claim "gnu".  The patch I sent earlier that
replaced "type gettext.sh" with something like the above should work
along that line.

> I get
> : no probing necessary

> When I run the following scriptlet,=20
> ...
> elif test -n "@@USE_FALLTHROUGH_GETTEXT_SCHEME@@$GIT_INTERNAL_GETTEXT=
_TEST_FALLBACKS"
> then
> 		echo ": no probing necessary"

Gaah.  That should read as @@USE_GETTEXT_SCHEME@@, which would be
replaced by the Makefile to become either empty (if you run "make"
without forcing USE_GETTEXT_SCHEME to any particular value).

It comes from ad17ea7 (add a Makefile switch to avoid gettext
translation in shell scripts, 2012-01-23) but nobody replaces the
token anywhere.

http://thread.gmane.org/gmane.comp.version-control.git/188706/focus=3D1=
89016
and comparing it with the original (focus=3D188827 in the same thread),
we can see that this was my mistake while re-rolling the patch.

-- >8 --
Subject: i18n: fix auto detection of gettext scheme for shell scripts

A new code added by ad17ea7 (add a Makefile switch to avoid gettext
translation in shell scripts, 2012-01-23) tried to optionally force
a gettext scheme to "fallthrough", but ended up forcing it to everybody=
=2E

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-sh-i18n.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index d5fae99..6a27f68 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -21,7 +21,7 @@ GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dfallthrough
 if test -n "@@USE_GETTEXT_SCHEME@@"
 then
 	GIT_INTERNAL_GETTEXT_SH_SCHEME=3D"@@USE_GETTEXT_SCHEME@@"
-elif test -n "@@USE_FALLTHROUGH_GETTEXT_SCHEME@@$GIT_INTERNAL_GETTEXT_=
TEST_FALLBACKS"
+elif test -n "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS"
 then
 	: no probing necessary
 elif test -n "$GIT_GETTEXT_POISON"
