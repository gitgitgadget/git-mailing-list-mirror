From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 3/3] cache-tree: Write index with updated cache-tree after
 commit
Date: Tue, 01 Jul 2014 07:49:41 +0200
Message-ID: <53B24BF5.3020007@viscovery.net>
References: <1404173597-24713-1-git-send-email-dturner@twitter.com> <1404173597-24713-3-git-send-email-dturner@twitter.com> <53B2386B.4060802@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	David Turner <dturner@twitter.com>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jul 01 07:49:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1qwx-0006uD-Hh
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 07:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbaGAFtr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jul 2014 01:49:47 -0400
Received: from so.liwest.at ([212.33.55.18]:33320 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751535AbaGAFtr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 01:49:47 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1X1qwn-0000J7-Ud; Tue, 01 Jul 2014 07:49:42 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 83C0416613;
	Tue,  1 Jul 2014 07:49:41 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <53B2386B.4060802@web.de>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252711>

Am 7/1/2014 6:26, schrieb Torsten B=F6gershausen:
> And as test -n tests for a non-zero string,
> could we write like this (and drop the local ?)?
>=20
>     if test -n "$1"
>     then
>         dir=3D"$1/"
>     else
>         dir=3D""
>     fi

These six lines can be written as

	dir=3D"$1${1:+/}" &&

and 'local' must be dropped because is not universally supported, yet.

-- Hannes
