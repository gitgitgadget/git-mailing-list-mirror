From: Dave Abrahams <dave@boostpro.com>
Subject: Re: cherry-pick / pre-commit hook?
Date: Mon, 27 Dec 2010 12:33:27 -0900
Message-ID: <AANLkTimhMa+zGp+MNi9fjwNsAaMWz3VG=KERoDo7c0zA@mail.gmail.com>
References: <m2wrnktcl2.wl%dave@boostpro.com> <20101208175324.GB5687@burratino>
 <m2oc8wt0xc.wl%dave@boostpro.com> <20101208220514.GA8865@burratino>
 <m2d3oo9cwr.wl%dave@boostpro.com> <20101227093729.GB1201@burratino> <7vipyfx79g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 27 22:33:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXKhX-0004jF-Dz
	for gcvg-git-2@lo.gmane.org; Mon, 27 Dec 2010 22:33:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543Ab0L0Vdt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Dec 2010 16:33:49 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36817 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab0L0Vds convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Dec 2010 16:33:48 -0500
Received: by gxk9 with SMTP id 9so1012025gxk.19
        for <git@vger.kernel.org>; Mon, 27 Dec 2010 13:33:48 -0800 (PST)
Received: by 10.101.204.28 with SMTP id g28mr7396910anq.217.1293485627142;
 Mon, 27 Dec 2010 13:33:47 -0800 (PST)
Received: by 10.100.165.13 with HTTP; Mon, 27 Dec 2010 13:33:27 -0800 (PST)
X-Originating-IP: [24.237.52.92]
In-Reply-To: <7vipyfx79g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164224>

On Mon, Dec 27, 2010 at 11:58 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Dave Abrahams wrote:
>>
>>> if you're going to have a "pre-commit hook" concept,
>>> but not run that hook for some kinds of commits, then that fact nee=
ds
>>> to be documented.
>>
>> True, and thanks for a reminder. =A0Suggested wording?
>>
>> The current githooks(5) says
>>
>> =A0pre-commit
>> =A0 =A0 =A0 This hook is invoked by git commit, and can be bypassed =
with
>> =A0 =A0 =A0 --no-verify option.
>>
>> and leaves the question of whether it is invoked by git cherry-pick
>> unanswered.
>
> Huh? =A0Isn't it very clear that "git commit" calls it and "git statu=
s" or
> anything that is not "git commit" doesn't?

Not to me.  And is it really true?  What about rebase?  What about merg=
e?

--=20
Dave Abrahams
BoostPro Computing
http://www.boostpro.com
