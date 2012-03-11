From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re*: [PATCH/RFC] Change t0204-gettext-reencode-sanity.sh to pass
 under Mac OSX
Date: Sun, 11 Mar 2012 14:38:42 -0700
Message-ID: <7vzkbmvmvx.fsf@alter.siamese.dyndns.org>
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
 <4F5D14CD.6080507@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Mar 11 22:38:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6qTb-0001Ej-74
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 22:38:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461Ab2CKVir convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Mar 2012 17:38:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44506 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753217Ab2CKVip convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Mar 2012 17:38:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CB727F63;
	Sun, 11 Mar 2012 17:38:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=c9X6zC1eqiUk
	iz9p/TADHfNRV6M=; b=MEUm4PR5FqstWeYZXuTsD5b4XLpR7IKKS793jqvf+xj7
	7wfrXyYacM8kYcDURV81qu6102VJOCOel+ULw7QXKAohLp1f1XfsDIBA+PJ0fx/b
	FSMDis8jLykQZgoIeeyaqxwmP59wkEZZA0WQoxK/olhTUX4oD/evms418U7OTHE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dgKLDG
	vzgH2/PEo5btc+Y8436nGxui3KFzpSazzbV7rlicJ1M+mXGsb/uGg9trxx0zpQ3N
	lZ1hAWikdbpz+sPNmkK/5+hq575ktZpK7AWrpx1/LNaLVKLCJONTLUf66qnQA99v
	7zfkeMF+Juk4aBujdMQQbI4NoMwNCSm7mXocc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5402A7F62;
	Sun, 11 Mar 2012 17:38:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AFF057F61; Sun, 11 Mar 2012
 17:38:43 -0400 (EDT)
In-Reply-To: <4F5D14CD.6080507@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Sun, 11 Mar 2012 22:10:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9352879A-6BC2-11E1-A7F4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192832>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 03/11/2012 08:22 PM, Junio C Hamano wrote:
> ...
>>   * Is USE_GETTEXT_SCHEME=3Dgnu the right thing for Mac OS X?  It ma=
y
>>     make this test pass, but does it not break other things?  Does
>>     Mac OS X come with a working gettext.sh to help i18n of shell
>>     scripts?  Does it also give eval_gettext?
> When I remember it right, the following comes from the Fink
> installation on my machine:
> which gettext
> /sw/bin/gettext
>
> which gettext.sh
> /sw/bin/gettext.sh
>
> None of the machines here (Mac OS X, Ubuntu 10.04.4 LTS, OpenSuse 12.=
1)
> has a eval_gettext

No, we do not expect a standalone eval_gettext program.  If you
dot-source gettext.sh, some systems give you the eval_gettext shell
function, while there are other systems that don't.  Gnu systems
that ship with /usr/bin/gettext.sh do give you eval_gettext while
Solaris is known not to. I do not know what your system does, and
that was what the question was about.  What does this say there?

	$ (. gettext.sh; eval_gettext frotz; echo $?)

>>   * If so, Mac OS X users shouldn't have to say that from the comman=
d
>>     line of "make". Do we need a Makefile update?
> Good question.
> I couldn't find any setup of USE_GETTEXT_SCHEME in Makefile
> (except when NO_GETTEXT is set), do I need to run configure?
> So far the Makefile worked for all my systems here.

You shouldn't have to muck with autoconf around here. It is one of
the design goals of our Makefile to work out of the box on major
platforms as long as the prerequisites like POSIX compliant tools
and use of GNU make are met. An optional configure support comes
into the picture only once we know what we want to have in the
Makefile to be tweaked.

Also, as you noticed, even though we mention USE_GETTEXT_SCHEME in
the Makefile, no platforms with explicit support needs to tweak it;
if git-sh-i18n.sh can figure out what to do without having to rely
on any tweak in the Makefile, we would prefer to keep it that way.

What is curious about your system is that git-sh-i18n.sh should have
figured out that you want INTERNAL_GETTEXT_SH_SCHEME to be gnu by
itself, without any need for "make USE_GETTEXT_SCHEME=3Dgnu", with
these lines:

                ...
        elif type gettext.sh >/dev/null 2>&1
        then
                # GNU libintl's gettext.sh
                GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dgnu
        elif test ...

as long as you have /sw/bin/gettext.sh on your PATH, that is.

So I am not sure what's broken.

>>   * If not, what is the appropriate value for USE_GETTEXT_SCHEME on=3D
>>     Mac OS X?  If the answer is not "fallthrough", do we need a
>>     Makefile update?
> My guess is that "gettext_without_eval_gettext" would be right
> (if we have Fink installed)

Are you sure that after dot-sourcing /sw/bin/gettext.sh, you do not
have eval_gettext?  If you do, then I think it can be set to gnu.

=C3=86var, I am wondering if the auto-detection part of git-sh-i18n
should read more like this to make sure when we declare gnu we know
eval_gettext is available.  What do you think?

 git-sh-i18n.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index d5fae99..a17688b 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -27,7 +27,7 @@ then
 elif test -n "$GIT_GETTEXT_POISON"
 then
 	GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dpoison
-elif type gettext.sh >/dev/null 2>&1
+elif (. gettext.sh && eval_gettext frotz) >/dev/null 2>&1
 then
 	# GNU libintl's gettext.sh
 	GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dgnu
