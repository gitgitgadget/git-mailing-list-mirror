Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5E9A1F424
	for <e@80x24.org>; Tue,  3 Apr 2018 08:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755149AbeDCIC5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 04:02:57 -0400
Received: from mailhost.frm2.tum.de ([129.187.179.12]:52854 "EHLO
        mailhost.frm2.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754736AbeDCICe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 04:02:34 -0400
Received: from mailhost.frm2.tum.de (localhost [127.0.0.1])
        by mailhost.frm2.tum.de (8.15.2/8.15.2) with ESMTP id w3381oWl051428;
        Tue, 3 Apr 2018 10:02:29 +0200 (CEST)
        (envelope-from jens.krueger@frm2.tum.de)
X-Virus-Scanned: at mailhost.frm2.tum.de
Received: from taco61.taco.frm2 (taco61.ictrl.frm2 [172.25.2.61])
        (authenticated bits=0)
        by mailhost.frm2.tum.de (8.15.2/8.15.2) with ESMTPSA id w3381xTv051453
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 3 Apr 2018 10:02:00 +0200 (CEST)
        (envelope-from jens.krueger@frm2.tum.de)
X-Authentication-Warning: mailhost.frm2.tum.de: Host taco61.ictrl.frm2 [172.25.2.61] claimed to be taco61.taco.frm2
Subject: Re: Test t2028 failes
To:     Eric Sunshine <sunshine@sunshineco.us>
Cc:     Git List <git@vger.kernel.org>
References: <dfb01281-2ffb-a0ac-a44d-74ccd304a7ea@frm2.tum.de>
 <CAPig+cRTf+WHaSJsLhbPuG0fwd6zkTP_zhwLhB14GdC81xiHRQ@mail.gmail.com>
From:   =?UTF-8?Q?Jens_Kr=c3=bcger?= <Jens.Krueger@frm2.tum.de>
Message-ID: <cdec466c-ecc9-b1d7-c637-04e63552c759@frm2.tum.de>
Date:   Tue, 3 Apr 2018 10:01:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cRTf+WHaSJsLhbPuG0fwd6zkTP_zhwLhB14GdC81xiHRQ@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------F25CF29A4BA23AD8F8F33E62"
Content-Language: de-DE-1901
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mailhost.frm2.tum.de [129.187.179.12]); Tue, 03 Apr 2018 10:02:00 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------F25CF29A4BA23AD8F8F33E62
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

The actual2 file does not exists, if I call the ./t2028-worktree-move.sh
with the '-v -i' options, only without any option or with '-v' option.

Am 03.04.2018 um 08:58 schrieb Eric Sunshine:
> On Tue, Apr 3, 2018 at 2:33 AM, Jens Krüger <Jens.Krueger@frm2.tum.de> wrote:
>> *** t2028-worktree-move.sh ***
>> not ok 12 - move worktree
>> #
>> #               toplevel="$(pwd)" &&
>> #               git worktree move source destination &&
>> #               test_path_is_missing source &&
>> #               git worktree list --porcelain >out &&
>> #               grep "^worktree.*/destination" out &&
>> #               ! grep "^worktree.*/source" out &&
>> #               git -C destination log --format=%s >actual2 &&
>> #               echo init >expected2 &&
>> #               test_cmp expected2 actual2
>> #
> 
> Thanks for the report. Can you paste the relevant output (which
> should/might include an error message) from running the test with:
> 
>     ./t2028-worktree-move.sh -v -i
> 
> and show an "ls -l" of t/trash directory.t2028-worktree-move
> directory, as well as paste the content of files "out" and "actual2"
> in that directory?
> 

--------------F25CF29A4BA23AD8F8F33E62
Content-Type: text/plain; charset=UTF-8;
 name="ls.output"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="ls.output"

aW5zZ2VzYW10IDI4CmRyd3hyLXhyLXggMiBqa3J1ZWdlciBqa3J1ZWdlciA0MDk2IEFwciAg
MyAwOToyNSBhYmMKLXJ3LXItLXItLSAxIGprcnVlZ2VyIGprcnVlZ2VyICAxNTUgQXByICAz
IDA5OjI1IGFjdHVhbApkcnd4ci14ci14IDIgamtydWVnZXIgamtydWVnZXIgNDA5NiBBcHIg
IDMgMDk6MjUgZGVzdGluYXRpb24KZHJ3eHIteHIteCAyIGprcnVlZ2VyIGprcnVlZ2VyIDQw
OTYgQXByICAzIDA5OjI1IGVsc2V3aGVyZQotcnctci0tci0tIDEgamtydWVnZXIgamtydWVn
ZXIgICAgNyBBcHIgIDMgMDk6MjUgZXhwZWN0ZWQKLXJ3LXItLXItLSAxIGprcnVlZ2VyIGpr
cnVlZ2VyICAgIDUgQXByICAzIDA5OjI1IGluaXQudAotcnctci0tci0tIDEgamtydWVnZXIg
amtydWVnZXIgIDQ2MyBBcHIgIDMgMDk6MjUgb3V0Cg==
--------------F25CF29A4BA23AD8F8F33E62
Content-Type: text/plain; charset=UTF-8;
 name="t2028.output"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="t2028.output"

