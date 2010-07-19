From: Ketan Padegaonkar <ketanpadegaonkar@gmail.com>
Subject: Re: [http] Git error messages reveal password encoded in the URL
Date: Mon, 19 Jul 2010 16:25:43 -0700
Message-ID: <4C44DEF7.4000903@gmail.com>
References: <4C4484A4.5010009@gmail.com> <m3aapnmbid.fsf@localhost.localdomain> 	<AANLkTikP3eNVs34ZcB9gHqV60-aqexfCPgcyBWSGn_Y7@mail.gmail.com> 	<201007192310.56399.jnareb@gmail.com> <AANLkTilby7GWOuObh6W4z_caUG83O5A5Wh4Wb-JJnSdJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git-dev <git@vger.kernel.org>
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 20 01:26:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oazim-0001gU-Bj
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 01:26:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756571Ab0GSXZu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jul 2010 19:25:50 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:41480 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754567Ab0GSXZt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 19:25:49 -0400
Received: by pzk26 with SMTP id 26so1499884pzk.19
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 16:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=eq6bK9GjosI0rW30T7Mvo96gA+XbCwqumV7UN1NL6x4=;
        b=Ab1y/5fD3/66YRgsWGLxvQ3weu/kwHIESdzu1VpcBcY/EGTLvAD5PCrDS7waeb/j5R
         skLbQL8/XscMY3CUEXfoHBwNMBjSR4uQX9imJsLWHvouIxWz1uxBL5ms0jOYm3cD3h4u
         cgpCKOJwDpMIMmlutYE70pnSuMeK6w6In5NGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=xz67MuDkVOj/kjl/eEPqGXCYn9Zi6/Ods+f8OUXPfVcv5UWMo6oSe9L+28VQz924hy
         AZ5GbdFrX0ECTRs7QlLsM5wAEnDASYySx9MxotItVauh+uscNz/BHLsEbIlAR7R0KSkV
         aUflPQg9rn941MzBEBZ1ScqKtpTdvo42aCaVs=
Received: by 10.142.147.7 with SMTP id u7mr7966157wfd.218.1279581948608;
        Mon, 19 Jul 2010 16:25:48 -0700 (PDT)
Received: from storm.corporate.thoughtworks.com ([204.15.2.181])
        by mx.google.com with ESMTPS id y16sm7006087wff.2.2010.07.19.16.25.45
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 19 Jul 2010 16:25:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.2.4) Gecko/20100608 Lightning/1.0b2 Thunderbird/3.1
In-Reply-To: <AANLkTilby7GWOuObh6W4z_caUG83O5A5Wh4Wb-JJnSdJ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151291>

On 7/19/10 2:16 PM, Jacob Helwig wrote:
> On Mon, Jul 19, 2010 at 14:10, Jakub Narebski<jnareb@gmail.com>  wrot=
e:
>> Dnia poniedzia=C5=82ek 19. lipca 2010 23:05, Jacob Helwig napisa=C5=82=
:
>>> On Mon, Jul 19, 2010 at 14:02, Jakub Narebski<jnareb@gmail.com>  wr=
ote:
>>>> Ketan Padegaonkar<ketanpadegaonkar@gmail.com>  writes:
>>>>
>>>>> We use http to serve our git repos, in order for git to not ask m=
e a
>>>>> username/password everytime,

Apologies. I used the wrong punctuation. It should read as:

We use https+basic auth to serve up git repos. Unfortunately SSH is not=
=20
an option for various reasons.

In order for git to not ask me the username/password, I 'encoded' the=20
username/password into the url.

I'm using git v1.7.1.1 on MacOSX Leopard. I can see the same behavior o=
n=20
master (rev 24e7a5).

--=20
Ketan
http://ketan.padegaonkar.name | http://eclipse.org/swtbot
