From: konglu@minatec.inpg.fr
Subject: Re: [PATCH] Warnings before rebasing -i published history
Date: Fri, 08 Jun 2012 16:03:41 +0200
Message-ID: <20120608160341.Horde.IGByfXwdC4BP0gY9a0fV0PA@webmail.minatec.grenoble-inp.fr>
References: <1339104053-7782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <vpqy5ny22z5.fsf@bauges.imag.fr>
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
X-From: git-owner@vger.kernel.org Fri Jun 08 16:04:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScznL-00020h-TY
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 16:04:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933629Ab2FHOEA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jun 2012 10:04:00 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:56183 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933692Ab2FHODo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2012 10:03:44 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id D3F6E1A030E;
	Fri,  8 Jun 2012 16:03:41 +0200 (CEST)
Received: from wifi-030033.grenet.fr (wifi-030033.grenet.fr [130.190.30.33])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Fri, 08 Jun
 2012 16:03:41 +0200
In-Reply-To: <vpqy5ny22z5.fsf@bauges.imag.fr>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199489>


Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> a =C3=A9crit=C2=A0:

>>  test -s "$todo" || echo noop >> "$todo"
>>  test -n "$autosquash" && rearrange_squash "$todo"
>> +warn_published "$todo"
>
> That should be configurable.

Do you mean that it should be controlled by a key config (maybe a new
advice.*) in the config file ? Or through an option ?
