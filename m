From: "Simon.Cathebras" <Simon.Cathebras@ensimag.imag.fr>
Subject: Re: [PATCHv1] git-remote-mediawiki: import "File:" attachments
Date: Sat, 09 Jun 2012 01:24:13 +0200
Message-ID: <4FD2899D.4080407@ensimag.imag.fr>
References: <1339165376-20267-1-git-send-email-Pavel.Volek@ensimag.imag.fr> <4FD2266B.3040706@ensimag.imag.fr> <20120608190305.Horde.szbWGnwdC4BP0jBJMfN12lA@webmail.minatec.grenoble-inp.fr>
Reply-To: Simon.Cathebras@ensimag.imag.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Volek Pavel <me@pavelvolek.cz>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Sat Jun 09 01:24:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd8Y3-0001DS-04
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jun 2012 01:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757147Ab2FHXYU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jun 2012 19:24:20 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48719 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755824Ab2FHXYT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 19:24:19 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q58NFT9o016863
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 9 Jun 2012 01:15:29 +0200
Received: from [IPv6:::1] (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q58NOEca020336;
	Sat, 9 Jun 2012 01:24:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <20120608190305.Horde.szbWGnwdC4BP0jBJMfN12lA@webmail.minatec.grenoble-inp.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 09 Jun 2012 01:15:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q58NFT9o016863
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: simon.cathebras@ensimag.imag.fr
MailScanner-NULL-Check: 1339802130.60702@nHCPwXFHgYvuvAb5zuULuA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199542>



On 08/06/2012 19:03, konglu@minatec.inpg.fr wrote:
>
> "Simon.Cathebras" <Simon.Cathebras@ensimag.imag.fr> a =E9crit :
>
>> On 08/06/2012 16:22, Pavel Volek wrote:
>>> From: Volek Pavel<me@pavelvolek.cz>
>>>
>>> The current version of the git-remote-mediawiki supports only impor=
t=20
>>> and export
>>> of the pages, doesn't support import and export of file attachement=
s=20
>>> which are
>>> also exposed by MediaWiki API. This patch adds the functionality to=
=20
>>> import the
>>> last versions of the files and all versions of description pages fo=
r=20
>>> these
>>> files.
>>>
>>> Signed-off-by: Pavel Volek<Pavel.Volek@ensimag.imag.fr>
>>> Signed-off-by: NGUYEN Kim Thuat<Kim-Thuat.Nguyen@ensimag.imag.fr>
>>> Signed-off-by: ROUCHER IGLESIAS Javier<roucherj@ensimag.imag.fr>
>>> Signed-off-by: Matthieu Moy<Matthieu.Moy@imag.fr>
>>> ---
>>
>>>  contrib/mw-to-git/git-remote-mediawiki | 290=20
>>> +++++++++++++++++++++++++++------
>>>  1 file changed, 244 insertions(+), 46 deletions(-)
>>
>> I am wondering why are you showing the removal for a v1 patch ?
>
> Why not ? The file already exists on branch master and they are
> working on it.


Makes sense... I didn't notice the deletions were on master, my bad.


> Anyway, the patch applies correctly on master.
> BTW, are you implying that only v2+ patch could have deletions ?
> (a patch is not meant to be applied on the previous version).


Actually, I was just saying that showing corrections on a patche's code=
=20
during the development of this one, isn't really necessary.
But if it is concerning a modification of a code in a previous version,=
=20
I agree, it is absolutly useful ;).

Simon

--=20
CATHEBRAS Simon

2A-ENSIMAG

=46ili=E8re Ing=E9ni=E9rie des Syst=E8mes d'Information
Membre Bug-Buster
