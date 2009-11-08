From: Emmanuel Trillaud <etrillaud@gmail.com>
Subject: Re: gitk : french translation
Date: Sun, 8 Nov 2009 18:55:51 +0100
Message-ID: <9f50533b0911080955l606ea87aw4edd7b0bc926a25f@mail.gmail.com>
References: <9f50533b0911060605p6ad28ad9neac3620a1809c3db@mail.gmail.com>
	 <b0c32d010911061016t2208af0er8d7fe88508c30f10@mail.gmail.com>
	 <9f50533b0911061259w54b57fcdo2c0b21e95dbbdc54@mail.gmail.com>
	 <20091107025439.GC13724@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Moulard <thomas.moulard@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Sun Nov 08 18:56:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7Bzj-0002Co-1b
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 18:56:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754836AbZKHRzx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Nov 2009 12:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754829AbZKHRzx
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 12:55:53 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:53848 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754600AbZKHRzq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Nov 2009 12:55:46 -0500
Received: by mail-ew0-f207.google.com with SMTP id 3so2494116ewy.37
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 09:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Kx7Fs9dqqhwJbKuVm+r7dneu4QTlSnuZcqhuIwiEPnY=;
        b=iF/QxCeSZnOAcj8o0gqU+vsM8Zc75o+dRXvZc/16YD3D7YeAR5ZnCPB7OCeAyXKpRT
         oqYLX8KSgct9AfnK8BSoGBhONRdy0ZdsiVW3NQrhmCzYyOvt3Wq5nVGIBuZL/Y1gZ8m7
         ZPEqEdaqExBdQ+pgDkADfCXrALyRpRG3WfC1c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=L6fa0QSW4ijPOogYJ3Kj+6XAkuNKiWwdXo1IGgGcfHu3YKbV5d0ffXM5CsCb6j5d+y
         jb2Syz4sKfjPKLEZtDbIOA3AEoqmKAi+B3LlC0NwrNtRulAjSkGs8Y7+prX/WGoRXMIx
         BAbIlvNiXfp2PbDoag2MywqEnZPA2XjcJOn40=
Received: by 10.216.86.85 with SMTP id v63mr2120419wee.32.1257702951740; Sun, 
	08 Nov 2009 09:55:51 -0800 (PST)
In-Reply-To: <20091107025439.GC13724@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132409>

2009/11/7 Nicolas Sebrecht <nicolas.s.dev@gmx.fr>:
> [
> =C2=A0Please, conform to Documentation/SubmittingPatches of the git.g=
it
> =C2=A0project and send your patches inline to make the work for revie=
wers
> =C2=A0easier.
>
> =C2=A0Both of your patches lack the Signed-off-by but maybe you don't=
 want
> =C2=A0them to be merged?
> ]
I am aware of this recommendation but this translation is almost 22kb a=
nd
I tought that put it inline wouldn't make the review easier. I will
submit a patch
gathering my workand those of the reviewers soon.

> The 06/11/09, Emmanuel Trillaud wrote:
>
>> > Here is an updated translation with the following changes:
>
> <...>
>
>> > - make some consistency changes
>> > =C2=A0* s/diff/diff=C3=A9rences/
>> > =C2=A0* s/patch/correctif/ everywhere
>
> I disagree here. Words like "diff", "commit", "patch", etc should be
> kept as is. Translation of those terms make things harder for the use=
rs.
I agree with you when those terms refers to _commands_ names, but the
main goal of a
translation is to _translate_ and we have to make the best effort to
use french word if they _exist_
and _are_ appropriate (that's why I'm not sure about translate
"cherry-pick" by "ceullir").
I prefer to translate "Diff this -> selected" by "Diff=C3=A9rence entre=
 =C3=A7a
et selection"
because it is what the user do when he make a diff. I am also ok to
translate "merge" by "fusion"
because it's what "merge" is in french and I don't this we mislead the
user by using the term
"fusion".

>> > IMHO the most important should be to decide how to translate the g=
it vocabulary.
>> > The Subversion project has guidelines concerning that issue:
>> > http://svn.collab.net/viewvc/svn/trunk/subversion/po/fr.po?revisio=
n=3D39920&view=3Dmarkup
>> > It may be a good idea to stick with what they are doing if possibl=
e.
>
> No, no. SVN and Git vocabulary/operations are not identical (not only
> for 'commit' as you stated). Please, don't make things harder than it
> already is.
Have you read this document? I read it and it contains some
interesting _advices_ in it
(especially for an amateur translator like me) and some translations
ideas. That said, I agree with
your concerns to not make things harder for the user and to choose the
good translations
for the Git vocabulary. I will make a glossary of the Git words and
the proposed translations for them

Cordiallement

Emmanuel
