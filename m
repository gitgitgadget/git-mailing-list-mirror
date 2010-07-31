From: Benson Margulies <bimargulies@gmail.com>
Subject: Re: On MacOS, 1.7.2, git svn clone seems to fail silently
Date: Fri, 30 Jul 2010 21:34:54 -0400
Message-ID: <AANLkTim4T2NtRpyWfi8_8AVNYmVSqSsTnoA7fj69K-FA@mail.gmail.com>
References: <AANLkTimxqC3oax=Q0EppAb-Q7AzHshRkV=H=6dJDNhqY@mail.gmail.com>
	<20100731011332.GE5817@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 03:35:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of0ye-0006xG-0v
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 03:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626Ab0GaBe4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jul 2010 21:34:56 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57585 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab0GaBez convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jul 2010 21:34:55 -0400
Received: by wyb39 with SMTP id 39so1739975wyb.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 18:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9PkeheeWCUOHArBPTRnI9f9V+eo7GjWi2ZvvjwLV3oY=;
        b=YjK9dxXeyzOrrvrzJOysLLaWb0eoniEDS8/5RIP9Q7FeOg3opai7aW/ziq1ltPpJ2p
         XIew0gwtg8w+0cRhynpNITwDFeeq3Rn8qIDJk4kHKD/m7GzexsX6MDBSjylv0UGnSbYr
         UF88lg348CVQZnQ2jr0fR3kE8xEsLtZhHNE1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=k2QyDf9XEw8/Yg+VQrgCXTReWHEHGyXaP9HdjMtPD5eOl/ez5CGtGHSuJOb1cKraXr
         AkXOsu67iirVeSThVetGMNGyQDyNxpQ9fGSJdr9UEN4tYQyW4f+Gs6UE7yUHWqhNoOv4
         NJA7f8iYcOuIPwAGnmv1iy8rYaPYsjDUWJqUQ=
Received: by 10.216.165.132 with SMTP id e4mr2316056wel.86.1280540094420; Fri, 
	30 Jul 2010 18:34:54 -0700 (PDT)
Received: by 10.216.155.17 with HTTP; Fri, 30 Jul 2010 18:34:54 -0700 (PDT)
In-Reply-To: <20100731011332.GE5817@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152282>

On Fri, Jul 30, 2010 at 9:13 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Hi Benson,
>
> Benson Margulies wrote:
>> git svn clone -s https://gate.svn.sourceforge.net/svnroot/gate
> [...]
>> No errors, no messages. No branches, no contents. Just the
>> wind whistling through the bytes.

 I don't have $? at hand, but I can tell you that git branch -r says
 nothing, either. Also, running git fetch has the same result. Prints
 the same sort of trace lines if tracing, then does nothing

>
> Heh - you might be the one to figure out
> http://thread.gmane.org/gmane.comp.version-control.git/134936
>
> But first, it would be good to confirm:
>
> =C2=A0- if you run "echo $?" right after such a failure, what
> =C2=A0 status code do you get?
>
> =C2=A0- what is the output of "git branch -r" when you finish?
>
> Coping strategy: usually with "git svn clone" failures, you can resum=
e
> where you left off with "git svn fetch".
>
> Good luck,
> Jonathan
>
