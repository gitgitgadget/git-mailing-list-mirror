From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Corruption in the repository
Date: Tue, 14 Dec 2010 10:29:39 +0100
Message-ID: <AANLkTikP3CTNX_S=fAWTBVbt0OwQMLr+mq8f72OFd0j6@mail.gmail.com>
References: <1292255990.25237.27642.camel@korcula.inria.fr>
	<AANLkTimD6+CHofhbKvBPjHpcNUNusHOCHSQe+-J1ZA4F@mail.gmail.com>
	<1292258845.25237.27680.camel@korcula.inria.fr>
	<AANLkTimgLhQMUGmC=W5wpcAvb07faw4HOzPgWXpFA4u1@mail.gmail.com>
	<1292263868.25237.27772.camel@korcula.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Simon Gareste <simon.gareste@scilab.org>,
	Bruno JOFRET <bruno.jofret@scilab.org>
To: Sylvestre Ledru <sylvestre.ledru@scilab.org>
X-From: git-owner@vger.kernel.org Tue Dec 14 10:29:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSRCg-0007Fu-UD
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 10:29:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758200Ab0LNJ3o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Dec 2010 04:29:44 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47213 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755390Ab0LNJ3m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 04:29:42 -0500
Received: by wwa36 with SMTP id 36so332348wwa.1
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 01:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VSW1XlaLbPmIO2FfZRkcf1EawxMjbRS66dXjln6yFMY=;
        b=Z6W6fnJwp70mGIH3x+pHVy24w+2mkW+27MBkO9vl6TDx73pkUDjzwkBuea3XbUmQih
         A9n9CYwQ5E2QR3lvmp9JUnpeo3uYaBFCn69X/o3pPW5qQJBo06WbH7R1EC7wqSWkRvfl
         wyp7g0th5TfUmDWgXPQUCrSn4F5TpvfJZnPkg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PpaXhMjvQp8gW5EkOeZKlOUwMrZjaGmFPpYBAVVUGiV23PpSEXSDD2UUBEFv8v6ceO
         C/02WoQBu2UjwLkw1xp/IUSTai1rhCdy4K1/0PXwVCA6deuPkT8JegGGC2NeI8rfmfxD
         ZShsKBk62Lf3YRbvTOjD16DbZoGbbrXNpoNU0=
Received: by 10.216.160.1 with SMTP id t1mr4490046wek.2.1292318979910; Tue, 14
 Dec 2010 01:29:39 -0800 (PST)
Received: by 10.216.85.213 with HTTP; Tue, 14 Dec 2010 01:29:39 -0800 (PST)
In-Reply-To: <1292263868.25237.27772.camel@korcula.inria.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163639>

On Mon, Dec 13, 2010 at 7:11 PM, Sylvestre Ledru
<sylvestre.ledru@scilab.org> wrote:
> Le lundi 13 d=E9cembre 2010 =E0 18:02 +0100, Christian Couder a =E9cr=
it :
>> On Mon, Dec 13, 2010 at 5:47 PM, Sylvestre Ledru
>> <sylvestre.ledru@scilab.org> wrote:
>> >
>> > Le lundi 13 d=E9cembre 2010 =E0 17:34 +0100, Christian Couder a =E9=
crit :
>> >> Hi,
>> >>
>> >> On Mon, Dec 13, 2010 at 4:59 PM, Sylvestre Ledru
>> >> <sylvestre.ledru@scilab.org> wrote:
>> >> > Hello guys,
>> >> >
>> >> > I have a small problem with a git repository and I haven't find=
 a way to
>> >> > fix my problem.
>> >> > I am using git with gerrit [1] as frontend (even if I don't thi=
nk it is
>> >> > related here).
>> >> > For an unknown reason, the repository just became corrupted.
>> >> >
>> >> > When I try to clone the repository straight with the file syste=
m, the
>> >> > following error is displayed:
>> >> > error: refs/changes/98/398/1 does not point to a valid object!
>> >> > error: refs/changes/98/398/2 does not point to a valid object!
>> >> > fatal: object cff52c24fba28408e7d021a8f35a717bef31521d is corru=
pted
>> >> > fatal: The remote end hung up unexpectedly
>> >> >
>> >> > git-prune & git-fsck both fail.
>> >> >
>> >> > Does anyone know how to repair this error ?
>> >>
>> >> Did you try what the FAQ suggests:
>> >>
>> >> https://git.wiki.kernel.org/index.php/GitFaq#How_to_fix_a_broken_=
repository.3F
>> > Yes. It shows an other error and it doesn't match the error descri=
bed on
>> > this URL [1].
>> >
>> > I get the following:
>> > error: refs/tags/5.3.0-beta-4 does not point to a valid object!
>> > fatal: object 555a7c359b2e589ec10822d9b56cdfeee0105fe0 is corrupte=
d
>>
>> The FAQ says that you should try to replace any broken and/or missin=
g
>> objects, so you should try to do that with object
>> 555a7c359b2e589ec10822d9b56cdfeee0105fe0 (as described in the FAQ)
>> even if the error message is not exactly the same.
> Well, after clean the error about the tags, it does not provide any
> interesting feedbacks like in the FAQ.
>
> Just some information [1] about some dangling commits (probably commi=
t
> under review in gerrit). Nothing valuable and the problem still occur=
s
> on the client side.

So you say that "git fsck --full" gives only dangling commits on the
server, and you still get messages like "fatal: object XXXXX is
corrupted" on the client when you try to clone with gerrit? Did you
try to clone using git? Please try it and give us the exact command
and result that you get.

By the way could you tell us which version of git and gerrit you are us=
ing?
When I try "git grep corrupted" on the git and gerrit sources I don't
find anything relevant.

Regards,
Christian.
