From: konglu@minatec.inpg.fr
Subject: Re: [PATCHv2 2/2] git-remote-mediawiki: refactoring get_mw_pages
 function
Date: Tue, 12 Jun 2012 11:24:32 +0200
Message-ID: <20120612112432.Horde.uOUWUHwdC4BP1wrQWv4jzXA@webmail.minatec.grenoble-inp.fr>
References: <1339442945-8561-1-git-send-email-Pavel.Volek@ensimag.imag.fr>
 <1339442945-8561-2-git-send-email-Pavel.Volek@ensimag.imag.fr>
 <CA+hdvHhn1G=T=KjNvgXa-2M6oh2znbHmfZFZYPdqKhtybh_MoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pavel Volek <Pavel.Volek@ensimag.imag.fr>, git@vger.kernel.org,
	Volek Pavel <me@pavelvolek.cz>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Simon Perrat <simon.perrat@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 11:24:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeNL4-0003YP-VU
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 11:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085Ab2FLJYf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jun 2012 05:24:35 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:46570 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751962Ab2FLJYf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2012 05:24:35 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id A5ADA1A02DF;
	Tue, 12 Jun 2012 11:24:32 +0200 (CEST)
Received: from wifi-028181.grenet.fr (wifi-028181.grenet.fr
 [130.190.28.181]) by webmail.minatec.grenoble-inp.fr (Horde Framework) with
 HTTP; Tue, 12 Jun 2012 11:24:32 +0200
In-Reply-To: <CA+hdvHhn1G=T=KjNvgXa-2M6oh2znbHmfZFZYPdqKhtybh_MoQ@mail.gmail.com>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199774>


Simon Perrat <simon.perrat@gmail.com> a =E9crit=A0:

> 2012/6/11 Pavel Volek <Pavel.Volek@ensimag.imag.fr>:
>
>> +sub get_mw_all_pages {
>> + =A0 =A0 =A0 my $pages =3D shift;
>> + =A0 =A0 =A0 # No user-provided list, get the list of pages from th=
e API.
>> + =A0 =A0 =A0 my $mw_pages =3D $mediawiki->list({
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 action =3D> 'query',
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list =3D> 'allpages',
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 aplimit =3D> 500
>> + =A0 =A0 =A0 });
>
> Indentation should be 8 columns wide.

Indentation is correct here.
