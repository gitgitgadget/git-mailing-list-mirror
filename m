Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9C5C208DB
	for <e@80x24.org>; Thu, 24 Aug 2017 09:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751319AbdHXJKS (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 05:10:18 -0400
Received: from rrzmta2.uni-regensburg.de ([194.94.155.52]:51277 "EHLO
        rrzmta2.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751268AbdHXJKR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 05:10:17 -0400
X-Greylist: delayed 495 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Aug 2017 05:10:17 EDT
Received: from rrzmta2.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 223A978E7A
        for <git@vger.kernel.org>; Thu, 24 Aug 2017 11:02:01 +0200 (CEST)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by rrzmta2.uni-regensburg.de (Postfix) with ESMTP id 0937578D1D
        for <git@vger.kernel.org>; Thu, 24 Aug 2017 11:02:00 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
        with Novell_GroupWise; Thu, 24 Aug 2017 11:02:00 +0200
Message-Id: <599E9607020000A100027965@gwsmtp1.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 14.2.2 
Date:   Thu, 24 Aug 2017 11:01:59 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <git@vger.kernel.org>
Subject: Problems in Default merge message
References: <599E9607020000A100027965@gwsmtp1.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part2E16E417.0__="
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part2E16E417.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi!

I'd like to report an old-time bug in git, regarding the default message =
visible for a "git merge --no-commit" (at the later commit, of course):

* When merging a branch, the first name is put in single quotes, while the =
second is not.

* There is no blank line after the first one

* there are two blank lines further down

I'll attach a sample default merge file as found in the editor.

I suggest to put both branches in single quotes, and to either remove the =
two blank lines, or make them comment lines (for visual separation)

Regards,
Ulrich




--=__Part2E16E417.0__=
Content-Type: application/octet-stream; name="merge-message"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="merge-message"

TWVyZ2UgYnJhbmNoICdmLU5UUC10aW1lc3RhbXBzJyBpbnRvIGYtTlRQLW1vZGU2CiMKIyBJdCBs
b29rcyBsaWtlIHlvdSBtYXkgYmUgY29tbWl0dGluZyBhIG1lcmdlLgojIElmIHRoaXMgaXMgbm90
IGNvcnJlY3QsIHBsZWFzZSByZW1vdmUgdGhlIGZpbGUKIwkuZ2l0L01FUkdFX0hFQUQKIyBhbmQg
dHJ5IGFnYWluLgoKCiMgUGxlYXNlIGVudGVyIHRoZSBjb21taXQgbWVzc2FnZSBmb3IgeW91ciBj
aGFuZ2VzLiBMaW5lcyBzdGFydGluZwojIHdpdGggJyMnIHdpbGwgYmUgaWdub3JlZCwgYW5kIGFu
IGVtcHR5IG1lc3NhZ2UgYWJvcnRzIHRoZSBjb21taXQuCiMgT24gYnJhbmNoIGYtTlRQLW1vZGU2
CiMgWW91ciBicmFuY2ggaXMgYWhlYWQgb2YgJ29yaWdpbi9mLU5UUC1tb2RlNicgYnkgMiBjb21t
aXRzLgojICAgKHVzZSAiZ2l0IHB1c2giIHRvIHB1Ymxpc2ggeW91ciBsb2NhbCBjb21taXRzKQoj
CiMgQWxsIGNvbmZsaWN0cyBmaXhlZCBidXQgeW91IGFyZSBzdGlsbCBtZXJnaW5nLgojCiMgQ2hh
bmdlcyB0byBiZSBjb21taXR0ZWQ6CiMJbW9kaWZpZWQ6ICAgcHJpbnQtbnRwLmMKIwltb2RpZmll
ZDogICB0ZXN0cy9udHAtdGltZS5vdXQKIwojIFVudHJhY2tlZCBmaWxlczoKIwkwMDAxLUltcHJv
dmUtY29tbWVudC1mb3ItdG9rMnN0ci1pbi11dGlsLXByaW50LmMucGF0Y2gKIwkwMDAyLXByaW50
LW50cC5jLUFkZC1hbmQtdXNlLVZFUlNJT05TSElGVC5wYXRjaAojCTAwMDMtUHJlcGFyZS1wcmlu
dC1udHAuYy1mb3ItTlRQLUNvbnRyb2wtTWVzc2FnZXMucGF0Y2gKIwkwMDA0LXByaW50LW50cC5j
LUhhbmRsZS1OVFAtQ29udHJvbC1NZXNzYWdlcy5wYXRjaAojCTAwMDUtcHJpbnQtbnRwLmMtT3V0
cHV0LWEtbm9uLXByaW1hcnktUmVmZXJlbmNlLUlELnBhdGNoCiMJMDAwNi10ZXN0cy1URVNUTElT
VC1BZGQtdGVzdHMtbnRwLWNvbnRyb2wtYW5kLW50cC10aW1lLnBhdGNoCiMJcGF0Y2hlcy1lMzhh
NjhkNC50YXIuZ3oKIwlwcHAKIwl4eHgKIwo=

--=__Part2E16E417.0__=--
