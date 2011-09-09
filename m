From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: The imporantance of including http credential caching in 1.7.7
Date: Fri, 9 Sep 2011 12:48:48 +0200
Message-ID: <CABPQNSbrjNR73GxE4xXFPqaVSUOaa5Drt4Je+zGY82rzajQxuw@mail.gmail.com>
References: <CAFcyEthzW1AY4uXgpsVxjyWCDXAJ6=GdWGqLFO6Acm1ovJJVaw@mail.gmail.com>
 <4E6769E3.4070003@drmicha.warpmail.net> <20110908191053.GA16064@sigill.intra.peff.net>
 <4E69C8F0.9070204@drmicha.warpmail.net> <87pqjaxbrm.fsf@lifelogs.com> <CAEBDL5VtVZcmQnj2CH7XzZ0YV_X61gO69-dXriGiYsAqk=NLPg@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Kyle Neath <kneath@gmail.com>,
	Jeff King <peff@peff.net>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Fri Sep 09 12:50:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1yfQ-0004M1-Tv
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 12:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758726Ab1IIKt3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Sep 2011 06:49:29 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64794 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758713Ab1IIKt3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2011 06:49:29 -0400
Received: by ywf7 with SMTP id 7so1494129ywf.19
        for <git@vger.kernel.org>; Fri, 09 Sep 2011 03:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=T9uN5K4lss6X/MCVL0QAQgIj2nO3dFwZIHIvRhWpMoU=;
        b=QyQxvObM9nMzm6LbqLrfaNcFnwwCMGDzyJw00OJosoV9mnK6p1Vav6o7MP+oqoFZWH
         MRNR3UvJQ6W+g1SXLHiiDbaKTdr/sWEmYeQjw4j79H9Zs8H+uTA74ErZTx0sE64KFi91
         gwVD9TRZb8gwDHwZsmrJi49PaWMabXZSRdbfU=
Received: by 10.68.27.9 with SMTP id p9mr2786144pbg.505.1315565368074; Fri, 09
 Sep 2011 03:49:28 -0700 (PDT)
Received: by 10.68.54.167 with HTTP; Fri, 9 Sep 2011 03:48:48 -0700 (PDT)
In-Reply-To: <CAEBDL5VtVZcmQnj2CH7XzZ0YV_X61gO69-dXriGiYsAqk=NLPg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181047>

On Fri, Sep 9, 2011 at 12:32 PM, John Szakmeister <john@szakmeister.net=
> wrote:
> [Added back some of the CC's]
>
> Ted: we don't usually cull the CC list on the git mailing list.
>
> 2011/9/9 Ted Zlatanov <tzz@lifelogs.com>:
> [snip]
>> MJG> ... and one for Git on Windows? It seems we're lacking both Win=
 and OS X
>> MJG> developers here.
>>
>> Windows doesn't have a standard keychain service, does it?
>
> No, it doesn't, but you can use the wincrypt API which allows you to
> at least encrypt the password from the user's login credentials. =A0I=
n
> particular, CryptProtectData() and CryptUnprotectData(). =A0That way =
you
> can at least have the password stored encrypted on disk.

Actually, it seems recent Windows versions does have a credential
manager, including an API:

http://www.yanzzee.com/2009/09/windows-keychain.html
http://msdn.microsoft.com/en-us/library/aa374731(v=3DVS.85).aspx#creden=
tials_management_functions
