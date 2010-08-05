From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH/RFC] fetch: allow command line --tags to override config
Date: Thu, 5 Aug 2010 17:56:05 +0800
Message-ID: <AANLkTikf96RLfTq4Q6DAPesr6j70CJfT8vBzidJk42dE@mail.gmail.com>
References: <1280948202-17385-1-git-send-email-ComputerDruid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
To: Daniel Johnson <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 11:56:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgxBP-0004jj-R7
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 11:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759951Ab0HEJ4K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 05:56:10 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34897 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574Ab0HEJ4I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Aug 2010 05:56:08 -0400
Received: by iwn33 with SMTP id 33so13455iwn.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 02:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8A7EAYXaM2XBq+AERKbfi1hwd1Ccz2wvxsD+4uidUEg=;
        b=xnRgCSXnoK6SwdXjNiQQfwNVHfRqUQGywDnIBcbatlvfBaPz5UhisT6GzYdjT3bFAL
         fXWUn3pIz8f5rfz5B7lOw5qZ7lldXL1+CQseSwc3YlwvCA8XKckT7zJbRgJUfwtJ8Tb0
         J7aM7HyV4UvCfvYf9VcywhZczYhG2kJ4ja2uQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Iv8yp1szC3sAbA/yXs8gIwyB2EjHJIKokpfR1MJpDLChLFxTDa/Xq+4+X6X/ur3fIR
         VfeBJQd6laQvXa9apWuDv6gtkWPziVrurX44v9v4Me56ogmzhv5enkPxo9WMw+685CBE
         qkMOGHfwMwVks/iXVbCzhgfEq2y5RxLC8W9qM=
Received: by 10.231.167.80 with SMTP id p16mr11824170iby.119.1281002166149; 
	Thu, 05 Aug 2010 02:56:06 -0700 (PDT)
Received: by 10.231.151.130 with HTTP; Thu, 5 Aug 2010 02:56:05 -0700 (PDT)
In-Reply-To: <1280948202-17385-1-git-send-email-ComputerDruid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152628>

Hi,

On Thu, Aug 5, 2010 at 2:56 AM, Daniel Johnson <computerdruid@gmail.com=
> wrote:
> Originally, if remote.<name>.tagopt was set, the --tags and option wo=
uld
> have no effect when given to git fetch. So if
> tagopt=3D"--no-tags"
>
> =A0 =A0 =A0 =A0git fetch --tags
>
> would not actually fetch tags.
>
> This patch changes this behavior to only follow what is written in th=
e
> config if there is no option passed by the command line.
>
> Signed-off-by: Daniel Johnson <ComputerDruid@gmail.com>

This is pretty confusing as it is. Could you please provide a patch
for the git-fetch documentation too?

--=20
Cheers,
Ray Chuan
