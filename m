From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 16:58:01 -0400
Message-ID: <q2t32541b131005071358p2abd2fc2la2f128e8ab721882@mail.gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> 
	<7v4oijhdsi.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1005071007320.901@i5.linux-foundation.org> 
	<alpine.LFD.2.00.1005071147460.901@i5.linux-foundation.org> 
	<n2k32541b131005071211sb2411334v4f0919abfeb4cbb7@mail.gmail.com> 
	<alpine.LFD.2.00.1005071213550.901@i5.linux-foundation.org> 
	<i2i32541b131005071235z64c9de56w29a2d555cf801c9a@mail.gmail.com> 
	<alpine.LFD.2.00.1005071240590.901@i5.linux-foundation.org> 
	<g2s32541b131005071258s92e058bakc8f3a4df1e1dc634@mail.gmail.com> 
	<alpine.LFD.2.00.1005071303040.901@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org, hasan.aljudy@gmail.com,
	kusmabite@googlemail.com, prohaska@zib.de
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 07 22:58:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAUcu-0002Kf-NS
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 22:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756196Ab0EGU6X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 16:58:23 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:55420 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756103Ab0EGU6W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 16:58:22 -0400
Received: by yxe1 with SMTP id 1so1046991yxe.33
        for <git@vger.kernel.org>; Fri, 07 May 2010 13:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=4VO+7asUcwjptvfUkjhFENi2qSOXragaQ0wmis7gmqg=;
        b=xeEjppJRrQ0l6KArBGAVUtjMff4QA1PZY6z63jkb1DEqnAHpFKgyr9+kLZpUnDolzP
         QQ/OQ259RbHQO4vpDjFmGJzxtfpX7uPL8oSvLnk5iaIKJ11qnRcrIV+tfsqF+Tpw/wS5
         uBISADehcp+ivlM9KgvmEBQ1ycHk99MNfH5DI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=o8+LopH27A/0DjBAoofZtmFJCZyXhDPSI6dqZpSd3k07tIQ5XftbVqh+DmbqAl5Ohq
         1fqtvEvU/j+fJ//afh+kEQTcIhdx8L4y59DMbxCw5+C1SsWsnu1v0fV0Rl5e465FZQRJ
         4m4BCA76uq4SfgdLARkg0467+U7DdWdCtqaOU=
Received: by 10.150.237.9 with SMTP id k9mr4090044ybh.155.1273265901385; Fri, 
	07 May 2010 13:58:21 -0700 (PDT)
Received: by 10.150.217.12 with HTTP; Fri, 7 May 2010 13:58:01 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1005071303040.901@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146595>

On Fri, May 7, 2010 at 4:06 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, 7 May 2010, Avery Pennarun wrote:
>> No! =A0The whole point is that each user *does* still want to be abl=
e to
>> decide how to convert the files tagged by the crlf gitattribute (or =
a
>> new attribute, I don't care).
>
> Avery, you really don't _get_ it, do you?

I was going to say that I do get it, but I guess I didn't.  You're
right, your proposal is functionally equivalent.  Feel free to stop
reading the rest of this post :)

=46or the benefit of those who might have misunderstood as I did, the
reason they're equivalent is that "core.eolStyle =3D LF" is the same as
saying "never do EOL conversion" since an unconverted file is
implicitly LF.  And there is already a way to say "never do EOL
conversion," which is to set core.autocrlf=3DFalse.

By adding core.autocrlf=3DTrue to an in-project .gitconfig file, we can
fix a mistake in the original definition of the crlf attribute, ie.,
it should be able to force CRLF conversion even when a user hasn't set
core.autocrlf explicitly.  But that new ability doesn't take away a
person's ability to override it globally because .git/config and
~/.gitconfig take precedence.  Notably, this solution doesn't break
any backward compatibility.

Linus's second proposed option would be to slightly change the way the
crlf attribute works, by making core.autocrlf a tri-state variable
instead of just true/false.  "Undefined" would mean "use the crlf
attribute" where currently it means (rather unhelpfully) "always use
LF even if .gitattributes says otherwise."  However, this would be a
backward-incompatible change.  Arguably, not one that anyone would
care about.  (For the record, none of my co-workers would care.  The
current behaviour is sufficiently unhelpful that we have to use
core.autocrlf=3DTrue anyway, so .gitattributes crlf hasn't been useful.=
)

Now, arguably, the current semantics, and even Linus's proposed
improved semantics, are still pretty hard to explain.  "This file
should always be unchanged" and "this file should always use native
line endings" and "this is my native line ending style" is very simple
and straightforward.  But I'm sure others would argue the opposite,
and it's just a matter of preference.

Have fun,

Avery
