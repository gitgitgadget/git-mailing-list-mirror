From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH 0/2] Documentation: kicking the "reset --hard" habit
Date: Sun, 31 Oct 2010 17:25:20 +0000
Message-ID: <AANLkTiknyZBeWY8Z14EF+uq_2feJxJniVBwpwjUHgdEF@mail.gmail.com>
References: <20101029083516.GA26290@burratino>
	<vpqzktwv3yx.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	bebarino@gmail.com, srabbelier@gmail.com,
	Thomas Rast <trast@student.ethz.ch>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Oct 31 18:25:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCbf0-0007BU-OD
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 18:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756332Ab0JaRZ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Oct 2010 13:25:27 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41727 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756297Ab0JaRZW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Oct 2010 13:25:22 -0400
Received: by fxm16 with SMTP id 16so4382047fxm.19
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 10:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jatrNbyX16inaYyBof/c9akJObCUmny36JVu5/P8MPc=;
        b=WKygCrkJsxQDqCivR+R0fW0CADLo5hczNVhOmDn13Wjprem3r2xh9h72+InvRLvBHe
         VU702vLXEMSO6mRU+F5UhB70p7eQM3rpZTW3SjqhKuKjfynfys8t298LAvNQi+oXbZsx
         CuRY5nkuKriYgCXYS2Eivlepzk0ehFhmq+1ww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BAf38SEsShKtEI3SeSkSQfIvcS45VCq+3ggfbjqQroU+FRGA/ee2eUirSWzdyW6MHs
         0vPhWRAK8XQ+Jt/2Pk5gv2Rl0X7TSol4YIcwaRlWLyLbi893kZqr5in7N54eggIlKGYZ
         vxnjoFo3QkYdvKd7AAn3+e4WVn9lRdE4FLk9E=
Received: by 10.223.96.70 with SMTP id g6mr2446093fan.54.1288545920137; Sun,
 31 Oct 2010 10:25:20 -0700 (PDT)
Received: by 10.223.123.203 with HTTP; Sun, 31 Oct 2010 10:25:20 -0700 (PDT)
In-Reply-To: <vpqzktwv3yx.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160443>

On Sat, Oct 30, 2010 at 01:55, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:

>> Sadly, at least the user manual change suggested below is probably
>> not suitable, since reset --keep and --merge have not been around
>> since git 1.5.3 days. =C2=A0Ideas for working around that and other
>> comments would be welcome.
>
> Do we really want to keep the user manual compatible with 1.5.3
> forever? It's nice to keep the user manual usable by slightly outdate=
d
> Gits, but 1.5.3 starts being really old, and older docs are still
> available on the web (like
> http://www.kernel.org/pub/software/scm/git/docs/v1.5.3.8/git.html ).

I didn't know we even did this with our user manual. When I read
manuals for version X (e.g. PostgreSQL, Emacs or libc versions) I
fully expect the features described to only work on the documented
version unless otherwise noted.
