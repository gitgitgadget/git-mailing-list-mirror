From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH/RFC] Change t0204-gettext-reencode-sanity.sh to pass under
 Mac OSX
Date: Thu, 08 Mar 2012 08:23:28 +0100
Message-ID: <4F585E70.90302@viscovery.net>
References: <201203052039.16893.tboegi@web.de> <7vzkbuzss7.fsf@alter.siamese.dyndns.org> <CACBZZX4P=JSdP_vLOMx5r3R+YO8SMSs5W8+vf2DMibKMwBx_Vg@mail.gmail.com> <7vfwdkm6xs.fsf@alter.siamese.dyndns.org> <CACBZZX4q0Da=H=-fO86f2YN+CmE25QfEgAp8Efmdyf65CGckiQ@mail.gmail.com> <7v4nu0m5tb.fsf@alter.siamese.dyndns.org> <CACBZZX6W=-ZchaCsLGdpZ420L_9=w8AHD8BNVb7XV5M-hc0Qhg@mail.gmail.com> <7vd38okmp0.fsf@alter.siamese.dyndns.org> <4F5849AE.1070807@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBC?= =?UTF-8?B?amFybWFzb24=?= 
	<avarab@gmail.com>, git@vger.kernel.org
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Mar 08 08:23:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5XhP-0000PB-71
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 08:23:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574Ab2CHHXh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 02:23:37 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:30999 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752489Ab2CHHXg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 02:23:36 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1S5XhB-0005oQ-56; Thu, 08 Mar 2012 08:23:29 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id B2F731660F;
	Thu,  8 Mar 2012 08:23:28 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <4F5849AE.1070807@web.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192532>

Am 3/8/2012 6:54, schrieb Torsten B=C3=B6gershausen:
> On 08.03.12 00:36, Junio C Hamano wrote:
>>  test_expect_success GETTEXT_ISO_LOCALE 'gettext: Emitting ISO-8859-=
1 from our UTF-8 *.mo files / Runes' '

> ok 4 # skip gettext: Emitting ISO-8859-1 from our UTF-8 *.mo files / =
Runes (missing GETTEXT_ISO_LOCALE)
         ^^^^
Huh? How can you have tripped over this test in the first place? The
prerequisite did not change in Junio's patch. Why was the test not skip=
ped
before you started this thread with your own patch?

-- Hannes
