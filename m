From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: how to git with google code
Date: Sun, 28 Nov 2010 12:27:27 +0800
Message-ID: <AANLkTi=kuAkJSeJAWYQokOM2NFo08_98Eoodw_cz_c0r@mail.gmail.com>
References: <AANLkTi=5muNrriBoU0ZGnMqQUOjrJAvwLfyYO07-Ad3m@mail.gmail.com>
	<4CEFCE5E.1050003@drmicha.warpmail.net>
	<AANLkTik_HMVsHuvA00ZCcGJaOS_m8Tipq_fDyLucG9wN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Bond <jamesbond.2k.g@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 28 05:27:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMYrQ-0004Jr-Q0
	for gcvg-git-2@lo.gmane.org; Sun, 28 Nov 2010 05:27:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396Ab0K1E1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Nov 2010 23:27:31 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62927 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055Ab0K1E1a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Nov 2010 23:27:30 -0500
Received: by eye27 with SMTP id 27so1455229eye.19
        for <git@vger.kernel.org>; Sat, 27 Nov 2010 20:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=YE0K8DA0fARk02KbH+CD2iknVTAon2t0u6qvsV/Juzo=;
        b=J1q/D10OF9x7rnEWiqP8LlvWLce6RPLCpR/5MjxKPv1+nFVRk6sMvoLuMX4GRVzEIO
         BAM29qW1CkeGZDUypxyC7Wi3xvTricMnevSzOs+fQwAwtSyTKbZZYW7t9pdQkv09zeqU
         H5a890xRNU3cTeVKtUOKEjuaBAOnfPp2bveBA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=V4tmcSPGiJnwfZotnwdqtVM5ux5iupEaptrc2oFDS/x7wz2e4cHkcDMnSab8FhjUTZ
         B/4eQe3TgYCJqjm3fDe06FNTBEAGwJall4tNeELDl51HDK/dltkcceflIg4LwTXy73rf
         yDKPnFlsbMQNQbrweBXiz1+YPGlKYEMPLeYZU=
Received: by 10.213.105.76 with SMTP id s12mr5343710ebo.2.1290918448010; Sat,
 27 Nov 2010 20:27:28 -0800 (PST)
Received: by 10.213.112.195 with HTTP; Sat, 27 Nov 2010 20:27:27 -0800 (PST)
In-Reply-To: <AANLkTik_HMVsHuvA00ZCcGJaOS_m8Tipq_fDyLucG9wN@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162333>

Hi,

On Sat, Nov 27, 2010 at 10:50 AM, Bond <jamesbond.2k.g@gmail.com> wrote:
> On Fri, Nov 26, 2010 at 8:42 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>>
>> http://code.google.com/p/support/wiki/ImportingFromGit
> Your link says
> "Naturally, your official source tree lives on some Git-capable server,"
> which is not the case.I have it on my local machine and I never used git before.

You can take "official source tree" and "Git-capable server" to be
your git repo that you git init-ed in your first post. But it's empty
isn't it? So, just skip the "git fetch" step. That leaves:

  $ git svn clone ...
  $ cd trunk

Then go on from there.

-- 
Cheers,
Ray Chuan
