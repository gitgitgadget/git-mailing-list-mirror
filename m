From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Corruption in the repository
Date: Tue, 14 Dec 2010 12:59:21 +0100
Message-ID: <AANLkTinoD2qn7ZqMtGbSjJgkVUNE--fOsrSKzqTLCLpP@mail.gmail.com>
References: <1292255990.25237.27642.camel@korcula.inria.fr>
	<AANLkTimD6+CHofhbKvBPjHpcNUNusHOCHSQe+-J1ZA4F@mail.gmail.com>
	<1292258845.25237.27680.camel@korcula.inria.fr>
	<AANLkTimgLhQMUGmC=W5wpcAvb07faw4HOzPgWXpFA4u1@mail.gmail.com>
	<1292263868.25237.27772.camel@korcula.inria.fr>
	<AANLkTikP3CTNX_S=fAWTBVbt0OwQMLr+mq8f72OFd0j6@mail.gmail.com>
	<1292320068.25237.28773.camel@korcula.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Simon Gareste <simon.gareste@scilab.org>,
	Bruno JOFRET <bruno.jofret@scilab.org>
To: Sylvestre Ledru <sylvestre.ledru@scilab.org>
X-From: git-owner@vger.kernel.org Tue Dec 14 12:59:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSTXW-0006Ja-8e
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 12:59:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758064Ab0LNL7X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Dec 2010 06:59:23 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39459 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758029Ab0LNL7X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 06:59:23 -0500
Received: by wyb28 with SMTP id 28so405815wyb.19
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 03:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GYTAHIFVzdKG+xhvXdLvgDIaEQs0g26Xzf2lcl7NrDw=;
        b=JZxEurk2rpj6xyWMGB/qMSlQXxUNYGHxDlY5Pf58uJ34NU4AxU9I8TybTlhbG+74Wg
         +MJZvBHoHTxh0Qizd6b4BgYJePjv0DLxdg50iziGm19LwcdkSIqlTwPhXXQaN5EbN12y
         OA9VQWh4152jO+Cw7qAdCPNX3cr913rhXYMyE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Kiuv/ZOSWE+xxudLbOOh8kTiDEJiucs7R2Xta4IQXLbMu2JJ/zQAYg92iM6cNz6pyK
         +WjQDShMzTX3r9lG/1l21aiO6/sIPhE5SR9Er6qljV0PdQBxBdyTAcL1TVPMjHaCzje+
         TCB2GWiqR6+D1OT5NHW/9lBrf7lTbJVMoZWU8=
Received: by 10.216.160.1 with SMTP id t1mr4680493wek.2.1292327961549; Tue, 14
 Dec 2010 03:59:21 -0800 (PST)
Received: by 10.216.85.213 with HTTP; Tue, 14 Dec 2010 03:59:21 -0800 (PST)
In-Reply-To: <1292320068.25237.28773.camel@korcula.inria.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163643>

On Tue, Dec 14, 2010 at 10:47 AM, Sylvestre Ledru
<sylvestre.ledru@scilab.org> wrote:
> Le mardi 14 d=E9cembre 2010 =E0 10:29 +0100, Christian Couder a =E9cr=
it :
>> On Mon, Dec 13, 2010 at 7:11 PM, Sylvestre Ledru
>> <sylvestre.ledru@scilab.org> wrote:
>> > Le lundi 13 d=E9cembre 2010 =E0 18:02 +0100, Christian Couder a =E9=
crit :
>> >> On Mon, Dec 13, 2010 at 5:47 PM, Sylvestre Ledru
>> >> <sylvestre.ledru@scilab.org> wrote:
>> >> >
>> >> > Le lundi 13 d=E9cembre 2010 =E0 17:34 +0100, Christian Couder a=
 =E9crit :
>> >> >> Hi,
>> >> >>
>> >> >> On Mon, Dec 13, 2010 at 4:59 PM, Sylvestre Ledru
>> >> >> <sylvestre.ledru@scilab.org> wrote:
>> >> >> > Hello guys,
>> >> >> >
>> >> >> > I have a small problem with a git repository and I haven't f=
ind a way to
>> >> >> > fix my problem.
>> >> >> > I am using git with gerrit [1] as frontend (even if I don't =
think it is
>> >> >> > related here).
>> >> >> > For an unknown reason, the repository just became corrupted.
>> >> >> >
>> >> >> > When I try to clone the repository straight with the file sy=
stem, the
>> >> >> > following error is displayed:
>> >> >> > error: refs/changes/98/398/1 does not point to a valid objec=
t!
>> >> >> > error: refs/changes/98/398/2 does not point to a valid objec=
t!
>> >> >> > fatal: object cff52c24fba28408e7d021a8f35a717bef31521d is co=
rrupted
>> >> >> > fatal: The remote end hung up unexpectedly
>> >> >> >
>> >> >> > git-prune & git-fsck both fail.
>> >> >> >
>> >> >> > Does anyone know how to repair this error ?
>> >> >>
>> >> >> Did you try what the FAQ suggests:
>> >> >>
>> >> >> https://git.wiki.kernel.org/index.php/GitFaq#How_to_fix_a_brok=
en_repository.3F
>> >> > Yes. It shows an other error and it doesn't match the error des=
cribed on
>> >> > this URL [1].
>> >> >
>> >> > I get the following:
>> >> > error: refs/tags/5.3.0-beta-4 does not point to a valid object!
>> >> > fatal: object 555a7c359b2e589ec10822d9b56cdfeee0105fe0 is corru=
pted
>> >>
>> >> The FAQ says that you should try to replace any broken and/or mis=
sing
>> >> objects, so you should try to do that with object
>> >> 555a7c359b2e589ec10822d9b56cdfeee0105fe0 (as described in the FAQ=
)
>> >> even if the error message is not exactly the same.
>> > Well, after clean the error about the tags, it does not provide an=
y
>> > interesting feedbacks like in the FAQ.
>> >
>> > Just some information [1] about some dangling commits (probably co=
mmit
>> > under review in gerrit). Nothing valuable and the problem still oc=
curs
>> > on the client side.
>>
>> So you say that "git fsck --full" gives only dangling commits on the
>> server, and you still get messages like "fatal: object XXXXX is
>> corrupted" on the client when you try to clone with gerrit?
> Not exactly, when I try to clone it through gerrit, it is working:
> git clone ssh://sylvestre.ledru@git.scilab.org:29418/scilab
> A bare clone works also.
>
> It is failing when I am using git-daemon (git clone
> git://git.scilab.org/scilab) or a straight clone (git
> clone /home/git/repositories/repo.git).

This is very strange, are you sure you cannot use the resulting repo
when it "fails"?
What happens when you run "git fsck --full" on the resulting repos?

> Both with the same error:
> error: refs/changes/98/398/1 does not point to a valid object!
> error: refs/changes/98/398/2 does not point to a valid object!

Did you try to see which objects these refs are pointing to, and if
they are on the server?

Regards,
Christian.
