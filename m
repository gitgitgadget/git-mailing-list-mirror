From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Make 'git stash -k' a short form for 'git stash save 
	--keep-index'
Date: Mon, 27 Jul 2009 14:24:18 -0700
Message-ID: <fabb9a1e0907271424x5495a228r779efe9794848880@mail.gmail.com>
References: <cover.1248719786u.git.johannes.schindelin@gmx.de> 
	<76cdda0d6cf911449d16ebb86f54641620135fca.1248719786u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 27 23:24:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVXgg-0008Dn-Lh
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 23:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755010AbZG0VYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 17:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755008AbZG0VYk
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 17:24:40 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:44559 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755005AbZG0VYj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 17:24:39 -0400
Received: by ewy26 with SMTP id 26so3524887ewy.37
        for <git@vger.kernel.org>; Mon, 27 Jul 2009 14:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=EhAl6Bq/Pvd0x2naUjHWd5e9x9/efidD9xvSChUyqlk=;
        b=caqKcxjT/4g22VRR78ZK9c9lb5i1mgySXrmUs6ACaLUJ5f+VSuN5VOHqciG3CK45hO
         e9QMxsK0si72QlSLyG1B7JuYdchCgIxO4xqJgae3S4nE1RDhCk6CrwJRTcgZAQPo/S/v
         a0mSxYQwfEwdwIAhbc2NlZJQJWNem/hXd3/g4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Iq41brcPePczbgHVwXfMlt4XmlLCqo+9IjwfNMOvulfThycej34XzEwCZ11oDc9WM2
         oXWDkZMzskKEOMjOGdB1zM7iVNSzFNwGgTTwv3ZzS3bOf7cL8JeJsOLWvStDZtM5+6HU
         v8HbkDUwE3XwrEg/e/6xOvREmdHQ1vyYdebUw=
Received: by 10.216.18.212 with SMTP id l62mr1858083wel.76.1248729878180; Mon, 
	27 Jul 2009 14:24:38 -0700 (PDT)
In-Reply-To: <76cdda0d6cf911449d16ebb86f54641620135fca.1248719786u.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124197>

Heya,

On Mon, Jul 27, 2009 at 11:37, Johannes
Schindelin<johannes.schindelin@gmx.de> wrote:
> To save me from the carpal tunnel syndrome, make 'git stash' accept
> the short option '-k' instead of '--keep-index', and for even more
> convenience, let's DWIM when this developer forgot to type the 'save'
> command.

+many, especially the DWIM part! Does it also grok 'git stash --keep-index'?


-- 
Cheers,

Sverre Rabbelier