SW5pdGlhbGl6ZWQgZW1wdHkgR2l0IHJlcG9zaXRvcnkgaW4gL2hvbWUvamtydWVnZXIvc291
cmNlcy9naXQvdC90cmFzaCBkaXJlY3RvcnkudDIwMjgtd29ya3RyZWUtbW92ZS8uZ2l0Lwpl
eHBlY3Rpbmcgc3VjY2VzczogCgl0ZXN0X2NvbW1pdCBpbml0ICYmCglnaXQgd29ya3RyZWUg
YWRkIHNvdXJjZSAmJgoJZ2l0IHdvcmt0cmVlIGxpc3QgLS1wb3JjZWxhaW4gPm91dCAmJgoJ
Z3JlcCAiXndvcmt0cmVlIiBvdXQgPmFjdHVhbCAmJgoJY2F0IDw8LUVPRiA+ZXhwZWN0ZWQg
JiYKCXdvcmt0cmVlICQocHdkKQoJd29ya3RyZWUgJChwd2QpL3NvdXJjZQoJRU9GCgl0ZXN0
X2NtcCBleHBlY3RlZCBhY3R1YWwKClttYXN0ZXIgKHJvb3QtY29tbWl0KSAyNTE5MjEyXSBp
bml0CiBBdXRob3I6IEEgVSBUaG9yIDxhdXRob3JAZXhhbXBsZS5jb20+CiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKykKIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbml0LnQKUHJlcGFy
aW5nIHNvdXJjZSAoaWRlbnRpZmllciBzb3VyY2UpCkhFQUQgaXMgbm93IGF0IDI1MTkyMTIg
aW5pdApvayAxIC0gc2V0dXAKCmV4cGVjdGluZyBzdWNjZXNzOiAKCXRlc3RfbXVzdF9mYWls
IGdpdCB3b3JrdHJlZSBsb2NrIC4KCmZhdGFsOiBUaGUgbWFpbiB3b3JraW5nIHRyZWUgY2Fu
bm90IGJlIGxvY2tlZCBvciB1bmxvY2tlZApvayAyIC0gbG9jayBtYWluIHdvcmt0cmVlCgpl
eHBlY3Rpbmcgc3VjY2VzczogCglnaXQgd29ya3RyZWUgbG9jayAtLXJlYXNvbiBoYWhhaGEg
c291cmNlICYmCgllY2hvIGhhaGFoYSA+ZXhwZWN0ZWQgJiYKCXRlc3RfY21wIGV4cGVjdGVk
IC5naXQvd29ya3RyZWVzL3NvdXJjZS9sb2NrZWQKCm9rIDMgLSBsb2NrIGxpbmtlZCB3b3Jr
dHJlZQoKZXhwZWN0aW5nIHN1Y2Nlc3M6IAoJcm0gLmdpdC93b3JrdHJlZXMvc291cmNlL2xv
Y2tlZCAmJgoJZ2l0IHdvcmt0cmVlIGFkZCBlbHNld2hlcmUgJiYKCWdpdCAtQyBlbHNld2hl
cmUgd29ya3RyZWUgbG9jayAtLXJlYXNvbiBoYWhhaGEgLi4vc291cmNlICYmCgllY2hvIGhh
aGFoYSA+ZXhwZWN0ZWQgJiYKCXRlc3RfY21wIGV4cGVjdGVkIC5naXQvd29ya3RyZWVzL3Nv
dXJjZS9sb2NrZWQKClByZXBhcmluZyBlbHNld2hlcmUgKGlkZW50aWZpZXIgZWxzZXdoZXJl
KQpIRUFEIGlzIG5vdyBhdCAyNTE5MjEyIGluaXQKb2sgNCAtIGxvY2sgbGlua2VkIHdvcmt0
cmVlIGZyb20gYW5vdGhlciB3b3JrdHJlZQoKZXhwZWN0aW5nIHN1Y2Nlc3M6IAoJdGVzdF9t
dXN0X2ZhaWwgZ2l0IHdvcmt0cmVlIGxvY2sgc291cmNlICYmCgllY2hvIGhhaGFoYSA+ZXhw
ZWN0ZWQgJiYKCXRlc3RfY21wIGV4cGVjdGVkIC5naXQvd29ya3RyZWVzL3NvdXJjZS9sb2Nr
ZWQKCmZhdGFsOiAnc291cmNlJyBpcyBhbHJlYWR5IGxvY2tlZCwgcmVhc29uOiBoYWhhaGEK
b2sgNSAtIGxvY2sgd29ya3RyZWUgdHdpY2UKCmV4cGVjdGluZyBzdWNjZXNzOiAKCXRlc3Rf
bXVzdF9mYWlsIGdpdCAtQyBzb3VyY2Ugd29ya3RyZWUgbG9jayAuICYmCgllY2hvIGhhaGFo
YSA+ZXhwZWN0ZWQgJiYKCXRlc3RfY21wIGV4cGVjdGVkIC5naXQvd29ya3RyZWVzL3NvdXJj
ZS9sb2NrZWQKCmZhdGFsOiAnLicgaXMgYWxyZWFkeSBsb2NrZWQsIHJlYXNvbjogaGFoYWhh
Cm9rIDYgLSBsb2NrIHdvcmt0cmVlIHR3aWNlIChmcm9tIHRoZSBsb2NrZWQgd29ya3RyZWUp
CgpleHBlY3Rpbmcgc3VjY2VzczogCgl0ZXN0X211c3RfZmFpbCBnaXQgd29ya3RyZWUgdW5s
b2NrIC4KCmZhdGFsOiBUaGUgbWFpbiB3b3JraW5nIHRyZWUgY2Fubm90IGJlIGxvY2tlZCBv
ciB1bmxvY2tlZApvayA3IC0gdW5sb2NrIG1haW4gd29ya3RyZWUKCmV4cGVjdGluZyBzdWNj
ZXNzOiAKCWdpdCB3b3JrdHJlZSB1bmxvY2sgc291cmNlICYmCgl0ZXN0X3BhdGhfaXNfbWlz
c2luZyAuZ2l0L3dvcmt0cmVlcy9zb3VyY2UvbG9ja2VkCgpvayA4IC0gdW5sb2NrIGxpbmtl
ZCB3b3JrdHJlZQoKZXhwZWN0aW5nIHN1Y2Nlc3M6IAoJdGVzdF9tdXN0X2ZhaWwgZ2l0IHdv
cmt0cmVlIHVubG9jayBzb3VyY2UgJiYKCXRlc3RfcGF0aF9pc19taXNzaW5nIC5naXQvd29y
a3RyZWVzL3NvdXJjZS9sb2NrZWQKCmZhdGFsOiAnc291cmNlJyBpcyBub3QgbG9ja2VkCm9r
IDkgLSB1bmxvY2sgd29ya3RyZWUgdHdpY2UKCmV4cGVjdGluZyBzdWNjZXNzOiAKCW1rZGly
IGFiYyAmJgoJdGVzdF9tdXN0X2ZhaWwgZ2l0IHdvcmt0cmVlIG1vdmUgYWJjIGRlZgoKZmF0
YWw6ICdhYmMnIGlzIG5vdCBhIHdvcmtpbmcgdHJlZQpvayAxMCAtIG1vdmUgbm9uLXdvcmt0
cmVlCgpleHBlY3Rpbmcgc3VjY2VzczogCglnaXQgd29ya3RyZWUgbG9jayBzb3VyY2UgJiYK
CXRlc3Rfd2hlbl9maW5pc2hlZCAiZ2l0IHdvcmt0cmVlIHVubG9jayBzb3VyY2UiICYmCgl0
ZXN0X211c3RfZmFpbCBnaXQgd29ya3RyZWUgbW92ZSBzb3VyY2UgZGVzdGluYXRpb24KCmZh
dGFsOiBjYW5ub3QgbW92ZSBhIGxvY2tlZCB3b3JraW5nIHRyZWUKb2sgMTEgLSBtb3ZlIGxv
Y2tlZCB3b3JrdHJlZQoKZXhwZWN0aW5nIHN1Y2Nlc3M6IAoJdG9wbGV2ZWw9IiQocHdkKSIg
JiYKCWdpdCB3b3JrdHJlZSBtb3ZlIHNvdXJjZSBkZXN0aW5hdGlvbiAmJgoJdGVzdF9wYXRo
X2lzX21pc3Npbmcgc291cmNlICYmCglnaXQgd29ya3RyZWUgbGlzdCAtLXBvcmNlbGFpbiA+
b3V0ICYmCglncmVwICJed29ya3RyZWUuKi9kZXN0aW5hdGlvbiIgb3V0ICYmCgkhIGdyZXAg
Il53b3JrdHJlZS4qL3NvdXJjZSIgb3V0ICYmCglnaXQgLUMgZGVzdGluYXRpb24gbG9nIC0t
Zm9ybWF0PSVzID5hY3R1YWwyICYmCgllY2hvIGluaXQgPmV4cGVjdGVkMiAmJgoJdGVzdF9j
bXAgZXhwZWN0ZWQyIGFjdHVhbDIKCndvcmt0cmVlIC9ob21lL2prcnVlZ2VyL3NvdXJjZXMv
Z2l0L3QvdHJhc2ggZGlyZWN0b3J5LnQyMDI4LXdvcmt0cmVlLW1vdmUvZGVzdGluYXRpb24K
d29ya3RyZWUgL2hvbWUvamtydWVnZXIvc291cmNlcy9naXQvdC90cmFzaCBkaXJlY3Rvcnku
dDIwMjgtd29ya3RyZWUtbW92ZQp3b3JrdHJlZSAvaG9tZS9qa3J1ZWdlci9zb3VyY2VzL2dp
dC90L3RyYXNoIGRpcmVjdG9yeS50MjAyOC13b3JrdHJlZS1tb3ZlL2Rlc3RpbmF0aW9uCndv
cmt0cmVlIC9ob21lL2prcnVlZ2VyL3NvdXJjZXMvZ2l0L3QvdHJhc2ggZGlyZWN0b3J5LnQy
MDI4LXdvcmt0cmVlLW1vdmUvZWxzZXdoZXJlCm5vdCBvayAxMiAtIG1vdmUgd29ya3RyZWUK
IwkKIwkJdG9wbGV2ZWw9IiQocHdkKSIgJiYKIwkJZ2l0IHdvcmt0cmVlIG1vdmUgc291cmNl
IGRlc3RpbmF0aW9uICYmCiMJCXRlc3RfcGF0aF9pc19taXNzaW5nIHNvdXJjZSAmJgojCQln
aXQgd29ya3RyZWUgbGlzdCAtLXBvcmNlbGFpbiA+b3V0ICYmCiMJCWdyZXAgIl53b3JrdHJl
ZS4qL2Rlc3RpbmF0aW9uIiBvdXQgJiYKIwkJISBncmVwICJed29ya3RyZWUuKi9zb3VyY2Ui
IG91dCAmJgojCQlnaXQgLUMgZGVzdGluYXRpb24gbG9nIC0tZm9ybWF0PSVzID5hY3R1YWwy
ICYmCiMJCWVjaG8gaW5pdCA+ZXhwZWN0ZWQyICYmCiMJCXRlc3RfY21wIGV4cGVjdGVkMiBh
Y3R1YWwyCiMJCg==
--------------F25CF29A4BA23AD8F8F33E62
Content-Type: text/plain; charset=UTF-8;
 name="actual"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="actual"

