From: Ray Chen <rchen@cs.umd.edu>
Subject: Re: [PATCH/RFC] git-svn: New flag to add a file in empty directories
Date: Wed, 18 May 2011 06:59:23 -0400
Message-ID: <BANLkTimGrkL2KjGC652tr3=Y0h02C_fzaQ@mail.gmail.com>
References: <1305669635-10861-1-git-send-email-rchen@cs.umd.edu>
 <4DD373CD.6010607@alum.mit.edu> <20110518083314.GA22204@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed May 18 12:59:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMeTl-0007bU-CA
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 12:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932862Ab1ERK7o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 May 2011 06:59:44 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63185 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932711Ab1ERK7n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2011 06:59:43 -0400
Received: by ywe9 with SMTP id 9so308041ywe.19
        for <git@vger.kernel.org>; Wed, 18 May 2011 03:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=LPUIxPCaWuThrXPFGEgbW0PcNZDpRbHHSu7Qlav2pPY=;
        b=oq6alxmum0l8K3UrbILjiqqCt2t+2eXTdZXZgWAtEJ5e1KZh2rT5qx4kHROyW8Hiq5
         mbqg44NTCTHSaL5HNwJe5MqbHT1dc5BLQJ1rcH3fdkxSt7JweqU8g0gG3rY9KKTXGKoP
         ZCMClhWwAxbuSP0n6ipZfeDvsvgM01QTrdGyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=rdEZz+6Wpo5mQbcb9Nn6SgkMn36OCUHUCAUgEEQebmtj5dRAd1nEClwYjuAPU4aFkx
         j3T+JMJ9mfiRBPXvtRSDDA4O1/FSAQ1rH9jek7jdGWW9L40K8Ur1v8xI8nONuaLufMfi
         egl2zi/z6VU6ZLkCtn1beJDxqXgKDQqZTzKrQ=
Received: by 10.236.156.202 with SMTP id m50mr1766546yhk.407.1305716383157;
 Wed, 18 May 2011 03:59:43 -0700 (PDT)
Received: by 10.236.111.44 with HTTP; Wed, 18 May 2011 03:59:23 -0700 (PDT)
In-Reply-To: <20110518083314.GA22204@dcvr.yhbt.net>
X-Google-Sender-Auth: N0M2CoYiL3ZJCfGUjD2RKk0niGc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173871>

On Wed, May 18, 2011 at 4:33 AM, Eric Wong <normalperson@yhbt.net> wrot=
e:
>
>> 4. If it is a goal to support long-term tracking of a Subversion
>> repository, then it would be good to add a config option to turn on =
this
>> feature permanently for a git-svn repository, so that the user doesn=
't
>> have to enter the extra options with each command invocation.
>
> Command-line options should be automatically converted into config fi=
le
> options inside git svn. =A0We should however discourage this from get=
ting
> mixed...
>
I'm not sure what you mean by this.  Do you mean that options
shouldn't be settable both on the command line and the config file?  I
think this situation already exists with the --no-metadata option.

>
>> 6. Documentation patches would also be required.
>
> Agreed, along with automated test cases.
>
No problem.  Might take a while, though.  I haven't looked at the test
case system yet.

- Ray
