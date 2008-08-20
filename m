From: "Mike Gant" <mwgant@gmail.com>
Subject: Re: git clone operation
Date: Tue, 19 Aug 2008 20:23:49 -0600
Message-ID: <8f282e3b0808191923w18001cc6sef828d94b35e40c6@mail.gmail.com>
References: <20080817184443.GA11782@mg1.gantsfort.com>
	 <m3wsifsawl.fsf@localhost.localdomain>
	 <20080817193833.GA29469@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 04:24:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVdNY-0002su-H9
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 04:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021AbYHTCXx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Aug 2008 22:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752175AbYHTCXx
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 22:23:53 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:30418 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753971AbYHTCXv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Aug 2008 22:23:51 -0400
Received: by yx-out-2324.google.com with SMTP id 8so91291yxm.1
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 19:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=7+YhAZATrfJqpflxQhZjonL0TnDKa94hFtscYYMuLxA=;
        b=cQNoFkxtuB7jmrHdAqtup6fNV8E/AbKk3zLCOoduwovzdnt4MHGZR52gI84cIibGZj
         tlmsIwWgmTsiyoaU32wLjeV8JayXN79QraCkqUCsD8PkXGBeOyQI6SvEwF0HAqRkGv8T
         NAGo8c5N+IUPLAWnK1LBRMVkL35cMS1mh4q10=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=hTqTPR3GaJOBZzkCEH+kYyx/DexhK+bCekWowz9g8PDupxnRmtNvHlOcrwGp/LnITh
         pYDBcpqCNpXGTNYPocMkRTtTO/eom/CCm+CtU1/Uzvdsfc+9DqhE2+Odp5FzBP7k2cBB
         5mM9+tkuqXWh4mMi3tsPVfVMX/McdkXkgAu0w=
Received: by 10.114.168.15 with SMTP id q15mr7441688wae.167.1219199029834;
        Tue, 19 Aug 2008 19:23:49 -0700 (PDT)
Received: by 10.115.108.8 with HTTP; Tue, 19 Aug 2008 19:23:49 -0700 (PDT)
In-Reply-To: <20080817193833.GA29469@atjola.homenet>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92950>

On Sun, Aug 17, 2008 at 1:38 PM, Bj=F6rn Steinbrink <B.Steinbrink@gmx.d=
e> wrote:
> On 2008.08.17 12:23:57 -0700, Jakub Narebski wrote:
>> Mike Gant <mwgant@gmail.com> writes:
>> > I realize that I can create a new local branch that is based off t=
he
>> > desired branch:
>> >
>> > $ git-checkout -b master origin/master
>> >
>> > Is this the accepted method for obtaining the desired branch?
>>
>> You can use (with new anough Git)
>>
>>   $ git checkout --track -b master origin/master
>>
>> to setup repository in such way that "git pull" on 'master'
>> would know that it is meant to fetch from 'origin' and merge
>> 'origin/master'.
>
> branch.autosetupmerge is set to true by default, so for remote branch=
es
> --track is the default anyway (since 1.5.5 IIRC). So only an old enou=
gh
> git would actually require --track, unless you changed the config ;-)
>
> Bj=F6rn
>

Thanks for your responses. I appreciate you guys taking the time to ans=
wer.

After thinking about this, I still don't understand when I clone a
repo why I will
get the equivalent of whatever branch is active at the time of cloning?=
 What
was the process that led to this design decision?

So that also got me thinking about work flows with git. Because of the =
way clone
works it seems that you wouldn't want someone to clone your every day "=
work"
repository? So do developers generally have a separate repository that =
they push
to and others can clone? This repository may have only a 'master' branc=
h (but
probably others I seem to recall Junio describing other branches in the=
 main git
repository). Is this a 'normal' work flow?

Thanks,
Mike Gant
