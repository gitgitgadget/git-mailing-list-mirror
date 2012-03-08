From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: Replacing large blobs in git history
Date: Thu, 08 Mar 2012 16:39:57 +0100
Message-ID: <4F58D2CD.2050502@ira.uka.de>
References: <CAD-6W7byTiuE9MFZY1yG_ann-Ox7+wGjYduZ=Wwmw0ToF5Pynw@mail.gmail.com> <4F56786D.60801@gmail.com> <CACBZZX4hinV8vkebyNCLp_Ac6L80aNbdGOFqg1nSsCuRktFFrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>,
	Barry Roberts <blr@robertsr.us>, git <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 16:39:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5fRE-0003zH-7f
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 16:39:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757479Ab2CHPj0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 10:39:26 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:49254 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756597Ab2CHPj0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 10:39:26 -0500
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1S5fQj-0006Gs-EJ; Thu, 08 Mar 2012 16:39:18 +0100
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1S5fQj-0002jo-7k; Thu, 08 Mar 2012 16:39:01 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <CACBZZX4hinV8vkebyNCLp_Ac6L80aNbdGOFqg1nSsCuRktFFrg@mail.gmail.com>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1331221158.614726000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192611>

On 07.03.2012 22:27, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> Does something other than git-fsck actually check whether the
> collection of blobs you're getting from the remote when you clone hav=
e
> sensible sha1's?
>
> What'll happen if he replaces that 550MB blob with a 0 byte blob but
> hacks the object store so that it pretends to have the same sha1?

This is something I tested once because of security concerns (i.e. what=
=20
happens if a malicious intruder just drops something else into the=20
object store) and if I remember correctly only git-fsck was able to spo=
t=20
the switch. But I didn't test cloning, only a few local operations.
