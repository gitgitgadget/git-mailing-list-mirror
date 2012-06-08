From: konglu@minatec.inpg.fr
Subject: Re: [PATCHv3 2/2] rebase [-i --exec | -ix] <CMD>...
Date: Fri, 08 Jun 2012 21:15:40 +0200
Message-ID: <20120608211540.Horde.SRiCRHwdC4BP0k9c5TdWBaA@webmail.minatec.grenoble-inp.fr>
References: <1338978856-26838-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339167235-2009-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339167235-2009-2-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <4FD24AE9.8020101@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Torsten =?iso-8859-1?b?QvZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Jun 08 21:15:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd4f2-0001iS-Bk
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 21:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758188Ab2FHTPr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jun 2012 15:15:47 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:56723 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756575Ab2FHTPp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2012 15:15:45 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 7B9451A02DE;
	Fri,  8 Jun 2012 21:15:41 +0200 (CEST)
Received: from reverse.completel.net (reverse.completel.net [92.103.38.66])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Fri, 08 Jun
 2012 21:15:40 +0200
In-Reply-To: <4FD24AE9.8020101@web.de>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199519>


Torsten B=F6gershausen <tboegi@web.de> a =E9crit=A0:

> On 08.06.12 16:53, Lucien Kong wrote:
>> This patch provides a way to automatically add these "exec" lines
>> between each commit applications. For instance, running 'git rebase =
-i
>> --exec "make test"' lets you check that intermediate commits are
>> compilable. It is also compatible with the option --autosquash. At
>> this point, you can't use --exec without the interactive mode (-i).
>>
>> Tests about this new command are also added in
>> t3404-rebase-interactive.sh.
>
>> Should now work on MacOS.
>
> Hej,
> I'm not sure on which commit to apply the patch.
> (may be we shoud improve git format-patch to tell us the original com=
mit ID),
> but if I remove the non applying part, it looks like this:

Which part does not apply ? If you skip the part that's implementing th=
e
exec option, of course Git will not recognize it.
