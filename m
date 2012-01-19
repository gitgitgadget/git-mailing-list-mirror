From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Rebase and incrementing version numbers
Date: Fri, 20 Jan 2012 00:31:19 +0100
Message-ID: <CA+gHt1CPBYTLLwSSLdu-BmDfuGDzPwi9RnXAku7KZjHLYhUtjQ@mail.gmail.com>
References: <CADo4Y9jGYJasDL9m7_50aOTrOyoezdyg=vcsZhQ87Qk-1XfTUQ@mail.gmail.com>
 <CADo4Y9iKvoXhKg5pEAB+cbA7Rkfa=nF4TLu0xgcS3dnkNi_n4g@mail.gmail.com>
 <CANgJU+WWq=+BP1ZDbGY3weB5Xey2TtbryDJvz5=eMLFzNet3xQ@mail.gmail.com> <CADo4Y9is9mBOJaU+YRTMedTz7FfDrMFoDiqiUvQpVxQpyariPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: demerphq <demerphq@gmail.com>, git@vger.kernel.org
To: mike@nahas.com
X-From: git-owner@vger.kernel.org Fri Jan 20 00:31:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ro1SX-0006uV-HY
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 00:31:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157Ab2ASXbm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jan 2012 18:31:42 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35107 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057Ab2ASXbl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2012 18:31:41 -0500
Received: by pbaa10 with SMTP id a10so6111pba.19
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 15:31:41 -0800 (PST)
Received: by 10.68.73.70 with SMTP id j6mr56593966pbv.20.1327015901238; Thu,
 19 Jan 2012 15:31:41 -0800 (PST)
Received: by 10.68.62.130 with HTTP; Thu, 19 Jan 2012 15:31:19 -0800 (PST)
In-Reply-To: <CADo4Y9is9mBOJaU+YRTMedTz7FfDrMFoDiqiUvQpVxQpyariPQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188846>

On Thu, Jan 19, 2012 at 7:48 PM, Michael Nahas <mike.nahas@gmail.com> w=
rote:
> On Thu, Jan 19, 2012 at 1:12 PM, demerphq <demerphq@gmail.com> wrote:
>> Stop using version numbers and start using the git sha1 of the code
>> you are using.
>>
>> Yves
>
[...]
> 2. The version number needs to be increasing, to work with the curren=
t
> process. =A0SHA1's are random.

Yes, but you can use "git describe" output:

$ git describe
v1.7.6-180-gdf3f3d8

HTH,
Santi
