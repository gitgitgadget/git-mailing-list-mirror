From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] GIT connect "connect to host HOSTNAME port 22: Bad file
 number" message shown
Date: Wed, 1 Dec 2010 14:33:27 +0100
Message-ID: <AANLkTi=tm9wX08_o2xgmSS371atgsfPqydT-AZLYxNwJ@mail.gmail.com>
References: <AANLkTi=GnOJvZE1hGcCbRq9G8KrqnM2ULXZXRCAP-Gpv@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: GAURAV BAHL <engg.bahl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 14:33:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNmok-0005As-GF
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 14:33:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754993Ab0LANdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 08:33:50 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44829 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754182Ab0LANdt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 08:33:49 -0500
Received: by fxm20 with SMTP id 20so51501fxm.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 05:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type;
        bh=lOiof5V6peFPQU/3ay4jElU0zvx5tkUu/mdogc6LZNI=;
        b=l4gFIRsCXcG/uaT6B7wRAg+2vUA3OynYqK6toK6kH2YcJNBPS7NNJs6w0DcBq7Xy/r
         iDP0tpWWXwd/0ydO3baNTSrbiJKmC4PJSIWvYeErAQLyK+WFy7ulkSSTxCk56xFuMacy
         P7CQWJzvf8tfBSvGWqiUvVnmh/J+CMfFWFXhY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=AuV3lYYd5ILdBzXhSmAZKY9BgHM9RlmmOpLVxNK/GkRWX36LMbtjD2/TL6n3UKzHys
         qEC7QWghRXbHR0cD9rJahjY4GmykLqi2z+DDp98KToJyJuUzHmudJXSTR6LPvLz4f+pW
         DVOh1/zJWoI96hhE6a/bDBg9iVc8bcGGjygZk=
Received: by 10.223.100.4 with SMTP id w4mr7197737fan.26.1291210427942; Wed,
 01 Dec 2010 05:33:47 -0800 (PST)
Received: by 10.223.72.206 with HTTP; Wed, 1 Dec 2010 05:33:27 -0800 (PST)
In-Reply-To: <AANLkTi=GnOJvZE1hGcCbRq9G8KrqnM2ULXZXRCAP-Gpv@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162515>

On Wed, Dec 1, 2010 at 1:48 PM, GAURAV BAHL <engg.bahl@gmail.com> wrote:
>
> My Manager asked me sent it out c/Documents and Settings
> Administrator/.ssh/id_rsa.pub file to someone for adding so that git should
> be available to me.
> Once done with the approval , I tried with above command and faced Bad file
> name issue
>
> Let me know for more Infn.
>
> After addition of the key the GIT bash Testing connection using (ssh
> git@HOSTNAME info) command outputs as
>
> gaurav.bahl@008_GAURAVB ~
> $ ssh git@HOSTNAME info
> ssh: connect to host HOSTNAME port 22: Bad file number
>

You probably need to replace "HOSTNAME" with the host name of the
server you want to test the connection against.
