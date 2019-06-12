Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76B481F462
	for <e@80x24.org>; Wed, 12 Jun 2019 13:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408460AbfFLNlP (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 09:41:15 -0400
Received: from atl4mhfb02.myregisteredsite.com ([209.17.115.118]:41130 "EHLO
        atl4mhfb02.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407111AbfFLNlP (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 12 Jun 2019 09:41:15 -0400
X-Greylist: delayed 324 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Jun 2019 09:41:14 EDT
Received: from jax4mhob11.myregisteredsite.com (jax4mhob11.myregisteredsite.com [64.69.218.91])
        by atl4mhfb02.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id x5CDZoJT011008
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 09:35:50 -0400
Received: from mymail.myregisteredsite.com (jax4wmnode1a.mymail.myregisteredsite.com [209.237.134.202])
        by jax4mhob11.myregisteredsite.com (8.14.4/8.14.4) with SMTP id x5CDZl0u002794
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 09:35:47 -0400
Received: (qmail 2318 invoked by uid 80); 12 Jun 2019 13:35:47 -0000
Received: from unknown (HELO ?10.10.10.107?) (akinzalow@uda1.com@47.48.157.58)
  by mymail.myregisteredsite.com with ESMTPA; 12 Jun 2019 13:35:47 -0000
To:     git@vger.kernel.org
From:   Allen Kinzalow <akinzalow@uda1.com>
Subject: Git Pull Hangs
Message-ID: <6d09f626-631b-f6a2-8df3-37530fc62d50@uda1.com>
Date:   Wed, 12 Jun 2019 08:35:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------1A27AFD96814B15702DCD303"
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------1A27AFD96814B15702DCD303
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I have attached the output of a "git pull" command. Suddenly we are 
unable to pull or fetch anything from our repository. It is temporarily 
fixed by deleting .git/packed-refs but quickly starts happening again.

I have attached the output of where it stops execution. We are unsure as 
to why this started happening. The only real solution right now is to 
reclone the repository. After doing do it will be fixed for a longer 
period of time (maybe a week) before it shows up again.

Any help or suggestions is appreciated.


Thanks,

Allen Kinzalow

UDA Technologies


--------------1A27AFD96814B15702DCD303
Content-Type: text/plain; charset=UTF-8;
 name="pull.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="pull.txt"

JCBnaXQgcHVsbCA+IHB1bGwudHh0DQoxNzoxMTo1MC41MDg2NDggZXhlYy1jbWQuYzoyMzYg
ICAgICAgICAgdHJhY2U6IHJlc29sdmVkIGV4ZWN1dGFibGUgZGlyOiBDOi9Qcm9ncmFtIEZp
bGVzL0dpdC9taW5ndzY0L2Jpbg0KMTc6MTE6NTAuNTExNjQ2IGdpdC5jOjQxOSAgICAgICAg
ICAgICAgIHRyYWNlOiBidWlsdC1pbjogZ2l0IHB1bGwNCjE3OjExOjUwLjUxNzYzMSBydW4t
Y29tbWFuZC5jOjY0MyAgICAgICB0cmFjZTogcnVuX2NvbW1hbmQ6IGdpdCBmZXRjaCAtLXVw
ZGF0ZS1oZWFkLW9rDQoxNzoxMTo1MC41NTk2MDUgZXhlYy1jbWQuYzoyMzYgICAgICAgICAg
dHJhY2U6IHJlc29sdmVkIGV4ZWN1dGFibGUgZGlyOiBDOi9Qcm9ncmFtIEZpbGVzL0dpdC9t
aW5ndzY0L2xpYmV4ZWMvZ2l0LWNvcmUNCjE3OjExOjUwLjU2MTYwMyBnaXQuYzo0MTkgICAg
ICAgICAgICAgICB0cmFjZTogYnVpbHQtaW46IGdpdCBmZXRjaCAtLXVwZGF0ZS1oZWFkLW9r
DQoxNzoxMTo1MC41Njg1OTkgcnVuLWNvbW1hbmQuYzo2NDMgICAgICAgdHJhY2U6IHJ1bl9j
b21tYW5kOiBHSVRfRElSPS5naXQgZ2l0IHJlbW90ZS1odHRwIG9yaWdpbiBodHRwOi8vdWRh
dC5iaXovQ09MX0RFVi9Db25zdHJ1Y3Rpb25PbmxpbmUuZ2l0DQoxNzoxMTo1MC42MDE3NDMg
ZXhlYy1jbWQuYzoyMzYgICAgICAgICAgdHJhY2U6IHJlc29sdmVkIGV4ZWN1dGFibGUgZGly
OiBDOi9Qcm9ncmFtIEZpbGVzL0dpdC9taW5ndzY0L2xpYmV4ZWMvZ2l0LWNvcmUNCjE3OjEx
OjUwLjYwMzc0MyBnaXQuYzo2NzYgICAgICAgICAgICAgICB0cmFjZTogZXhlYzogZ2l0LXJl
bW90ZS1odHRwIG9yaWdpbiBodHRwOi8vdWRhdC5iaXovQ09MX0RFVi9Db25zdHJ1Y3Rpb25P
bmxpbmUuZ2l0DQoxNzoxMTo1MC42MDM3NDMgcnVuLWNvbW1hbmQuYzo2NDMgICAgICAgdHJh
Y2U6IHJ1bl9jb21tYW5kOiBnaXQtcmVtb3RlLWh0dHAgb3JpZ2luIGh0dHA6Ly91ZGF0LmJp
ei9DT0xfREVWL0NvbnN0cnVjdGlvbk9ubGluZS5naXQNCjE3OjExOjUwLjYzNTgwMCBleGVj
LWNtZC5jOjIzNiAgICAgICAgICB0cmFjZTogcmVzb2x2ZWQgZXhlY3V0YWJsZSBkaXI6IEM6
L1Byb2dyYW0gRmlsZXMvR2l0L21pbmd3NjQvbGliZXhlYy9naXQtY29yZQ0KMTc6MTE6NTAu
ODE1NzkyIHJ1bi1jb21tYW5kLmM6NjQzICAgICAgIHRyYWNlOiBydW5fY29tbWFuZDogJ2dp
dCBjcmVkZW50aWFsLW1hbmFnZXIgZ2V0Jw0KMTc6MTE6NTEuMDk2ODk3IGV4ZWMtY21kLmM6
MjM2ICAgICAgICAgIHRyYWNlOiByZXNvbHZlZCBleGVjdXRhYmxlIGRpcjogQzovUHJvZ3Jh
bSBGaWxlcy9HaXQvbWluZ3c2NC9saWJleGVjL2dpdC1jb3JlDQoxNzoxMTo1MS4wOTg4OTYg
Z2l0LmM6Njc2ICAgICAgICAgICAgICAgdHJhY2U6IGV4ZWM6IGdpdC1jcmVkZW50aWFsLW1h
bmFnZXIgZ2V0DQoxNzoxMTo1MS4wOTg4OTYgcnVuLWNvbW1hbmQuYzo2NDMgICAgICAgdHJh
Y2U6IHJ1bl9jb21tYW5kOiBnaXQtY3JlZGVudGlhbC1tYW5hZ2VyIGdldA0KMTc6MTE6NTEu
MjEzOTI1IC4uLlxDb21tb24uY3M6NzQ0ICAgICAgIHRyYWNlOiBbTWFpbl0gZ2l0LWNyZWRl
bnRpYWwtbWFuYWdlciAodjEuMTguNCkgJ2dldCcNCjE3OjExOjUxLjI3ODg5OCAuLi5cR2l0
XFdoZXJlLmNzOjM0OCAgICB0cmFjZTogW0ZpbmRHaXRJbnN0YWxsYXRpb25zXSBmb3VuZCAx
IEdpdCBpbnN0YWxsYXRpb24ocykuDQoxNzoxMTo1MS4yODM4NjggLi4uQ29uZmlndXJhdGlv
bi5jczoyMjIgdHJhY2U6IFtMb2FkR2l0Q29uZmlndXJhdGlvbl0gZ2l0IEFsbCBjb25maWcg
cmVhZCwgNTIgZW50cmllcy4NCjE3OjExOjUxLjM0MTg0NiAuLi5cQ29tbW9uLmNzOjg1ICAg
ICAgICB0cmFjZTogW0NyZWF0ZUF1dGhlbnRpY2F0aW9uXSBkZXRlY3RpbmcgYXV0aG9yaXR5
IHR5cGUgZm9yICdodHRwOi8vdWRhdC5iaXovJy4NCjE3OjExOjUxLjM1Mzg0NSAuLi5cQ29t
bW9uLmNzOjIyNCAgICAgICB0cmFjZTogW0NyZWF0ZUF1dGhlbnRpY2F0aW9uXSBhdXRob3Jp
dHkgZm9yICdodHRwOi8vdWRhdC5iaXovJyBpcyBiYXNpYyB3aXRoIE5UTE09QXV0by4NCjE3
OjExOjUxLjM1NDgzNCAuLi5cQ29tbW9uLmNzOjc2NSAgICAgICB0cmFjZTogW1F1ZXJ5Q3Jl
ZGVudGlhbHNdIHF1ZXJ5aW5nICdBdXRvJyBmb3IgY3JlZGVudGlhbHMuDQoxNzoxMTo1MS4z
Njk4MTcgLi4uXENvbW1vbi5jczo3ODAgICAgICAgdHJhY2U6IFtRdWVyeUNyZWRlbnRpYWxz
XSBjcmVkZW50aWFscyBmb3VuZC4NCjE3OjExOjUxLjcyMzIzNiBydW4tY29tbWFuZC5jOjY0
MyAgICAgICB0cmFjZTogcnVuX2NvbW1hbmQ6ICdnaXQgY3JlZGVudGlhbC1tYW5hZ2VyIHN0
b3JlJw0KMTc6MTE6NTEuODg1Njc2IGV4ZWMtY21kLmM6MjM2ICAgICAgICAgIHRyYWNlOiBy
ZXNvbHZlZCBleGVjdXRhYmxlIGRpcjogQzovUHJvZ3JhbSBGaWxlcy9HaXQvbWluZ3c2NC9s
aWJleGVjL2dpdC1jb3JlDQoxNzoxMTo1MS44ODY2NzUgZ2l0LmM6Njc2ICAgICAgICAgICAg
ICAgdHJhY2U6IGV4ZWM6IGdpdC1jcmVkZW50aWFsLW1hbmFnZXIgc3RvcmUNCjE3OjExOjUx
Ljg4NjY3NSBydW4tY29tbWFuZC5jOjY0MyAgICAgICB0cmFjZTogcnVuX2NvbW1hbmQ6IGdp
dC1jcmVkZW50aWFsLW1hbmFnZXIgc3RvcmUNCjE3OjExOjUxLjk4MjcwOCAuLi5cQ29tbW9u
LmNzOjc0NCAgICAgICB0cmFjZTogW01haW5dIGdpdC1jcmVkZW50aWFsLW1hbmFnZXIgKHYx
LjE4LjQpICdzdG9yZScNCjE3OjExOjUyLjA0NTY1OSAuLi5cR2l0XFdoZXJlLmNzOjM0OCAg
ICB0cmFjZTogW0ZpbmRHaXRJbnN0YWxsYXRpb25zXSBmb3VuZCAxIEdpdCBpbnN0YWxsYXRp
b24ocykuDQoxNzoxMTo1Mi4wNTA2NTggLi4uQ29uZmlndXJhdGlvbi5jczoyMjIgdHJhY2U6
IFtMb2FkR2l0Q29uZmlndXJhdGlvbl0gZ2l0IEFsbCBjb25maWcgcmVhZCwgNTIgZW50cmll
cy4NCjE3OjExOjUyLjA4ODY1MiAuLi5cQ29tbW9uLmNzOjg1ICAgICAgICB0cmFjZTogW0Ny
ZWF0ZUF1dGhlbnRpY2F0aW9uXSBkZXRlY3RpbmcgYXV0aG9yaXR5IHR5cGUgZm9yICdodHRw
Oi8vYWtpbnphbG93QHVkYXQuYml6LycuDQoxNzoxMTo1Mi4xMDI2MjYgLi4uXENvbW1vbi5j
czoyMjQgICAgICAgdHJhY2U6IFtDcmVhdGVBdXRoZW50aWNhdGlvbl0gYXV0aG9yaXR5IGZv
ciAnaHR0cDovL2FraW56YWxvd0B1ZGF0LmJpei8nIGlzIGJhc2ljIHdpdGggTlRMTT1BdXRv
Lg0KMTc6MTE6NTIuMTAyNjI2IC4uLlxQcm9ncmFtLmNzOjUxMyAgICAgIHRyYWNlOiBbU3Rv
cmVdIHN0b3JpbmcgYmFzaWMgY3JlZGVudGlhbHMgZm9yICdodHRwOi8vYWtpbnphbG93QHVk
YXQuYml6LycuDQoxNzoxMTo1Mi4xNzU3MDkgcnVuLWNvbW1hbmQuYzo2NDMgICAgICAgdHJh
Y2U6IHJ1bl9jb21tYW5kOiBnaXQgZmV0Y2gtcGFjayAtLXN0YXRlbGVzcy1ycGMgLS1zdGRp
biAtLWxvY2stcGFjayAtLWluY2x1ZGUtdGFnIC0tdGhpbiBodHRwOi8vdWRhdC5iaXovQ09M
X0RFVi9Db25zdHJ1Y3Rpb25PbmxpbmUuZ2l0Lw0KMTc6MTE6NTIuMjE4NzMyIGV4ZWMtY21k
LmM6MjM2ICAgICAgICAgIHRyYWNlOiByZXNvbHZlZCBleGVjdXRhYmxlIGRpcjogQzovUHJv
Z3JhbSBGaWxlcy9HaXQvbWluZ3c2NC9saWJleGVjL2dpdC1jb3JlDQoxNzoxMTo1Mi4yMjA3
MzAgZ2l0LmM6NDE5ICAgICAgICAgICAgICAgdHJhY2U6IGJ1aWx0LWluOiBnaXQgZmV0Y2gt
cGFjayAtLXN0YXRlbGVzcy1ycGMgLS1zdGRpbiAtLWxvY2stcGFjayAtLWluY2x1ZGUtdGFn
IC0tdGhpbiBodHRwOi8vdWRhdC5iaXovQ09MX0RFVi9Db25zdHJ1Y3Rpb25PbmxpbmUuZ2l0
Lw0K
--------------1A27AFD96814B15702DCD303--