d29ya3RyZWUgL2hvbWUvamtydWVnZXIvc291cmNlcy9naXQvdC90cmFzaCBkaXJlY3Rvcnku
dDIwMjgtd29ya3RyZWUtbW92ZQp3b3JrdHJlZSAvaG9tZS9qa3J1ZWdlci9zb3VyY2VzL2dp
dC90L3RyYXNoIGRpcmVjdG9yeS50MjAyOC13b3JrdHJlZS1tb3ZlL3NvdXJjZQo=
--------------F25CF29A4BA23AD8F8F33E62
Content-Type: text/plain; charset=UTF-8;
 name="out"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="out"

d29ya3RyZWUgL2hvbWUvamtydWVnZXIvc291cmNlcy9naXQvdC90cmFzaCBkaXJlY3Rvcnku
dDIwMjgtd29ya3RyZWUtbW92ZQpIRUFEIDI1MTkyMTJlZGQxZjU3N2I2MTk2ZDM5NGEwZjA4
YjMxZDVmYWE5NTEKYnJhbmNoIHJlZnMvaGVhZHMvbWFzdGVyCgp3b3JrdHJlZSAvaG9tZS9q
a3J1ZWdlci9zb3VyY2VzL2dpdC90L3RyYXNoIGRpcmVjdG9yeS50MjAyOC13b3JrdHJlZS1t
b3ZlL2Vsc2V3aGVyZQpIRUFEIDI1MTkyMTJlZGQxZjU3N2I2MTk2ZDM5NGEwZjA4YjMxZDVm
YWE5NTEKYnJhbmNoIHJlZnMvaGVhZHMvZWxzZXdoZXJlCgp3b3JrdHJlZSAvaG9tZS9qa3J1
ZWdlci9zb3VyY2VzL2dpdC90L3RyYXNoIGRpcmVjdG9yeS50MjAyOC13b3JrdHJlZS1tb3Zl
L3NvbWUtZGlyL2Rlc3RpbmF0aW9uCkhFQUQgMjUxOTIxMmVkZDFmNTc3YjYxOTZkMzk0YTBm
MDhiMzFkNWZhYTk1MQpicmFuY2ggcmVmcy9oZWFkcy9zb3VyY2UKCg==
--------------F25CF29A4BA23AD8F8F33E62--
