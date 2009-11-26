From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: OS X and umlauts in file names
Date: Thu, 26 Nov 2009 12:27:36 -0500
Message-ID: <76718490911260927h9ff796bgbebcccab7e52ffbe@mail.gmail.com>
References: <4B0ABA42.1060103@syntevo.com>
	 <alpine.LNX.2.00.0911231403100.14365@iabervon.org>
	 <4B0CEFCA.5020605@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 18:27:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDi87-0005Ys-Gs
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 18:27:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760115AbZKZR1b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Nov 2009 12:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760031AbZKZR1b
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 12:27:31 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:55749 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759219AbZKZR1a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Nov 2009 12:27:30 -0500
Received: by iwn1 with SMTP id 1so554170iwn.33
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 09:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=O0iyCYcubHjFqwjuiIWV6FdegIxmLA8Ka0q9g1XKEqc=;
        b=Y48ELGj016fawCQm1U+duTwgRXhMby6Z8av7VoH6RfD98qNYFdZgGbQ3yuR4bDVhwf
         uHWLyvdx8FAiIZ5vUZto/YeOI7r4TkCE0o2EG5c1yLK0dywjbcES6AINUvh0clTRSB+B
         fVQLQu0s/sYkA/YBG8Z2fRb5jERRkyEm8Y5Vk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MLlkXm0VVELJlaXP/CYWx8Z7xTBosRJc+zRfRwtL+BfMzC+f6FBlX2E721pbI7C5+e
         KLKydML+PaU5RAGmfNRMYV0h4InyZ55nyMCeEEkuazWd7AGj7AwFk95LcR2vXAAEnHFp
         nHFa/tVynk4CmYlRAfVFrYlMcORbyCjHDaVz0=
Received: by 10.231.6.79 with SMTP id 15mr6874839iby.36.1259256456751; Thu, 26 
	Nov 2009 09:27:36 -0800 (PST)
In-Reply-To: <4B0CEFCA.5020605@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133814>

On Wed, Nov 25, 2009 at 3:50 AM, Thomas Singer
<thomas.singer@syntevo.com> wrote:
> I've did following:
>
> =C2=A0toms-mac-mini:git-umlauts tom$ ls
> =C2=A0=C3=9Cberl=C3=A4nge.txt
> =C2=A0toms-mac-mini:git-umlauts tom$ git status
> =C2=A0# On branch master
> =C2=A0#
> =C2=A0# Initial commit
> =C2=A0#
> =C2=A0# Changes to be committed:
> =C2=A0# =C2=A0 (use "git rm --cached <file>..." to unstage)
> =C2=A0#
> =C2=A0# =C2=A0 =C2=A0 new file: =C2=A0 "U\314\210berla\314\210nge.txt=
"
> =C2=A0#

Wait, what's the problem here? It's staged according to the above,
just commit it.

j.
