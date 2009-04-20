From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Oldest supported Perl version
Date: Mon, 20 Apr 2009 14:27:18 -0400
Message-ID: <76718490904201127n5bd9836ak796792ce3cfd18a6@mail.gmail.com>
References: <76718490904200759l24e1bd9exe0e1b60f7b2847a7@mail.gmail.com>
	 <m3eivnp5p4.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Witten <mfwitten@gmail.com>, git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 20:29:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvyEy-00013i-Kq
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 20:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754340AbZDTS1U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Apr 2009 14:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754443AbZDTS1T
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 14:27:19 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:14399 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308AbZDTS1T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2009 14:27:19 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1389806ywb.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 11:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=E1/Yy7VIK5AhPrH9BkZgbwFEq+vLjH+CJDb+IbJYPXw=;
        b=vsWQ7lBJO6LTdr+Tom+utEon7tFaQ4BcJqOzeVsU2yI+ct9FX8+pcKuKX74Spx5I3s
         QuaJyGuXiGpSrDhp0w8wqQ2jPpr7um0kWh/zEOzng1QygmxS0f3/5FNOrbkH7IFI1SSu
         onyE2ZJTWU5jAxbCmSvwpnJOv1aoLD1qHIsW0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qNxmiTFWkU/2BJ0osqoqCgpEoGmCMerwxzKhs1edAOAinY1dEJko02sfEKMxnU/LwJ
         +i6HhWul/5sjPDdfQlhIutgV8utdWWTwyNHCGvqy42a8c2cO3qW8Ca3vicemUFPW6CYR
         8ZVR6ZNlMsUTPV1mSv5DG+mdLE91cFPdNNSlI=
Received: by 10.150.58.17 with SMTP id g17mr6798926yba.211.1240252038084; Mon, 
	20 Apr 2009 11:27:18 -0700 (PDT)
In-Reply-To: <m3eivnp5p4.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117015>

On Mon, Apr 20, 2009 at 1:59 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> Jay Soffian <jaysoffian@gmail.com> writes:
>> So here's my take-away. For the *.perl scripts and gitweb, it's
>> 5.8.0. For the test suite and Git.pm, all Perl versions are
>> theoretically supported, but for practical purposes, it may be
>> 5.6.0.
>
> Errr... no. =C2=A0For gitweb we require good Unicode support, which m=
eans
> Perl 5.8.x (IIRC 5.8.1). =C2=A0For all other: commands (and helpers)
> written in Perl like git-svn, fragments of Perl in test suite (becaus=
e
> of incompatibility and corner cases of shell scripting) - with possib=
le
> exception of testing gitweb, and Git.pm (which some commands in Perl
> use) I think it is reasonable to expect 5.6.0 at least.

Um, isn't that basically exactly what I said? The only difference is
you're clarifying gitweb to be 5.8.1 instead of 5.8.0. Fine. that's
why this went to the git list.

j.
