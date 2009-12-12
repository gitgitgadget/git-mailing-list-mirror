From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: FEATURE REQUEST: Announce branch name with merge comamnd
Date: Sat, 12 Dec 2009 02:35:49 +0100
Message-ID: <81b0412b0912111735v474a9d3k5a24024c2d51587b@mail.gmail.com>
References: <87zl5p1gsp.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sat Dec 12 02:36:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJGtx-00084z-OO
	for gcvg-git-2@lo.gmane.org; Sat, 12 Dec 2009 02:36:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761455AbZLLBfp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Dec 2009 20:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761390AbZLLBfo
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 20:35:44 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:45313 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758394AbZLLBfo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Dec 2009 20:35:44 -0500
Received: by bwz27 with SMTP id 27so1017176bwz.21
        for <git@vger.kernel.org>; Fri, 11 Dec 2009 17:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=itNtNJbNqC+B64WAUGL2N2USN1ARg4aiwfTZKoXIc+Q=;
        b=RU/GmGmsyW4fVnva7TJIh1LCiFulVD3i+6U7io5RJbYf+N2Z4uVLaZkt7KZD/FB34T
         oFobI95sfrjriuiahHcpzsCgTwhwwSvmeMoCj2bczztXvtGE9IxLUnL7q4v8mbLIUysQ
         dFhlfabxjjJ0iJT2Wmh0wsc5jn/2vz9AYDkF0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cpIgiAqS+BYR3eyxvrW1zKD6ON9qd7Oqj3WWU1D13oE8uJRzWiol70IwWKeHRTDmLG
         PV+UZi+VsTAw2rJB5y4uOBb9gbaTLVH0KDOg3+3vIc/Ws1tkpGU6MGSMiWsQTrCyixXn
         u6rJjz5qZJWzYvw2MYRGiyIhaTGjuCK9qQ4rQ=
Received: by 10.204.34.69 with SMTP id k5mr1217099bkd.9.1260581749486; Fri, 11 
	Dec 2009 17:35:49 -0800 (PST)
In-Reply-To: <87zl5p1gsp.fsf@jondo.cante.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135112>

On Fri, Dec 11, 2009 at 19:55, Jari Aalto <jari.aalto@cante.net> wrote:
> Please announce the branch name being merged so that the listing is
> easier to follow (possibly only with --verbose, -v option). Add
> "Branch: <name>" just before the merge is attempted. somethiglike thi=
s
>
> =C2=A0 =C2=A0Branch: bug--manpage-fix-hyphen
> =C2=A0 =C2=A0Trying simple merge with c87c49b1e413e5dc378d7e6b1695176=
1a1e82f6d

It is not exactly "easier" to follow in your case. It is more
text and there is no immediately visible cue that the two
lines are related. You have to give the observer this information.
Put reference name and SHA-1 on the same line?
