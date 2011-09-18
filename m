From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC] fast-import: note deletion command
Date: Sun, 18 Sep 2011 22:39:40 +0200
Message-ID: <CAGdFq_hpA95Kj4eMr4e1duuXTpr+OkkwF4K5bTapXEi9UjWcSA@mail.gmail.com>
References: <CA+gfSn9sdTzQghqQp6hcO-9kN9mPx2JLRig79Rgx2FqGWXXp=A@mail.gmail.com>
 <20110918203506.GG2308@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Ivankov <divanorama@gmail.com>,
	Git List <git@vger.kernel.org>,
	David Barr <davidbarr@google.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Johan Herland <johan@herland.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 18 22:40:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5OA6-00035W-AX
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 22:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457Ab1IRUkV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Sep 2011 16:40:21 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:33815 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932227Ab1IRUkV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2011 16:40:21 -0400
Received: by yie30 with SMTP id 30so3711585yie.19
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 13:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=QRSMehPyJNgTJE6Chr9gv/xJu0EHeFYxEM9GZlJoKH8=;
        b=O9AVnqq/u1N0HqkToVseJCMDu1XKNfLur/f8ORzulm+jmvDBp/nAvELC48XnCnknBE
         HZy5LC1chhXdehDPMjh+winH4tLbo+8KkV9shq39pGEvb6nKW6NAcN/xu7Qjcyz9Z/rQ
         uilzCUKYkVn4ywJXGdRA55Gq8wbvTFh8ULGtI=
Received: by 10.68.23.97 with SMTP id l1mr3020855pbf.232.1316378420060; Sun,
 18 Sep 2011 13:40:20 -0700 (PDT)
Received: by 10.68.59.39 with HTTP; Sun, 18 Sep 2011 13:39:40 -0700 (PDT)
In-Reply-To: <20110918203506.GG2308@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181636>

Heya,

On Sun, Sep 18, 2011 at 22:35, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
>> ND commit_sha1 # One may think there are also NC, NR, NM
>> N delete commit_sha1
>> # Only :mark, full-40-byte-sha1 and 'inline' are allowed currently.
>> # So no clashes arise, but then one may also want M 'delete' path
>> # command to work too.
>
> If I were doing it:
>
> =C2=A0- advertise "N 0{40} <commit>" as the historical way to delete =
a
> =C2=A0 note, and make sure it keeps working
>
> =C2=A0- introduce 'ND' or 'notedelete <commit>' as a human-friendly
> =C2=A0 synonym, keeping in mind that NC and NR could be introduced in=
 the
> =C2=A0 future if there is demand for them.

Is this perhaps a good moment to also think about branch deletion?
That came up earlier as well, and thinking about that might give us
some insights in how to deal with deletions uniformly.

--=20
Cheers,

Sverre Rabbelier
