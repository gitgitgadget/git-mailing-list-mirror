Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4071CC35273
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 13:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbiDENPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 09:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377276AbiDENMy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 09:12:54 -0400
X-Greylist: delayed 7800 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Apr 2022 05:13:06 PDT
Received: from 12.mo583.mail-out.ovh.net (12.mo583.mail-out.ovh.net [46.105.39.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D9C1210B0
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 05:13:05 -0700 (PDT)
Received: from player699.ha.ovh.net (unknown [10.110.208.202])
        by mo583.mail-out.ovh.net (Postfix) with ESMTP id 0405124B49
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 09:47:42 +0000 (UTC)
Received: from microej.com (lmontsouris-656-1-14-223.w92-154.abo.wanadoo.fr [92.154.86.223])
        (Authenticated sender: benjamin.alix@microej.com)
        by player699.ha.ovh.net (Postfix) with ESMTPSA id B3A40291ED822
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 09:47:42 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-107S0016f1192ce-b0bc-47d7-96b2-35b8f15b4bcc,
                    C0A3871EF66D4954F7837FBC32A57F26AC916614) smtp.auth=benjamin.alix@microej.com
X-OVh-ClientIp: 92.154.86.223
Message-ID: <b3193359-4625-820e-3968-bbdcc6a82ebf@microej.com>
Date:   Tue, 5 Apr 2022 11:47:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: fr
To:     git@vger.kernel.org
From:   Benjamin Alix <benjamin.alix@microej.com>
Subject: commit.gpgsign is overwritten
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 1170372953310830331
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejgedgudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefkffggfgfvhffutgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghnjhgrmhhinhcutehlihiguceosggvnhhjrghmihhnrdgrlhhigiesmhhitghrohgvjhdrtghomheqnecuggftrfgrthhtvghrnhepkeeigfffvedtjeehgffgffevkeduhfetgeeugfetleejffehjeefffeghfevteevnecuffhomhgrihhnpehmihgtrhhovghjrdgtohhmpdhtfihithhtvghrrdgtohhmpdhlihhnkhgvughinhdrtghomhdphihouhhtuhgsvgdrtghomhenucfkpheptddrtddrtddrtddpledvrdduheegrdekiedrvddvfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrieelledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegsvghnjhgrmhhinhdrrghlihigsehmihgtrhhovghjrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

My git global configuration is set to always sign commits 
(commit.gpgsign=true) but every once in a while it seems to be 
overwritten and this configuration is set to false.

I looked at other levels of configuration (system and local) to see if 
it was set to false elsewhere but it does not seem to be the case.

I don't understand why it would change and how, would there be any other 
configuration in git that would cause such a thing?

Please find below system informations about my git installation.

Regards,

Benjamin

[System Info]
git version:
git version 2.31.1.windows.1
cpu: x86_64
built from commit: c5f0be26a7e3846e3b6268d1c6c4800d838c6bbb
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 19043
compiler info: gnuc: 10.2
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]
commit-msg

-- 
MicroEJ <http://www.microej.com> 	

Benjamin ALIX
/Software Engineer/

11 rue du Chemin Rouge - Bat. D 44373 Nantes Cedex 3, France

Twitter <https://twitter.com/microej> LinkedIn 
<https://www.linkedin.com/company/microej> Youtube 
<https://www.youtube.com/user/IS2Tsa>

event <https://www.microej.com/event/>

This email (and all attachments) may contain information that is 
proprietary privileged, and/or confidential. If you received this e-mail 
in error or if it was improperly forwarded to you, the information 
contained in the e-mail should, at all times, remain confidential. 
Please notify the sender immediately by e-mail, and delete or destroy 
the original and any copies. Any unauthorized use, disclosure, 
reproduction, retention or distribution by any person other than the 
intended recipient is strictly prohibited.

