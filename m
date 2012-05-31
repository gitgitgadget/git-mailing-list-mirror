From: konglu@minatec.inpg.fr
Subject: Re: [PATCHv4 3/3] Advices about 'git rm' during conflicts (unmerged
 paths) more relevant
Date: Thu, 31 May 2012 09:59:14 +0200
Message-ID: <20120531095914.Horde.McdhLnwdC4BPxyTSG9v3ctA@webmail.minatec.grenoble-inp.fr>
References: <1338226598-16056-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338384216-18782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338384216-18782-3-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <vpq7gvsrfr0.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=";";
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen Lucien 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 31 09:59:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa0Hy-00051h-1U
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 09:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757932Ab2EaH7R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 03:59:17 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:57990 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757764Ab2EaH7R (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 May 2012 03:59:17 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 5F49B1A02F6;
	Thu, 31 May 2012 09:59:14 +0200 (CEST)
Received: from wifi-028110.grenet.fr (wifi-028110.grenet.fr
 [130.190.28.110]) by webmail.minatec.grenoble-inp.fr (Horde Framework) with
 HTTP; Thu, 31 May 2012 09:59:14 +0200
In-Reply-To: <vpq7gvsrfr0.fsf@bauges.imag.fr>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198871>


Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> a =C3=A9crit=C2=A0:

>> Subject: Re: [PATCHv4 3/3] Advices about 'git rm' during conflicts =20
>> (unmerged paths) more relevant
>
> "more relevant" doesn't say much, and your subject line doesn't say i=
t's
> about "status". What about
>
> status: don't suggest "git rm" if not appropriate
>
> ?
In the case of only 'both deleted', what we don't want 'git status' to =
suggest
is "git add". Maybe something like

status: advices appropriated during conflicts
or
status: don't suggest "git rm" or "git add" if not appropriate

would fit.
