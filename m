From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Silence cpio's "N blocks" output when cloning locally
Date: Fri, 28 Mar 2008 17:12:27 +0100
Message-ID: <2145F4A8-7C6E-4AE9-A531-026DC65417BE@wincent.com>
References: <> <1206685186-10352-1-git-send-email-bdonlan@fushizen.net> <alpine.LSU.1.00.0803281400330.18259@racer.site>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bryan Donlan <bdonlan@fushizen.net>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 28 17:21:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfHK8-0000SD-6X
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 17:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754223AbYC1QUN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Mar 2008 12:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754196AbYC1QUN
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 12:20:13 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:35948 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754223AbYC1QUM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Mar 2008 12:20:12 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Mar 2008 12:20:11 EDT
Received: from cuzco.lan (99.pool85-53-31.dynamic.orange.es [85.53.31.99])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m2SGCSqP016183;
	Fri, 28 Mar 2008 12:12:28 -0400
In-Reply-To: <alpine.LSU.1.00.0803281400330.18259@racer.site>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78425>

El 28/3/2008, a las 14:01, Johannes Schindelin escribi=F3:

> On Fri, 28 Mar 2008, Bryan Donlan wrote:
>
>> Pass --quiet to cpio in git-clone to hide the (confusing) "0 blocks"
>> message. For compatibility with operating systems which might not
>> support GNUisms, the presence of --quiet is probed for by grepping
>> cpio's --help output.
>
> We have a builtin clone which is almost ready for 'next', and I =20
> think that
> this issue would be resolved there anyway.

In any case, I'd rather see the cpio check at configure-time rather =20
than run-time.

Cheers,
Wincent
