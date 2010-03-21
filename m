From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Improve documentation for git-remote-helpers
Date: Mon, 22 Mar 2010 00:35:38 +0100
Message-ID: <fabb9a1e1003211635w27f0b22em73c7c6431c3998af@mail.gmail.com>
References: <f3271551003211026m376b86d6ga915f85a623eddfd@mail.gmail.com> 
	<f3271551003211121o48f502fp954b649ff4ca8f8b@mail.gmail.com> 
	<alpine.LNX.2.00.1003211907390.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 00:36:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtUgi-0005FO-QS
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 00:36:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753515Ab0CUXgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 19:36:00 -0400
Received: from mail-bw0-f211.google.com ([209.85.218.211]:62939 "EHLO
	mail-bw0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403Ab0CUXf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 19:35:59 -0400
Received: by bwz3 with SMTP id 3so4890680bwz.29
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 16:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=FHbd6wHTbcde1RxaN+9ABO8VY+YRbQREvJLnjWVkFQk=;
        b=k0lK6HiCpb4rMJa+n7d4cyG+UQG1v0uTDDLq8EFrekj77M6IH83Cao486nCc7I4FLu
         CAY04D/G6meIwZ9tbHNozfH28kAQbQwlG2koPu+Y0sNG2nyGrFpVrQgFhdBWTB3OvsHs
         3yDvQDPItEpLzJVUAjYcdYdeP7awKlmByaZ00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=YX5XbMF6PBC4rAu6qQPNmJLjgiJvX2TQLjlExgB2Gah/KZyxqaLNM3yeQaFLVRXULv
         ICp5V1D8qY0jeN5GfzRVjWm1vvP7LJjlIYrA0n+hX4WPWdjPKxISV7YgKdAV6NJHhN/L
         ciEFalvflPWUMkdTEZ4qRVRnOEa6hh7/4z+lU=
Received: by 10.204.33.149 with SMTP id h21mr2091210bkd.203.1269214558082; 
	Sun, 21 Mar 2010 16:35:58 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1003211907390.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142874>

Heya,

On Mon, Mar 22, 2010 at 00:29, Daniel Barkalow <barkalow@iabervon.org> wrote:
> Yup. Or maybe these should be documented as a list of capabilities which
> mean that the helper supports the command with the same name, since that's
> a common pattern, and documenting it as a pattern makes it obvious that,
> if we have a new 'export' command, and it needs a capability, it'll fit
> the pattern.

Speaking of which, I have uploaded a preliminary version of the export
capability to my github repository [0] since Ramkumar wanted to have a
look at it. Sadly I have not been able to test it yet, I wanted to
work on that today but instead spent hours on getting the first
argument to the helper to be 'origin' (or whatever the user sets it to
with the --origin option), something that's been bothering me forever.
No documentation yet though, working on that ;).

[0] http://github.com/SRabbelier/git

-- 
Cheers,

Sverre Rabbelier
