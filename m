From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-core: conflictstyle=diff3 doesn't actually use diff3
 compatible format
Date: Fri, 5 Mar 2010 16:19:50 -0600
Message-ID: <20100305221950.GB5083@progeny.tock>
References: <20100305215253.364.63583.reportbug@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Monnier <monnier@iro.umontreal.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 05 23:20:28 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nnfsd-0004YA-5b
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 23:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821Ab0CEWUE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Mar 2010 17:20:04 -0500
Received: from mail-ew0-f212.google.com ([209.85.219.212]:56613 "EHLO
	mail-ew0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755818Ab0CEWT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 17:19:59 -0500
Received: by ewy4 with SMTP id 4so2743076ewy.28
        for <git@vger.kernel.org>; Fri, 05 Mar 2010 14:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=WIkVRRgvhTaSl2nArqVwcPAzqIcx7XfT7JNTr3nU2XA=;
        b=Wn+oAUocIaCUvetXXkcfOE41Gq21Dig0JTLiOvDKmIC6Gx8eryfAzmNDeP682tQThy
         enLTk5SaT7iQUZFjjIXGVwuIdvW3dlrJk6wGEFJFXnS9xZwChGLY3Wzzi+8ozV7ZuNau
         LzMomgQGxcGCw1hk2torQtOyzTvz3LxgSqJ/0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=IDEMiplwhdQDyJhr7F5XwNGTjTZVamX0BMgWSS04pdZe32talJwVM0783qXXJ1Eby9
         7M/I9QYV3zJv0NItP3TzLwnznkBbpIuNW+iJ9rwVTRzmetzXpWtqi0o1lUyUf78x0ZMJ
         JIMBuFP2JVEQYLZboazHuMbvXLXsg8x/mh3qU=
Received: by 10.213.96.212 with SMTP id i20mr847339ebn.35.1267827597535;
        Fri, 05 Mar 2010 14:19:57 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 7sm5442110eyb.17.2010.03.05.14.19.54
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 05 Mar 2010 14:19:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100305215253.364.63583.reportbug@localhost>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141598>

Hi gitsters,

Stefan Monnier wrote [1]:

> I can't live without conflictstyle=3Ddiff3m and I'm very happy it exi=
sts.
> But it has a little problem: it uses "|||||||\n" as a separator for t=
he
> ancestor version of the text, whereas diff3 uses "||||||| <ancestorna=
me>\n".
> The difference is harmless for a human (tho the <ancestorname> can so=
metimes
> be useful, assuming it's meaningful), but it makes some tools fail to
> recognize the conflict markers properly.
> So please add a " BASE" or " ANCESTOR" after the "|||||||".

No opinion on this myself.  I=E2=80=99d be interested to hear from xdif=
f people
whether it should be easy to add the ancestor name to the output.

>
> 	Stefan
>
> PS: I intended to report this bug directly to the Git bug-tracker, bu=
t I was
> simply unable to find it.  I know I'm sometimes dense, but I did make=
 an
> honest effort to look for it.

See http://thread.gmane.org/gmane.comp.version-control.git/136500

Short answer: the usual method is to report bugs to the list, preferabl=
y
with a patch for t/ or even better, a fix. ;-)

Jonathan

[1] http://bugs.debian.org/572720
