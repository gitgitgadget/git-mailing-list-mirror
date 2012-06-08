From: konglu@minatec.inpg.fr
Subject: Re: [PATCHv1] git-remote-mediawiki: import "File:" attachments
Date: Fri, 08 Jun 2012 19:03:05 +0200
Message-ID: <20120608190305.Horde.szbWGnwdC4BP0jBJMfN12lA@webmail.minatec.grenoble-inp.fr>
References: <1339165376-20267-1-git-send-email-Pavel.Volek@ensimag.imag.fr>
 <4FD2266B.3040706@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Volek Pavel <me@pavelvolek.cz>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: "Simon.Cathebras" <Simon.Cathebras@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 08 19:03:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd2ag-0001LS-UC
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 19:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761983Ab2FHRDK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jun 2012 13:03:10 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:33184 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761333Ab2FHRDJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2012 13:03:09 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id AAB201A030B;
	Fri,  8 Jun 2012 19:03:05 +0200 (CEST)
Received: from wifi-030033.grenet.fr (wifi-030033.grenet.fr [130.190.30.33])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Fri, 08 Jun
 2012 19:03:05 +0200
In-Reply-To: <4FD2266B.3040706@ensimag.imag.fr>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199513>


"Simon.Cathebras" <Simon.Cathebras@ensimag.imag.fr> a =E9crit=A0:

> On 08/06/2012 16:22, Pavel Volek wrote:
>> From: Volek Pavel<me@pavelvolek.cz>
>>
>> The current version of the git-remote-mediawiki supports only =20
>> import and export
>> of the pages, doesn't support import and export of file =20
>> attachements which are
>> also exposed by MediaWiki API. This patch adds the functionality to =
=20
>> import the
>> last versions of the files and all versions of description pages for=
 these
>> files.
>>
>> Signed-off-by: Pavel Volek<Pavel.Volek@ensimag.imag.fr>
>> Signed-off-by: NGUYEN Kim Thuat<Kim-Thuat.Nguyen@ensimag.imag.fr>
>> Signed-off-by: ROUCHER IGLESIAS Javier<roucherj@ensimag.imag.fr>
>> Signed-off-by: Matthieu Moy<Matthieu.Moy@imag.fr>
>> ---
>
>>  contrib/mw-to-git/git-remote-mediawiki | 290 =20
>> +++++++++++++++++++++++++++------
>>  1 file changed, 244 insertions(+), 46 deletions(-)
>
> I am wondering why are you showing the removal for a v1 patch ?

Why not ? The file already exists on branch master and they are
working on it. Anyway, the patch applies correctly on master.
BTW, are you implying that only v2+ patch could have deletions ?
(a patch is not meant to be applied on the previous version).

Lucien Kong
