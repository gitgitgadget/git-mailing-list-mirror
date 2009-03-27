From: John Tapsell <johnflux@gmail.com>
Subject: Re: Problem Creating Commit Messages
Date: Fri, 27 Mar 2009 06:08:55 +0000
Message-ID: <43d8ce650903262308s2ebb5740m106bd96ae1ec2284@mail.gmail.com>
References: <22735968.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: bggy <balishaggy@yahoo.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 07:12:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln5IQ-00015i-Sp
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 07:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752446AbZC0GI7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Mar 2009 02:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbZC0GI6
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 02:08:58 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:48545 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbZC0GI5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Mar 2009 02:08:57 -0400
Received: by wf-out-1314.google.com with SMTP id 29so1140111wff.4
        for <git@vger.kernel.org>; Thu, 26 Mar 2009 23:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dfq0frYGYkOvm/ycApNl75YeWmjj9wHz2vTvdBHed9o=;
        b=PdanN2qV3YnAgOUjEbGlPxeYt8xj+ueuD2y1RmbgoKZkziget5nzrg3AAiTN0s4jgd
         aSqJ9i69Z+4C6tS76eiJlHIGULbEdHsxlaGOHsmg4HfbqyjetXbB7+Ov/nR+u/7LcYpb
         uvbgF394gKayIoTFjp9hd10Crn8q1Y+LN5p1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=H9k90VOsasIcYw5H/DHTmmp85TyitsiILXMH87ILUkr+0C2VFIWY2F/jo3Z/VHFR3P
         WxFGpxEgoGjqVRrGec7rF226qFQ0v3IFXgSP5sVAteKeQhEHxf4wVY4zLiMrjtdBqNOG
         2LBidszQtNc0dsiXJatcR8fsmFBCwU8+EPfJ4=
Received: by 10.142.158.3 with SMTP id g3mr739354wfe.265.1238134135870; Thu, 
	26 Mar 2009 23:08:55 -0700 (PDT)
In-Reply-To: <22735968.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114852>

2009/3/27 bggy <balishaggy@yahoo.com>:
>
> Hello, I'm new to git and I haven't been able to create commit messag=
es in
> either vim or textmate(changed core.editor to mate). =C2=A0I can crea=
te commit
> messages when I use the -m option, but I like creating multiple-line
> messages and it's easier to do it with a fresh line-break in the term=
inal.

You could use a simple text editor like "joe".

> Using textmate I saved and closed the textmate file that pops up afte=
r $git
> commit -a, but git responds that the commit was terminated due to an =
empty
> message.

Sometimes graphical editors return on the command line before they
actually quit.  This might be what is happening here.  If so, you
could file a bug against textmate.

John
