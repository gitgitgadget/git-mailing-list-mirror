From: Grant <emailgrant@gmail.com>
Subject: Re: Does git have "Path-Based Authorization"?
Date: Fri, 30 Sep 2011 18:43:06 -0700
Message-ID: <CAN0CFw1-Edb5PdoTzJz38vJOjjXVAg6F24XgHpTi+3e5C7yxfQ@mail.gmail.com>
References: <CAN0CFw0QXkNSF8+qGu+pCrv5dgy1OEvtq-53f23GRd4RrZ1GcQ@mail.gmail.com>
	<1317427503.4331.37.camel@centaur.lab.cmartin.tk>
	<CAN0CFw0+v9qscJ+isQdwJOHT4Ajsk-96QK8gQFsu9E87a3j+Ww@mail.gmail.com>
	<CACsJy8Dm-vSoki9Fr7s=DH7oRYL-a=kF7q9mBwo55ZxsLg5DTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 01 03:43:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9obp-0001pN-9F
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 03:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754701Ab1JABnJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Sep 2011 21:43:09 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:35606 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369Ab1JABnI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Sep 2011 21:43:08 -0400
Received: by eya28 with SMTP id 28so1541774eya.19
        for <git@vger.kernel.org>; Fri, 30 Sep 2011 18:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=68l9zBFWit0X1jWSDRFDhu32uKwrIGzMARGo/H+3Rlc=;
        b=HOa8gAL0N/B4SV3AdbCND06D05QCGttBw+eZtwf74z5EuhGt6IIiPDqcv39S9LOrMM
         7QbKw42B4EpIC2Tc36iQl+oVJKOYdloHwlOurWBL2rvbr6Oiq0nIF2W7KlC+qKR+QiyA
         x5xtPiNAgNcwZYdLJX/zXnd3ATgXyPUUNWz2Q=
Received: by 10.213.112.201 with SMTP id x9mr98021ebp.141.1317433386883; Fri,
 30 Sep 2011 18:43:06 -0700 (PDT)
Received: by 10.213.4.136 with HTTP; Fri, 30 Sep 2011 18:43:06 -0700 (PDT)
In-Reply-To: <CACsJy8Dm-vSoki9Fr7s=DH7oRYL-a=kF7q9mBwo55ZxsLg5DTA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182532>

>> I have a series of files containing server-side code which make up a
>> website. =A0The entire layout contains only a few folders, but those
>> folders contain many files. =A0I want to be able to allow access to =
only
>> certain files at a time, sometimes only a single file. =A0Can that b=
e
>> done in the way you describe?
>
> If you can gather all sensitive files in a subdirectory, then you can
> split that directory into its own repository (see git-submodule man
> page) and grant limited access to that repo.
> --
> Duy

I thought about separating files the dev has had access to into a
separate folder from files the dev hasn't had access to, but it would
mean constantly changing the code as files move around, plus it would
be too complicated if I have multiple devs and want to give them
access to different stuff.  It's not that some files are more
sensitive than others, it's just that I don't want to give anyone
access to more than I have to.

- Grant
