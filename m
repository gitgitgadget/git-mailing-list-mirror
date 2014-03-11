From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH/RFC] git-gui: Add a 'recursive' checkbox in the clone
 menu.
Date: Tue, 11 Mar 2014 18:34:43 +0100
Message-ID: <531F4933.7080701@web.de>
References: <1393974076.7891.27.camel@Naugrim> <5317662C.6010404@web.de> <1394536038.7891.59.camel@Naugrim>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Henri GEIST <geist.henri@laposte.net>
X-From: git-owner@vger.kernel.org Tue Mar 11 18:35:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNQa2-0008Ga-Dl
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 18:35:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754355AbaCKRfA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Mar 2014 13:35:00 -0400
Received: from mout.web.de ([212.227.15.3]:59760 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753466AbaCKRe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 13:34:59 -0400
Received: from [192.168.178.41] ([84.132.149.241]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LeLSr-1WxdOH07Ar-00qAus; Tue, 11 Mar 2014 18:34:48
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <1394536038.7891.59.camel@Naugrim>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:15MWbWSF7TvwubRCc0TLlOxU0w7HrTflmFdiG4/B3JlBDoDwNiS
 F4t4elA3DJiDkmrajla1+9ZI24AO8y0FsiMJz81X8GIZRN7j7jw5yqtmEPlf5kXTH/O0jxH
 d9bdZebVJLmFFb+AG25ItHnjTaoYADRZD0cSPcsdMWcS4HoqDxnp8MVq2uhDXEBJpmM140Q
 +/iDstm3ZItJUw6aPKovw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243871>

Am 11.03.2014 12:07, schrieb Henri GEIST:
> Le mercredi 05 mars 2014 =C3=A0 19:00 +0100, Jens Lehmann a =C3=A9cri=
t :
>> Am 05.03.2014 00:01, schrieb Henri GEIST:
>>> Permit to do a 'git clone --recursive' through git-gui.
>>
>> I really like where this is heading!
>>
>> Some minor issues:
>>
>> - I think we should be more verbose in the commit message,
>>   including that and why the default should be "on". Maybe
>>   like this?
>>
>>   "Permit to do a 'git clone --recursive' through git-gui.
>>   Add a 'recursive' checkbox in the clone menu which allows
>>   users to clone a repository and all its submodules in one
>>   go (unless the 'update' flag is set to "none" in the
>>   .gitmodules file for a submodule, in that case that
>>   specific submodule is not cloned automatically).
>>
>>   Enable this new option per default, as most users want to
>>   clone all submodules too when cloning the superproject
>>   (This is currently not possible without leaving git gui
>>   or adding a custom tool entry for that)."
>>
>>
>> - I'd rather change the button text from "Recursive (For
>>   submodules)" to something like "Recursively clone
>>   submodules too" or such.
>>
>>
>=20
> Perfect.
> Would you like me to send the new version of the patch in this thread
> Or to make a new thread [patch v2] ?

It doesn't matter that much as long as you start the subject with
"[PATCH v2]". But I believe you should send it to Pat and create
the diff from inside the git-gui directory so he can simply apply
it to his repository.
