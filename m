From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: EasyGit Integration
Date: Sat, 13 Jun 2009 01:30:38 +0300
Message-ID: <94a0d4530906121530m22dbfcb5ye63a0ecb400c4a59@mail.gmail.com>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
	 <200906122321.57479.jnareb@gmail.com>
	 <94a0d4530906121448m57f272eej32e8d57e48002f1f@mail.gmail.com>
	 <200906130005.20790.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Scott Chacon <schacon@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>, Elijah Newren <newren@gmail.com>,
	git list <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 00:30:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFFGq-0003e0-Ua
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 00:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836AbZFLWaj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jun 2009 18:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753559AbZFLWai
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 18:30:38 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:12086 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbZFLWah convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jun 2009 18:30:37 -0400
Received: by fg-out-1718.google.com with SMTP id 16so759167fgg.17
        for <git@vger.kernel.org>; Fri, 12 Jun 2009 15:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=S7o3S6nXjbWqMs4c98AnLThRkBpJnp7u+vYBqqLG/OI=;
        b=BBerPF+OwxHL7J9LgUiuGum+6rAmbAOnx3haVd1GGpPVZxYazqYhxo5AXxS5NoAIry
         4Ypnv8XyH/q6Q58EVF7ATWWsXN/OPRKrmZth9JOEJXgacNlgGU+AqjharKKGiOi+hKkk
         yhBkTEd8+B5uU93i1tYilyzf/yTSwokfvZCXA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pdMttq3t2NA3a4JwLIayF4I2dB4h0ppI0ABVmt4RrJkYdpBVqVtIry5Y6qsbv7n8Fc
         lppou1X3CjCWSm+oCo4BPi0sPYXqrQCSflulF2Lcv2R2sQHLPUopsZCPsXNVkStFR/Gu
         2K2qhKzVY4yg1OqKCm9qw51QxiwaW3BfOKIMg=
Received: by 10.86.49.16 with SMTP id w16mr4454150fgw.4.1244845838750; Fri, 12 
	Jun 2009 15:30:38 -0700 (PDT)
In-Reply-To: <200906130005.20790.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121458>

On Sat, Jun 13, 2009 at 1:05 AM, Jakub Narebski<jnareb@gmail.com> wrote=
:
> On Fri, 12 Jun 2009, Felipe Contreras wrote:
>> On Sat, Jun 13, 2009 at 12:21 AM, Jakub Narebski<jnareb@gmail.com> w=
rote:
>
>>> Nope. 'git reset' always reset some part of state to a given commit=
,
>>> HEAD by default. =C2=A0It can reset current branch with --soft, bra=
nch plus
>>> index with --mixed (default), and branch plus index plus working
>>> directory with --hard. =C2=A0Source is always commit.
>>
>> You said it: 'git reset --hard' gets something out of the repository
>> and into the working directory.
>>
>> Try this:
>> git checkout <random sha-1 with no ref>
>>
>> Then what is the difference between:
>> git checkout HEAD^
>> git reset --hard HEAD^
>>
>> In this case they do exactly the same thing, don't they?
>
> No, they don't. =C2=A0"git checkout HEAD^" modifies HEAD detaching it=
=2E
> "git reset --hard HEAD^" modifies branch that HEAD points to (well,
> unless HEAD is detached).

Read again:
>> git checkout <random sha-1 with no ref>

The HEAD is detached, so they do exactly the same in this case.

--=20
=46elipe Contreras
