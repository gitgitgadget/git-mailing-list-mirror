From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Problems using perl's Git.pm module
Date: Thu, 2 Dec 2010 10:19:55 -0600
Message-ID: <20101202161955.GB3962@burratino>
References: <20101202114003.GA26070@raven.wolf.lan>
 <AANLkTi=8=k9iNWzTnGz821k9A_CZNiEt_KkC8TXu6oS_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 17:20:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POBtI-0001ay-O1
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 17:20:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757738Ab0LBQUI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Dec 2010 11:20:08 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56105 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757651Ab0LBQUH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 11:20:07 -0500
Received: by vws16 with SMTP id 16so1098539vws.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 08:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ocCeRtYadF7tKJtPHXSSEUsMBABLFKqP3dqJXQA2dS4=;
        b=ZFf5KWO/bLvQ9nQ4kyzi6spLNKsF9agh4sYlfBr2eqr+s+GDMq/DaKnoZzuLV2q0FM
         4HQ776r7i2uo5zOFKxIBFHRVaiPbwhPAiAVXJHESkJQXIncmIDYw4zDSL7+ofCou6gws
         t23ZpKHhleTfyeTn2QfThtdOKlhdaCDNQyNYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=rO05Gb+cseHp59G/uiz3O3Idbt+XCMh8DFz10MM0UuLGV5f9LJxWgYoYZKxF1oU1yu
         mvop4ySsgfUUHocgl+KuWXeOZaxecZ2egy5ANwrKobIdSybTl2jZUpezxkBuA75ygutd
         ml6mRiJQkJMaGR5HBGgPaMMf380dSXDSYCWIg=
Received: by 10.220.200.130 with SMTP id ew2mr80120vcb.64.1291306806517;
        Thu, 02 Dec 2010 08:20:06 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id j21sm88740vcr.10.2010.12.02.08.20.03
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Dec 2010 08:20:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=8=k9iNWzTnGz821k9A_CZNiEt_KkC8TXu6oS_@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162710>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Thu, Dec 2, 2010 at 12:40, Josef Wolf <jw@raven.inka.de> wrote:

>> I am trying to use perl's Git.pm module, but for some reason, it kee=
ps
>> bailing out:
>
> Why are you using it? It's for internal use only.

Where do you get that from?  (Not sure whether it's true, just curious.=
)

> Couldn't you use one of the Perl Git wrappers on the CPAN?

This is still a reasonable suggestion, certainly.
