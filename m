From: =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH 1/1] gitignore: do not ignore include/linux/
Date: Wed, 10 Mar 2010 18:11:38 +0800
Message-ID: <2375c9f91003100211vbe66a49g1bec37b2dcf609c2@mail.gmail.com>
References: <4B90CBE5.9090102@viscovery.net>
	 <1267780845-10547-1-git-send-email-jslaby@suse.cz>
	 <m3pr3jkq26.fsf@localhost.localdomain> <4B9120F2.2020000@gmail.com>
	 <alpine.DEB.2.00.1003100205170.17698@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jiri Slaby <jirislaby@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, Jiri Slaby <jslaby@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: David Rientjes <rientjes@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 10 11:11:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpItO-0005JY-Iv
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 11:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643Ab0CJKLl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Mar 2010 05:11:41 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:23192 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323Ab0CJKLj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Mar 2010 05:11:39 -0500
Received: by qw-out-2122.google.com with SMTP id 9so4391qwb.37
        for <multiple recipients>; Wed, 10 Mar 2010 02:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NjMV9Nt3EOlJxQUkX/BOuMT3l1KhEgznf1OF7Ge7DH0=;
        b=IvxgClTgXsr0oYMqOxBg/StUXVKluLspldOtq+fH/0OpSN7i6a/XQLIaggMNTElLfL
         RP5f6v+Hp/MFfnCZVJbyS2LYk62LNZazC3ZZGmkFxwdW8XGbrxyMVCrZT6PyQlau993A
         QuL86KcmbUTVFCxkajWcVg/5ETZo20DB4EZIw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VKcSLXaqp6X9CkQ15k1hY5QAJFBlwZIp2FmSAtmwqWS4pXm2wno/9+Pv1YZcsnqysU
         qKXZIn2XFnr4Lkicj39M8+4P5drmfG8JQVMsmp3Rbi3HCVfjDBirIthU5EN6MlzuNBEK
         zhZscM3/df7ze5Dqj6g3gtPzj7TvRBxMI/Pqo=
Received: by 10.229.241.203 with SMTP id lf11mr33279qcb.85.1268215899056; Wed, 
	10 Mar 2010 02:11:39 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1003100205170.17698@chino.kir.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 10, 2010 at 6:07 PM, David Rientjes <rientjes@google.com> w=
rote:
> On Fri, 5 Mar 2010, Jiri Slaby wrote:
>
>> On 03/05/2010 11:43 AM, Jakub Narebski wrote:
>> >> +!/.gitignore
>> >> +!/.mailmap
>> >
>> > Actually you want to *not ignore* .gitignore and .mailmap (and
>> > .gitattributes which is missing here) anywhere, not only as top-le=
vel
>> > file. =C2=A0So .gitignore and .mailmap should not be prepended wit=
h slash.
>>
>> <and moved out of the 'Top-level generic files' section then>
>>
>
> Please either revert 3b2a8c8f3c65 or merge the fixed up patch for
> 2.6.34-rc2, otherwise include/linux will continue to be ignored by gi=
t
> just like it is for 2.6.34-rc1.

Why not apply the patch from Jiri? Since this problem is introduced
by new version of git, not that commit.
