From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/6] Remote helper: accept ':<value> <name>' as a response
 to 'list'
Date: Thu, 7 Oct 2010 23:17:18 +0200
Message-ID: <AANLkTi=4Vc8456TVMHPTmLg=4VyFqtje6Mnz73VsHrKs@mail.gmail.com>
References: <4CA86A12.6080905@dbservice.com> <1286108511-55876-1-git-send-email-tom@dbservice.com>
 <20101005020035.GA10818@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tomas Carnecky <tom@dbservice.com>, git@vger.kernel.org,
	David Michael Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 23:17:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3xqW-0004Zk-0N
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 23:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756368Ab0JGVRk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 17:17:40 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45905 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756333Ab0JGVRj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 17:17:39 -0400
Received: by gwj17 with SMTP id 17so119886gwj.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 14:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=6+hIT8RpuuAFGnFP1kjZSxEb/EVMKXLHzovccnBqYp4=;
        b=EmWUtgKAgKbOXFvbMRK1z4DIXUFpKbgKWBNgt3yzA/ikONA6SwR9alod0cpteZA1Kz
         YmsQcXq0fVEphnjAwCLRUTRBDAqmmejyZuPxlPRyhoKjmeREXvIQ6Uy5pnnBTsb89UDK
         5GvAQb3Acmga0cmEBA0YU272Yu8QADYTVSiCE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=gdqvouHAJh7KpDlYJyBX70AhiPIXzrOem24XNCgCAEznHKXzB97l0o4tVVfIgEsTrQ
         rysS6CWb/0X13PcOt0H90jwxrH7lM3UvPtJ9YuAN+gIS5UKjJWRquHm91FqSCIgQAa+l
         cJF7baFNuTXSl/kXDNlUGvuHr6wfaJCrGHiLY=
Received: by 10.150.147.11 with SMTP id u11mr1805956ybd.386.1286486258955;
 Thu, 07 Oct 2010 14:17:38 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Thu, 7 Oct 2010 14:17:18 -0700 (PDT)
In-Reply-To: <20101005020035.GA10818@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158459>

Heya,

On Tue, Oct 5, 2010 at 04:00, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> In particular, each line has a 40-character object id, a tab characte=
r,
> and then something like a refname.
>
> If we want to extend that, wouldn't we need to do something like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A00000...0000 =C2=A0 =C2=A0 <refname>
> =C2=A0 =C2=A0 =C2=A0 =C2=A00000...0000 =C2=A0 =C2=A0 <refname> is r11
>
> to avoid breaking people's scripts?

I don't know... I'd suspect that people's scripts are going to break
regardless, but if this is being used in scripts I agree we should
make it as easy as possible for scripters to parse this output.

--=20
Cheers,

Sverre Rabbelier
