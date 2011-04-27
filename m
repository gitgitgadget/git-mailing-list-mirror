From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 23:59:56 +1000
Message-ID: <BANLkTi=UTbcijkjy5yshJynq8K3Ok-xuDw@mail.gmail.com>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
	<4DB80747.8080401@op5.se>
	<BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
	<BANLkTikvwoCCmCofbVVPzmuA8uHxqATjTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 16:00:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF5Hh-0001uF-KK
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 16:00:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932744Ab1D0N77 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 09:59:59 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47205 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932509Ab1D0N77 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 09:59:59 -0400
Received: by eyx24 with SMTP id 24so520109eyx.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 06:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iL2JSexdsNPIyriXcY40X7tS4prmmiJJEzXg+VrJO8o=;
        b=Fk1LexOWMV1j1nrz4XEZ1dck/WfeERlzra0RWG9jf6wXoHFFIHRArvNYaSBJx08aTO
         +LMi6ey0QisFM5y/D4N2cP11KqWGqT/hfF++LihhEQI7vkOJWaWO2/tPDSnA/01/JEWh
         1rhkomfufWQ1UyYI2gzYzC9J4Blku9sr64uQI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Zr7tTHiRc9Bw0TwemrO0umSpxautTZoWFDH2GVO3tQ3jkeu9R8vkjVMavBRV2Pl1Xh
         DQ2IM7et3nfQezMRxuJJVm+9EsimpKKqJbCt5CXnirR0CqTf0huv860hD6emnGxqAez2
         pxoCnczhLfxL9ivdKkDrzNwiJWa96HFLAKMR4=
Received: by 10.14.10.130 with SMTP id 2mr980401eev.181.1303912797505; Wed, 27
 Apr 2011 06:59:57 -0700 (PDT)
Received: by 10.14.22.68 with HTTP; Wed, 27 Apr 2011 06:59:56 -0700 (PDT)
In-Reply-To: <BANLkTikvwoCCmCofbVVPzmuA8uHxqATjTg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172237>

On Wednesday, April 27, 2011, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Wed, Apr 27, 2011 at 3:50 PM, Jon Seymour <jon.seymour@gmail.com> =
wrote:
>> On Wednesday, April 27, 2011, Andreas Ericsson =C2=A0wrote:
>>> Horrible idea. There are already as many package managers as there
>>> are packages without us throwing another one into the mix.
>>
>> I agree that there are too many package managers. But do you know
>> what? There isn't a single package manager that reliably works acros=
s
>> platform. apt-get? great. Except you need something else for Mac,
>> cywgin, or, um Fedora. Brew? Fine then you only need to worry about
>> Linux and cygwin. Cygwin? ...
>
> gem works on all of them :)
>

Ah. but you have just made things harder for yourself.

Assuming you use two words to install ruby, one as a command
separator, you need to deploy gitwork with just one word.

That said, I have heard that ruby is a _very_ concise language :-)

jon.
