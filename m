From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: [RFC] Possibility to choose ~/.config/git/config instead of ~/.gitconfig
Date: Fri, 25 May 2012 10:47:50 -0700
Message-ID: <CAE1pOi3qSEY=Dj-Fqj+=anULVmCdsm72_k+B0SpdGiCO3u7L9A@mail.gmail.com>
References: <20120525181526.Horde.VibLf3wdC4BPv7AeKacSMiA@webmail.minatec.grenoble-inp.fr>
 <CAE1pOi0eY2=eNzuTUVGmHuvfGWvxoXSJUADWr0CfPpVe5ktxow@mail.gmail.com> <20120525174237.GA4267@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: nguyenhu@minatec.inpg.fr, git@vger.kernel.org,
	matthieu.moy@grenoble-inp.fr,
	Valentin DUPERRAY <Valentin.Duperray@phelma.grenoble-inp.fr>,
	Franck JONAS <Franck.Jonas@phelma.grenoble-inp.fr>,
	Lucien KONG <Lucien.Kong@phelma.grenoble-inp.fr>,
	Thomas NGUY <Thomas.Nguy@phelma.grenoble-inp.fr>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@phelma.grenoble-inp.fr>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 19:48:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXycb-0001WV-96
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 19:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756530Ab2EYRsN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 May 2012 13:48:13 -0400
Received: from mail-qa0-f49.google.com ([209.85.216.49]:61811 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501Ab2EYRsM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 May 2012 13:48:12 -0400
Received: by qabj40 with SMTP id j40so1701686qab.1
        for <git@vger.kernel.org>; Fri, 25 May 2012 10:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Q4vrD/eIrp6zB00DK747JnMjaSngi3JDWy7a1Uy5po8=;
        b=rZAQGJ0yD7Y/wDBnN8xZrJ9+L9woIAB+Dq6ZF4RMtoGtHnWdC58pkW6DB5lziYWmd0
         38Caq+eVp75Bogj+MLraJNaGf79Y+vtj9UWNBmF0WinkGqtG9JG3AeSB3YZRe847kol1
         vn2EYxWfUhrQx9S/S1G91dm34BJt/5TQ/lHCQkh9sTPeAC+oG/zZlSYvwpjg+E0rbWnv
         bRF4QawLFOojKhh6EKtop7H8DSpJKdI0vIkbGphPg3+s3cCkgR5nW4ZkXGwg3ng40ycW
         qes8+hJSCkha36hFEus63FctvrVfjwu+lgCsjC09BM+VGKO3Vxbj0ckfMSx86XUzkP9/
         vUGQ==
Received: by 10.224.72.204 with SMTP id n12mr15753010qaj.89.1337968091485;
 Fri, 25 May 2012 10:48:11 -0700 (PDT)
Received: by 10.229.17.136 with HTTP; Fri, 25 May 2012 10:47:50 -0700 (PDT)
In-Reply-To: <20120525174237.GA4267@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198493>

On 25 May 2012 10:42, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi Hilco,
>
> Hilco Wijbenga wrote:
>
>> This is, of course, highly OS dependent. Ironically, I'd say we need=
 a
>> setting in .gitconfig for it. :-)
>>
>> There is also /etc(/default|/sysconfig|)/git/config to consider
>> (perhaps for some settings that should be the same for everyone).
>> Better yet, it would be nice if at least some settings could be part
>> of the repository itself (whitespace handling e.g.).
>
> The FILES section of git-config(1) might leave you happier. :)

Indeed!

> Regarding $GIT_DIR/config, it says "The filename is of course relativ=
e
> to the repository root, not the working directory.". =C2=A0Is this ou=
t of
> date? =C2=A0(Cc-ing Peff and Duy.)

I'm sure it's not. Somehow, I had gotten it in my head that this
wasn't possible. I am going to start using this right away. :-)
Thanks!
