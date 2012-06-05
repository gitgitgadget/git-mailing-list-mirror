From: nguyenhu@minatec.inpg.fr
Subject: Re: [PATCHv5 2/4] Let core.excludesfile default to
 $XDG_CONFIG_HOME/git/ignore
Date: Tue, 05 Jun 2012 15:17:43 +0200
Message-ID: <20120605151743.Horde.U7dqenwdC4BPzgb3V6TSvjA@webmail.minatec.grenoble-inp.fr>
References: <1338585788-9764-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338754481-27012-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338754481-27012-2-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <vpqpq9fs3oi.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=";";
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>, git@vger.kernel.org,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>,
	Valentin DUPERRAY <Valentin.DUPERRAY@ensimag.imag.fr>,
	Franck JONAS <Franck.JONAS@ensimag.imag.fr>,
	Thomas NGUY <Thomas.NGUY@ensimag.imag.fr>,
	Lucien KONG <Lucien.KONG@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 05 15:17:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbte1-0001gP-Ky
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 15:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933995Ab2FENRs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jun 2012 09:17:48 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:39865 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753564Ab2FENRq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jun 2012 09:17:46 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id BCF991A02E1;
	Tue,  5 Jun 2012 15:17:43 +0200 (CEST)
Received: from wifi-030246.grenet.fr (wifi-030246.grenet.fr
 [130.190.30.246]) by webmail.minatec.grenoble-inp.fr (Horde Framework) with
 HTTP; Tue, 05 Jun 2012 15:17:43 +0200
In-Reply-To: <vpqpq9fs3oi.fsf@bauges.imag.fr>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199237>


Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> a =C3=A9crit=C2=A0:

> Huynh Khoi Nguyen NGUYEN <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
> writes:
>
>> If core.excludesfile is not defined, its default value will be
>> $XDG_CONFIG_HOME/git/ignore in order to follow XDG specification. If
>> $XDG_CONFIG_HOME is either not set or emty, $HOME/.config will be
>> used.
>
> It's not clear whether $HOME/.config will be used to replace
> $XDG_CONFIG_HOME or $XDG_CONFIG_HOME/git/ignore. I'd say explicitely
> $HOME/.config/git/ignore to avoid this.
>
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>
> Likewise.
>
>> --- a/Documentation/gitignore.txt
>> +++ b/Documentation/gitignore.txt
>
> Likewise.
>
> Otherwise, sounds good.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/

We will also do the same changes with core.attributesfile, in our next =
=20
v6 version.
