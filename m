From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Corruption in the repository
Date: Mon, 13 Dec 2010 18:02:06 +0100
Message-ID: <AANLkTimgLhQMUGmC=W5wpcAvb07faw4HOzPgWXpFA4u1@mail.gmail.com>
References: <1292255990.25237.27642.camel@korcula.inria.fr>
	<AANLkTimD6+CHofhbKvBPjHpcNUNusHOCHSQe+-J1ZA4F@mail.gmail.com>
	<1292258845.25237.27680.camel@korcula.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Simon Gareste <simon.gareste@scilab.org>,
	Bruno JOFRET <bruno.jofret@scilab.org>
To: Sylvestre Ledru <sylvestre.ledru@scilab.org>
X-From: git-owner@vger.kernel.org Mon Dec 13 18:02:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSBmy-0002fq-Ka
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 18:02:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758326Ab0LMRCJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 12:02:09 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42064 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758307Ab0LMRCH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Dec 2010 12:02:07 -0500
Received: by wwa36 with SMTP id 36so6533622wwa.1
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 09:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LT3fVg+nmnejPg/BcX0zMXhmi1WeidoKs4H7jqpr32o=;
        b=xJVj8Zh2TbTRiFm+32iO+8G2Cqx9qHmUasOB4fctpjJRbmjCKut9V1fTJlRuZOYAox
         mJzJdgzzQ81rJWX2icRpb9NZ9XUu2MOwV2v/by8y4c0r6XugPwpCjmAeE9bGwJb0HO0l
         CwRui3pcPlVGHiC2PQDnooPwsYbzkyhNhWsac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=orLBnD/9hZyrE9dfoGiLWm5f0zVv8M6wyNVHtlNbhJtAG3WsANrm8mlJjJBIvD1INH
         1nJRbbVqpe+psk29Qrg9Z83ymfIRZzmRGiRWawWOA6Bj+0Yoc3mDCg9pKnYNEZWVCLF7
         AKg2lFy3sPr/RqAc3eaaA20I5YjNxnCyRzbaw=
Received: by 10.216.176.3 with SMTP id a3mr4856752wem.17.1292259726567; Mon,
 13 Dec 2010 09:02:06 -0800 (PST)
Received: by 10.216.85.213 with HTTP; Mon, 13 Dec 2010 09:02:06 -0800 (PST)
In-Reply-To: <1292258845.25237.27680.camel@korcula.inria.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163565>

On Mon, Dec 13, 2010 at 5:47 PM, Sylvestre Ledru
<sylvestre.ledru@scilab.org> wrote:
>
> Le lundi 13 d=E9cembre 2010 =E0 17:34 +0100, Christian Couder a =E9cr=
it :
>> Hi,
>>
>> On Mon, Dec 13, 2010 at 4:59 PM, Sylvestre Ledru
>> <sylvestre.ledru@scilab.org> wrote:
>> > Hello guys,
>> >
>> > I have a small problem with a git repository and I haven't find a =
way to
>> > fix my problem.
>> > I am using git with gerrit [1] as frontend (even if I don't think =
it is
>> > related here).
>> > For an unknown reason, the repository just became corrupted.
>> >
>> > When I try to clone the repository straight with the file system, =
the
>> > following error is displayed:
>> > error: refs/changes/98/398/1 does not point to a valid object!
>> > error: refs/changes/98/398/2 does not point to a valid object!
>> > fatal: object cff52c24fba28408e7d021a8f35a717bef31521d is corrupte=
d
>> > fatal: The remote end hung up unexpectedly
>> >
>> > git-prune & git-fsck both fail.
>> >
>> > Does anyone know how to repair this error ?
>>
>> Did you try what the FAQ suggests:
>>
>> https://git.wiki.kernel.org/index.php/GitFaq#How_to_fix_a_broken_rep=
ository.3F
> Yes. It shows an other error and it doesn't match the error described=
 on
> this URL [1].
>
> I get the following:
> error: refs/tags/5.3.0-beta-4 does not point to a valid object!
> fatal: object 555a7c359b2e589ec10822d9b56cdfeee0105fe0 is corrupted

The FAQ says that you should try to replace any broken and/or missing
objects, so you should try to do that with object
555a7c359b2e589ec10822d9b56cdfeee0105fe0 (as described in the FAQ)
even if the error message is not exactly the same.

Regards,
Christian.
