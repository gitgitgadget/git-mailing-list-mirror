From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Are the patches used to build git on cygwin available in a git 
	repo somewhere?
Date: Wed, 31 Mar 2010 18:55:58 +1100
Message-ID: <o2p2cfc40321003310055i4b26d46l29ac6113be9eb980@mail.gmail.com>
References: <2cfc40321003300916o305e4c15x7850549beafc26c0@mail.gmail.com>
	 <20100331025626.GA13501@progeny.tock>
	 <20100331025856.GB13501@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>,
	Dmitry Potapov <dpotapov@gmail.com>, Eric Blake <ebb9@byu.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 09:56:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwsmU-0007Ls-N9
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 09:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756628Ab0CaH4A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Mar 2010 03:56:00 -0400
Received: from mail-pz0-f186.google.com ([209.85.222.186]:35298 "EHLO
	mail-pz0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756423Ab0CaHz7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Mar 2010 03:55:59 -0400
Received: by pzk16 with SMTP id 16so450043pzk.22
        for <git@vger.kernel.org>; Wed, 31 Mar 2010 00:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rIppu3ymlygZeOsjyfBgVR7QasWNiXlPsG1MicSCmuM=;
        b=ZBA3PUOmwmCXrTedjppMOVSqlEirblRSWe9p+kToWSil1W2ETuGB+qArzbx3t+jhCN
         o1Sy0xXPArnnevEYwzQ8pJMnnGdXtsJco75mKL2Rs6jC6a3vYU4wKAI0VFGYRj59jLn4
         k6+HKlUgRyJb6D5oF4KpaWfe6huKXaoIZKCzA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FnPfXhY0qy8xkZNGI3s+7WdzGgfaJyKJh21JSN0qivIEMag1UBYpJC4yo9vUbQ7SBK
         d7Sn3Dy5veGTfhv9nLM0Vwj/bjgv8d9QGjLO/zYP5MrCeERyE6N/uCMqzA9Fj+fLuYlg
         n7FKD1tlkdH/f/GbO1/UgHPpTNNQW9BPCMlY0=
Received: by 10.114.13.5 with HTTP; Wed, 31 Mar 2010 00:55:58 -0700 (PDT)
In-Reply-To: <20100331025856.GB13501@progeny.tock>
Received: by 10.114.237.20 with SMTP id k20mr1706533wah.185.1270022158351; 
	Wed, 31 Mar 2010 00:55:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143651>

What I was looking for was a git repo that contains a branch with the
patches that the cygwin folks mutate the official git release with.
Such a repo would be quite useful because people could, in theory, use
these to produce their own cygwin git builds at arbitrary commits
instead of having to wait for cygwin to catch up.

Admittedly, it is not a big deal to build such a branch using the
patch from the cygwin package source, but I was just wondering whether
there was a well-known repo that contained the patches already.

jon.

On Wed, Mar 31, 2010 at 1:58 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Jonathan Nieder wrote:
>> [adding a few relevant cc's]
>>
>> Jon Seymour wrote:
>>
>> > Does anyone maintain a git repo with the patches used to successfu=
lly
>> > build the cygwin git packages?
>>
>> I think git.git is the canonical repo. =C2=A0On cygwin.com I don=E2=80=
=99t see any
>> package more recent than 1.6.6.1 so I suspect no one has packaged a
>> recent version yet.
> s/recent/more recent/
>
> Sorry for the noise.
>
