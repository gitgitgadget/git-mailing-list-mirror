From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/12] t6038 (merge.renormalize): style nitpicks
Date: Thu, 5 Aug 2010 06:54:23 -0500
Message-ID: <20100805115423.GP13779@burratino>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
 <20100804031935.GA19699@burratino>
 <20100804032338.GF19699@burratino>
 <7vocdifdrk.fsf@alter.siamese.dyndns.org>
 <20100805110822.GB13779@burratino>
 <20100805110933.GC13779@burratino>
 <AANLkTikv3oYapOVWmxkt2eqwGWQKMAQOCmruShSiHjKv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 13:55:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ogz3C-0008WN-3x
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 13:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758886Ab0HELzu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 07:55:50 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52894 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759135Ab0HELzs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 07:55:48 -0400
Received: by iwn33 with SMTP id 33so119805iwn.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 04:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=08sLvYH1JJ3DAJK33BukG0mSEBnitp5BH+ANIy0x30c=;
        b=vtvFvfYU1nWYGOPuEIH4kw8M7RzMKlbCxT5Bveszf20mfag1He5pf7Y4Whg0EsJv1S
         Zh9h2xRjvEreOcZ+W7ZdLuAq6SOMuYjGtHOovhj8zmmmr+B2jbip3sFW9Wb7zleP453D
         3IK8X+iH9YgBEmzV3w2WgjHpKEDCeP7nkIoSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=MZ15ccKTkL+lIt0mUP39G4baRZdkJx7oGZJwm/C8fJzpaMwBukfksXE+yp8NNKS8aU
         B7ZsCkB2FahFxWcczXYiSFiZB+e0nqPsWY1o2+3EDV6r01aO21ShCEWD7GAkyrVWvmDL
         kA0wHw7NOLkkbZeOBibu7PiX/tbw8NGsx01RU=
Received: by 10.231.150.7 with SMTP id w7mr12395814ibv.14.1281009347275;
        Thu, 05 Aug 2010 04:55:47 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id h8sm78155ibk.9.2010.08.05.04.55.46
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 04:55:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikv3oYapOVWmxkt2eqwGWQKMAQOCmruShSiHjKv@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152648>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Thu, Aug 5, 2010 at 11:09, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:

>> =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout side &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo same line | append_cr >>file &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo same line >>control_file &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0git add file control_file &&
>> + =C2=A0 =C2=A0 =C2=A0 test_tick &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -m "add line from b" &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0git tag b &&
>
> FWIW this looks like it could use Dmitry's "test-lib.sh: introduce 4t=
h
> argument to test_commit() specifying a tag name" patch.

In this example I am not confident the file has content suitable for
echo.

The discussion brings to mind something[1] I thought wise in a
different context:

	=E2=80=9CI mentioned earlier that UNIX was not especially suited
	to applications involving vast quantities of data. The
	reason is this: files are limited in size to 64K bytes.
	The reason for this is not particularly defensible, but
	it has to do with the fact that the PDP-11 word size is
	16 bits.

	There are a couple of ways around this problem. One of
	them is simply to split one large logical file into
	several smaller actual files.  This approach works for a
	while. The limitation here comes from the fact that
	directories are searched in a linear fashion. Thus if the
	are a vast number of files, it can become quite
	time-consuming tosearch directories to find the files
	they contain. We have not noticed this to be a problem,
	so far, it is only a worry.

	Another way around the small file size is to use a disk
	as a special file. For various reasons, when an entire
	disk drive is accessed as a special file, the size
	limitation does not occur. Thus one can set up a program
	which manages its own data-- in effect is its own,
	special-purpose file system-- and expect reasonable results.

	This again bears on the general versus special purpose
	system: it probably is more efficient anyway to do your
	own data management, provided the extra labor is worth
	the cost.=E2=80=9D

Of course the tradeoffs are completely different here but it is worth
bearing in mind the underlying process: sometimes a too general
facility only gets in the way unless all the facets of how it should
be used have been carefully understood (i.e., good interfaces
sometimes evolve by excluding the special cases until the missed
benefit from not including them is overwhelming).

Sorry for the ramble.  Another way to say it: I am happy to see
test_commit be made more useful, but if extra-weird cases do not fit
it, please do not take that as a failing.

[1] http://cm.bell-labs.com/cm/cs/who/dmr/notes.html
