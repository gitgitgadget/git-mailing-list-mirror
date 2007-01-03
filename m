From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: confusion over the new branch and merge config
Date: Thu, 4 Jan 2007 00:02:20 +0100
Message-ID: <200701040002.20773.jnareb@gmail.com>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home> <enef73$467$1@sea.gmane.org> <8aa486160701021624v69015fbibb81a99177dd7dfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 03 23:59:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2F4m-00063W-9s
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 23:59:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbXACW7N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 3 Jan 2007 17:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbXACW7N
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 17:59:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:48583 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932066AbXACW7L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 17:59:11 -0500
Received: by ug-out-1314.google.com with SMTP id 44so5301862uga
        for <git@vger.kernel.org>; Wed, 03 Jan 2007 14:59:10 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RNWllFL0vLmRM0OaYjYya25EDrKB5P85lmpARadVs2ox+8wzx10WZKL4cGl97rIRp4nUXJH6VMVdn/BLwX92LNfhgSSOajWZXpeuBmv/GaqA+Qmv87HgExbYGRT+8oVRfUjatDqqlkT1GpAs3Yd8yri57/5kUGPZKhcNvFUDlWM=
Received: by 10.67.89.5 with SMTP id r5mr27597361ugl.1167865150049;
        Wed, 03 Jan 2007 14:59:10 -0800 (PST)
Received: from host-81-190-20-195.torun.mm.pl ( [81.190.20.195])
        by mx.google.com with ESMTP id y7sm32957339ugc.2007.01.03.14.59.09;
        Wed, 03 Jan 2007 14:59:09 -0800 (PST)
To: "Santi =?iso-8859-1?q?B=E9jar?=" <sbejar@gmail.com>
User-Agent: KMail/1.9.3
In-Reply-To: <8aa486160701021624v69015fbibb81a99177dd7dfc@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35896>

Santi B=E9jar wrote:
> On 1/2/07, Jakub Narebski <jnareb@gmail.com> wrote:
>> Junio C Hamano wrote:
>>
>>> Obviously, the local names should matter more when you are doing
>>> local operations. So if you are using mergeLocal to give a
>>> shorthand to "git merge" that does not explicitly say what to
>>> merge, the above discussion does not apply. But if that is the
>>> case, mergeLocal should also not affect the selection of
>>> branches to be merged when "git pull" happens from a remote
>>> either.
>>
>> You can always use remote =3D ".", and then remote and local branche=
s
>> are the same...
>=20
> Currently it does not work.

=46act.

I remember that there was proposal of having branch.<name>.remote=3D.
and branch.<name>.merge=3D<ref> to make "git pull" on branch <name>
do "git pull . <ref>". There was some discussion about this; perhaps
it was not accepted (or forgotten to be accepted after resolving
discussion).

--=20
Jakub Narebski
Poland
