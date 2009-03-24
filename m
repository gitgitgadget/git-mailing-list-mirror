From: Tim Visher <tim.visher@gmail.com>
Subject: Re: git svn teething problems - initial clone okay - fetches not 
	working
Date: Tue, 24 Mar 2009 07:45:26 -0400
Message-ID: <c115fd3c0903240445s2dd91d57wb2e0905aad8d4d56@mail.gmail.com>
References: <2BACA6CC2F9647C19C0463120219E694@HPLAPTOP>
	 <49C7F92A.5050809@obry.net>
	 <0381B9A616514FC2A05BACAB07EE3117@HPLAPTOP>
	 <c115fd3c0903231458t7ac8ac69if6b7bdb3a7d8861b@mail.gmail.com>
	 <D9560AEA971144C99A0540C08AAFC3D1@HPLAPTOP>
	 <49C880B7.1030307@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Aaron Gray <aaronngray.lists@googlemail.com>,
	Git Mailing List <git@vger.kernel.org>
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Tue Mar 24 12:47:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm55s-0007ux-47
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 12:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755856AbZCXLpa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2009 07:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754952AbZCXLpa
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 07:45:30 -0400
Received: from mail-gx0-f208.google.com ([209.85.217.208]:57581 "EHLO
	mail-gx0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871AbZCXLp3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2009 07:45:29 -0400
Received: by gxk4 with SMTP id 4so6352672gxk.13
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 04:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PMl5exp6YctvcG6aRwv4jlcHOClrwYyDdivEojzwKzI=;
        b=WlsZtoSGY4ugwpL9QbIulJ9ydgOgTvmz1++mafXAiH8cLSBnchANzamIudolhfe0Ry
         qqtztDEskgWJOCkFppt6exCdnHddgXrpVXn+wT3W/YhDm2Ht15eR4n04kXwCWdylgu1z
         fk5/pglwiAA9j9UYbR0oBwylzbIfD6QMcSatg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QfHyPfljbRDdzqHmPkQE7ae7KSgJyQE2Nhc+6Cd1sOuSam2BCF4rn+O0L3tPutCOeX
         Ezcjd0txMd5ZZ4bd3RQPzj1rXHmMJbkxmcWsowJIEzcBC86T6P2j8tefn1kXyAYF2R6p
         f/Q7jijBsxOvzLc4vRB1pB2PIExhKAsilqJVk=
Received: by 10.100.173.18 with SMTP id v18mr5080812ane.120.1237895127165; 
	Tue, 24 Mar 2009 04:45:27 -0700 (PDT)
In-Reply-To: <49C880B7.1030307@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114452>

On Tue, Mar 24, 2009 at 2:41 AM, Pascal Obry <pascal@obry.net> wrote:
> Aaron Gray a =C3=A9crit :
>> Probably. I am getting an error on doing 'git svn rebase' :-
>>
>> many filenames * : needs update
>> update---index --refresh: command returned error: 1
>
> So before the rebase try:
>
>   $ git reset --hard HEAD
>
> then
>
>   $ git svn rebase
>

To be clear, this will destroy any non-committed changes in your
working copy so if you in fact are erroneously getting those errors
because you forgot to do a `git add .; git commit` on files you've
changed that you _meant_ to change, then you will lose those changes.
What's the output of `git status`?

--=20

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
