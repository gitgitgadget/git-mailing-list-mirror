From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 11 new messages
Date: Mon, 28 Jan 2013 18:55:14 +0100
Message-ID: <20130128175514.GA2926@rath-ubuntu>
References: <1359353699-3987-1-git-send-email-ralf.thielow@gmail.com>
 <87sj5l38d6.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jk@jk.gs, stimming@tuhh.de, git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 28 18:55:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzsvl-0005U1-U3
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 18:55:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757655Ab3A1RzV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jan 2013 12:55:21 -0500
Received: from mail-bk0-f45.google.com ([209.85.214.45]:52785 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757661Ab3A1RzT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 12:55:19 -0500
Received: by mail-bk0-f45.google.com with SMTP id i18so1515478bkv.32
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 09:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=IbS7m5Rwx7VYCS882AW06RMQZG7Zyv3q2eZC3qmxlm0=;
        b=pFtgxV0sA7iBhpk/hrXEcajoMP1PvAt8PhJNAHQH13JFFZZSr3ytV+suGehbxPf9UI
         bd+rL6gVZ01XsyyeVf599WCCQmlP12JgieHpm8uv7LD2b7q3JnPZcTfUaFgT429iSgow
         HHhUgM+D37TOStWl4HihIQpMMJDmHdx9TzQXG4We7jwinfa5rucsGldDVNau1MhQ1hQ8
         Bih99jfCFmsCe8XS86H3lv6HU+rHRde1ZZTI4QWW2fGrBdt7bEpvL84MXjHnkSf2dvqr
         m5yc5TjjnBPOI632RtxiCzZUNrltBMZAzUMz92Gp0mGUGEtFA5AtbVIEWOnCr9cxF4Nc
         nMKw==
X-Received: by 10.204.12.206 with SMTP id y14mr4166343bky.132.1359395717990;
        Mon, 28 Jan 2013 09:55:17 -0800 (PST)
Received: from rath-ubuntu (dslb-094-222-138-000.pools.arcor-ip.net. [94.222.138.0])
        by mx.google.com with ESMTPS id ho6sm7003879bkc.0.2013.01.28.09.55.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Jan 2013 09:55:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87sj5l38d6.fsf@pctrast.inf.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214844>

On Mon, Jan 28, 2013 at 11:33:09AM +0100, Thomas Rast wrote:
> Ralf Thielow <ralf.thielow@gmail.com> writes:
>=20
> >  #: builtin/reset.c:275
> > -#, fuzzy, c-format
> > +#, c-format
> >  msgid "Failed to resolve '%s' as a valid revision."
> > -msgstr "Konnte '%s' nicht als g=FCltige Referenz aufl=F6sen."
> > +msgstr "Konnte '%s' nicht als g=FCltige Revision aufl=F6sen."
>=20
> You don't have "revision" in the glossary[1] yet.  Wouldn't it be
> appropriate to treat it as "commit", and translate as "Version" to av=
oid
> introducing yet another term?
>=20
> Or am I missing some subtle distinction between commit and revision?
>=20

I don't think there's a distinction. Since we've already translated
"revision" as "Revision" in a couple of other messages, I'll make a
new "s/Revision/Version" commit on top.

> Since it's only a single nit, feel free to add my ack when you reroll=
:
>=20
> Acked-by: Thomas Rast <trast@inf.ethz.ch>
>=20
>=20
> [1] https://github.com/ralfth/git-po-de/wiki/Glossary
>=20
> --=20
> Thomas Rast
> trast@{inf,student}.ethz.ch
