From: konglu@minatec.inpg.fr
Subject: Re: [PATCHv2] Warnings before rebasing -i published history
Date: Mon, 11 Jun 2012 13:36:18 +0200
Message-ID: <20120611133618.Horde.ife5dHwdC4BP1dgywnBALiA@webmail.minatec.grenoble-inp.fr>
References: <1339104053-7782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339409091-28150-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <vpq1ulm86dh.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=";";
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 11 13:36:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se2v4-00076B-73
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 13:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548Ab2FKLgW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 07:36:22 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:53251 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753215Ab2FKLgV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jun 2012 07:36:21 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 276F21A02E0;
	Mon, 11 Jun 2012 13:36:19 +0200 (CEST)
Received: from wifi-031218.grenet.fr (wifi-031218.grenet.fr
 [130.190.31.218]) by webmail.minatec.grenoble-inp.fr (Horde Framework) with
 HTTP; Mon, 11 Jun 2012 13:36:18 +0200
In-Reply-To: <vpq1ulm86dh.fsf@bauges.imag.fr>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199644>


Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> a =C3=A9crit=C2=A0:

> Lucien Kong <Lucien.Kong@ensimag.imag.fr> writes:
>
>> "git rebase -i" can be very dangerous if used on an already publishe=
d
>> history. This code detects that one is rewriting a commit that is an
>> ancestor of a remote-tracking branch, and warns the user through the
>> editor. This feature is controlled by a new config key
>> rebase.checkremoterefs.
>
> For the lazy, you could provide an example of result in the commit
> message. People don't want to review how the patch is written if they
> disagree with the result.

Right, but wouldn't it be better to put the example in the doc
git-rebase.txt ?
