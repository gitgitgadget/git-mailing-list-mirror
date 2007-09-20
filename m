From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: Re: [PATCH] Drop UTF-8 characters in manual pages
Date: Thu, 20 Sep 2007 11:08:29 +0200
Message-ID: <46F2388D.2000207@etek.chalmers.se>
References: <11901003792475-git-send-email-mh@glandium.org> <7vd4wgwczs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mh@glandium.org
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Sep 20 11:08:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYI1X-0005M4-8z
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 11:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbXITJIe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Sep 2007 05:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbXITJIe
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 05:08:34 -0400
Received: from anubis.medic.chalmers.se ([129.16.30.218]:58130 "EHLO
	anubis.medic.chalmers.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbXITJIc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 05:08:32 -0400
Received: from [192.168.0.82] (153.29.227.87.static.kba.siw.siwnet.net [87.227.29.153])
	(Authenticated sender: lukass)
	by anubis.medic.chalmers.se (Postfix) with ESMTP id 34120E2C1;
	Thu, 20 Sep 2007 11:08:30 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.6) Gecko/20070804 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <7vd4wgwczs.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58765>

Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
>> so
>> UTF-8 characters are just displayed as their sequence of bytes, whic=
h is
>> not very appealing.
>=20
> Perhaps not.  I cannot decide what to do with
> Documentation/git-pack-redundant.txt, though.
>=20

These days when we have delta reusing and repacking is quite cheap,
I'd say just drop pack-redundant and its man page completely.

Of course, some pople might still be using it, but I haven't
felt the need for it in over a year.

/Lukas Sandstr=F6m
