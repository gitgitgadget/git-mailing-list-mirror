From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH] t0005: work around strange $? in ksh when program 	terminated
 by a signal
Date: Fri, 09 Jul 2010 11:07:53 -0500
Message-ID: <lMI9JytvbBVTwy1p_jSAWzeLQeaQ07mdHqcWXaY2o1DXhPqFjYDE2g@cipher.nrlssc.navy.mil>
References: <20100709030812.GA16877@dert.cs.uchicago.edu> <4C36CA2C.5050305@viscovery.net> <iOZX7rvipLDwT5DTYGPE0q9TlJfav09nJWqaRsyiefjNds9DpaDw1A@cipher.nrlssc.navy.mil> <AANLkTilrFPb4JLagQdK4QAIwE7zL7KptuY_VhxhKPZBe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 18:08:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXG7Y-0001dk-V8
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 18:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757445Ab0GIQIH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Jul 2010 12:08:07 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:59661 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757328Ab0GIQIG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 12:08:06 -0400
Received: by mail.nrlssc.navy.mil id o69G7s5D027205; Fri, 9 Jul 2010 11:07:54 -0500
In-Reply-To: <AANLkTilrFPb4JLagQdK4QAIwE7zL7KptuY_VhxhKPZBe@mail.gmail.com>
X-OriginalArrivalTime: 09 Jul 2010 16:07:54.0089 (UTC) FILETIME=[E35B7D90:01CB1F80]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150677>

On 07/09/2010 11:03 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Fri, Jul 9, 2010 at 15:45, Brandon Casey
> <brandon.casey.ctr@nrlssc.navy.mil> wrote:
>> the exit status is 128+signum.  The Public domain Korn shell, and
>> ksh on IRIX 6.5, Solaris 7, 9, and 10 all exit with the standard
>> behavior of 128+signum.  So, it may be appropriate to change the
>> commit message and comment in t0005 to reflect this fact.
>=20
> s/standard/conventional/, no?

sure.
