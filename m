From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: Git drawbacks?
Date: Mon, 9 Nov 2009 08:21:28 -0800
Message-ID: <8c9a060911090821h678ace9bg978c185bda94e3f4@mail.gmail.com>
References: <loom.20091106T160709-387@post.gmane.org> <32541b130911060849s2d8f13f5sb9b8390f075f8d15@mail.gmail.com> 
	<loom.20091106T180313-750@post.gmane.org> <32541b130911060951q3358ce9ahe28fb0cf902853f2@mail.gmail.com> 
	<alpine.DEB.2.00.0911061051540.3216@asgard.lang.hm> <loom.20091109T084539-720@post.gmane.org> 
	<8c9a060911090634p4e036208mfb3160eb4c4430e9@mail.gmail.com> 
	<loom.20091109T165620-587@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dmitry Smirnov <divis1969@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 17:21:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7X06-0002Rd-9K
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 17:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085AbZKIQVn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Nov 2009 11:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbZKIQVn
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 11:21:43 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:58342 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbZKIQVm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2009 11:21:42 -0500
Received: by pwi3 with SMTP id 3so702296pwi.21
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 08:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=V/rLfd5Y1NkEfNt0oRt8mh6EyuQBwN9Id9PqBs47jZo=;
        b=SO+5AJW2iwQ6ULKEPEAWpo7ygtqPaC3GWtWIFrflWlM3PqESA1NwvJAJqXO39kYrDy
         FzO6cjRM9ZmesJTFCJ9WG0JJZawZbFStWsekHa7+AEink2rLAqdj12NCrDJtgd1H/u9E
         YJpmYoKEUnyVZ8SYNhSQJl7b+HJjP88qwsjdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=q+RadEsQIeFYXCFPIit81Ag+U2615fUVKT6AlkaYqJ5BQ+jxqcXUhtVoUmV+tNc0U9
         QrQkwtyqoPdv1RbYl5OZ/nMHya8hnzKSaJE/soKmC4tZqYycjI1GiY9v31HX7PkYhlB3
         tTm6ktu9OtnJ1TbPYQ1ovGitSklV4hSkKDJFo=
Received: by 10.140.172.15 with SMTP id u15mr275264rve.294.1257783708078; Mon, 
	09 Nov 2009 08:21:48 -0800 (PST)
In-Reply-To: <loom.20091109T165620-587@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132492>

On Mon, Nov 9, 2009 at 07:59, Dmitry Smirnov <divis1969@gmail.com> wrot=
e:
> Jacob Helwig <jacob.helwig <at> gmail.com> writes:
>
>> It does have a few caveats, however. =C2=A0If you have the same bran=
ch
>> checked out in two different working copies created using
>>...
>> place on your machine, you'll never notice, thuogh.
>
>
> So, i cannot recover from this situation by upmerging to the new head=
?
>

If you haven't actually made any changes in the second checkout of the
branch, then recovery is a simple reset --hard.  If you have made any
changes in that working copy, then recovery is a bit more complicated,
and it's probably best if I leave that explanation up to someone else,
since I'm very careful to avoid this situation in the first place, and
have never actually had to recover from it.
