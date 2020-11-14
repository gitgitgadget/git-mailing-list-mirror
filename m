Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FE0C5519F
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 13:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E55D22071E
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 13:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgKNNZW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Nov 2020 08:25:22 -0500
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:57993 "EHLO
        smtpout1.mo529.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726112AbgKNNZV (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 14 Nov 2020 08:25:21 -0500
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Nov 2020 08:25:20 EST
Received: from mxplan1.mail.ovh.net (unknown [10.109.138.121])
        by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 15F526C43E5D
        for <git@vger.kernel.org>; Sat, 14 Nov 2020 14:19:02 +0100 (CET)
Received: from greg0ire.fr (37.59.142.102) by DAG4EX2.mxp1.local (172.16.2.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Sat, 14 Nov
 2020 14:19:01 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-102R004a104fe4b-209d-463f-a84d-9acd85a5a572,
                    4C58B1D2F0141825396C827F322D1A475CF1342F) smtp.auth=postmaster@greg0ire.fr
To:     <git@vger.kernel.org>
From:   =?UTF-8?Q?Gr=c3=a9goire_PARIS?= <postmaster@greg0ire.fr>
Subject: phpdoc diff in git -L is not the correct one
Message-ID: <348a2a4a-dfdb-190b-edac-01e9ad4c2d4d@greg0ire.fr>
Date:   Sat, 14 Nov 2020 14:19:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="------------A2CE23C4FE87CA42AB892860"
Content-Language: en-US
X-Originating-IP: [37.59.142.102]
X-ClientProxiedBy: DAG7EX2.mxp1.local (172.16.2.14) To DAG4EX2.mxp1.local
 (172.16.2.8)
X-Ovh-Tracer-GUID: d3301e7d-be4e-4f51-b663-ff4b92829dd3
X-Ovh-Tracer-Id: 15655919681057688855
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedruddvjedgheduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefvhffukffffgggtghisehmtderredtfeejnecuhfhrohhmpefirhorghhoihhrvggprfettffkufcuoehpohhsthhmrghsthgvrhesghhrvghgtdhirhgvrdhfrheqnecuggftrfgrthhtvghrnheptdeiheelkeegudduuedvfeegveefudevheefhfejtdeilefgvedvteeuffevtdfhnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnuddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehpohhsthhmrghsthgvrhesghhrvghgtdhirhgvrdhfrhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--------------A2CE23C4FE87CA42AB892860
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I have recently found out about git -L , which is great! I think I have 
found a
bug in it though: the diff is correct on the method itself, but changes 
in the
phpdoc of the method do not seem to be taken into account, while changes 
in the
phpdoc of the method that follows the one I care about show up in the 
diff. I
have attached a bug report generated with git bugreport.

Regards,

-- 
greg0ire


--------------A2CE23C4FE87CA42AB892860
Content-Type: text/plain; charset="UTF-8";
	name="git-bugreport-2020-11-14-1402.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="git-bugreport-2020-11-14-1402.txt"

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5z
d2VyIHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3Vy
IGlzc3VlLgoKV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3Rl
cHMgdG8gcmVwcm9kdWNlIHlvdXIgaXNzdWUpCgplY2hvICcqLnBocCBkaWZmPXBocCcgPiB+
Ly5jb25maWcvZ2l0L2F0dHJpYnV0ZXMKZ2l0IGNsb25lIGdpdEBnaXRodWIuY29tOmRvY3Ry
aW5lL2luc3RhbnRpYXRvci5naXQKY2QgaW5zdGFudGlhdG9yCmdpdCBsb2cgLUwgOmluc3Rh
bnRpYXRlOnNyYy9Eb2N0cmluZS9JbnN0YW50aWF0b3IvSW5zdGFudGlhdG9yLnBocAoKV2hh
dCBkaWQgeW91IGV4cGVjdCB0byBoYXBwZW4/IChFeHBlY3RlZCBiZWhhdmlvcikKClNlZSBj
aGFuZ2VzIHRoYXQgaGFwcGVuZWQgaW4gdGhlIHBocGRvYyBvZiB0aGUgaW5zdGFudGlhdGUo
KSBtZXRob2QgYXBwZWFyIGluCnRoZSBsb2cuCgpXaGF0IGhhcHBlbmVkIGluc3RlYWQ/IChB
Y3R1YWwgYmVoYXZpb3IpCgpJIHNhdyBjaGFuZ2VzIHRoYXQgaGFwcGVuZWQgaW4gdGhlIHBo
cGRvYyBvZiB0aGUgYnVpbGRBbmRDYWNoZUZyb21GYWN0b3J5KCkKbWV0aG9kLCB3aGljaCBp
cyB0aGUgb25lIHJpZ2h0IGFmdGVyIHRoZSBpbnN0YW50aWF0ZSgpIG1ldGhvZAoKV2hhdCdz
IGRpZmZlcmVudCBiZXR3ZWVuIHdoYXQgeW91IGV4cGVjdGVkIGFuZCB3aGF0IGFjdHVhbGx5
IGhhcHBlbmVkPwoKVGhlIHBocGRvYyBiZWluZyBkaWZmZWQuCgpBbnl0aGluZyBlbHNlIHlv
dSB3YW50IHRvIGFkZDoKClNob3dpbmcgY2hhbmdlcyBvZiB0aGUgcGhwZG9jIG9mIHRoZSBt
ZXRob2QgbWlnaHQgbm90IGJlIGVhc3kgdG8gaW1wbGVtZW50LCBidXQKSSB0aGluayBub3Qg
c2hvd2luZyBjaGFuZ2VzIG9mIHRoZSBwaHBkb2Mgb2YgdGhlIG5leHQgbWV0aG9kIHNob3Vs
ZCBiZS4KClBsZWFzZSByZXZpZXcgdGhlIHJlc3Qgb2YgdGhlIGJ1ZyByZXBvcnQgYmVsb3cu
CllvdSBjYW4gZGVsZXRlIGFueSBsaW5lcyB5b3UgZG9uJ3Qgd2lzaCB0byBzaGFyZS4KCltT
eXN0ZW0gSW5mb10KZ2l0IHZlcnNpb246CmdpdCB2ZXJzaW9uIDIuMjguMApjcHU6IHg4Nl82
NApubyBjb21taXQgYXNzb2NpYXRlZCB3aXRoIHRoaXMgYnVpbGQKc2l6ZW9mLWxvbmc6IDgK
c2l6ZW9mLXNpemVfdDogOApzaGVsbC1wYXRoOiAvYmluL3NoCnVuYW1lOiBMaW51eCA1Ljgu
MTYtMzAwLmZjMzMueDg2XzY0ICMxIFNNUCBNb24gT2N0IDE5IDEzOjE4OjMzIFVUQyAyMDIw
IHg4Nl82NApjb21waWxlciBpbmZvOiBnbnVjOiAxMC4yCmxpYmMgaW5mbzogZ2xpYmM6IDIu
MzIKJFNIRUxMICh0eXBpY2FsbHksIGludGVyYWN0aXZlIHNoZWxsKTogL2Jpbi96c2gKCgpb
RW5hYmxlZCBIb29rc10KcHJlLWNvbW1pdApwb3N0LWNvbW1pdApwb3N0LWNoZWNrb3V0CnBv
c3QtbWVyZ2UKcHJlLXB1c2gKcG9zdC1yZXdyaXRlCg==
--------------A2CE23C4FE87CA42AB892860--
