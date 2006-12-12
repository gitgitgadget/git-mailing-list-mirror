X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: git-pull: "Cannot obtain needed none"?
Date: Tue, 12 Dec 2006 18:43:48 +0100
Message-ID: <81b0412b0612120943i48c8597u32d0300cbbd7b3e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_115910_22424325.1165945428340"
NNTP-Posting-Date: Tue, 12 Dec 2006 17:43:56 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=ILP4INecRnqA7tGCnc9k/4ZnyJvfj4A9aGPBptD5yJwuuFoeY+RbdePFUQ+oflgRCTuZCR5LXREV3bwwSl2sym5i+2MBS+XfJCTNn3Ja+lkoCYQ6t4CYhgBkem1Cb1NircZ+5WOFGkNbBH3HjF6S1dd755o5LxvksH4q8jfuuFc=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34115>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuBfW-0001iN-SE for gcvg-git@gmane.org; Tue, 12 Dec
 2006 18:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932240AbWLLRnv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 12:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWLLRnv
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 12:43:51 -0500
Received: from wr-out-0506.google.com ([64.233.184.227]:15275 "EHLO
 wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932240AbWLLRnu (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec
 2006 12:43:50 -0500
Received: by wr-out-0506.google.com with SMTP id i7so2099655wra for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 09:43:49 -0800 (PST)
Received: by 10.78.193.19 with SMTP id q19mr1195332huf.1165945428514; Tue, 12
 Dec 2006 09:43:48 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Tue, 12 Dec 2006 09:43:48 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

------=_Part_115910_22424325.1165945428340
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Sometimes I wonder what language do we use in user-visible messages :)
What none was it, which could not be obtained? Why could none be needed?
Why does it happen processing commit 00000...?

error: Unable to find 9a6e87b60dbd2305c95cecce7d9d60f849a0658d under
http://www.kernel.org/pub/scm/git/git.git/
Cannot obtain needed none 9a6e87b60dbd2305c95cecce7d9d60f849a0658d
while processing commit 0000000000000000000000000000000000000000.

Complete trace:
GIT_TRACE=1 git pull
trace: exec: '/d/scripts/git/git-pull'
trace: built-in: git 'rev-parse' '--git-dir'
trace: built-in: git 'rev-parse' '--git-dir'
trace: built-in: git 'symbolic-ref' 'HEAD'
trace: built-in: git 'repo-config' '--get' 'branch.raa/2.remote'
trace: built-in: git 'repo-config' '--get' 'remote.origin.url'
trace: built-in: git 'repo-config' '--get' 'remote.origin.url'
trace: exec: '/d/scripts/git/git-ls-remote'
'http://www.kernel.org/pub/scm/git/git.git'
trace: built-in: git 'repo-config' '--get' 'remote.http:.url'
trace: built-in: git 'repo-config' '--bool' 'http.noEPSV'
trace: built-in: git 'repo-config' '--get' 'remote.origin.url'
trace: built-in: git 'symbolic-ref' 'HEAD'
trace: built-in: git 'repo-config' '--get' 'branch.raa/2.remote'
trace: built-in: git 'symbolic-ref' 'HEAD'
trace: built-in: git 'repo-config' '--get-all' 'branch.raa/2.merge'
trace: built-in: git 'check-ref-format' 'heads/git'
trace: built-in: git 'check-ref-format' 'heads/pu'
trace: built-in: git 'check-ref-format' 'heads/next'
trace: built-in: git 'repo-config' '--bool' 'http.noEPSV'
Fetching refs/heads/master from
http://www.kernel.org/pub/scm/git/git.git using http
trace: built-in: git 'rev-parse' '--verify'
'6f9872582246b9b8ee4bdc9f6a563b409aab1ecb^0'
trace: built-in: git 'cat-file' '-t' '6f9872582246b9b8ee4bdc9f6a563b409aab1ecb'
trace: built-in: git 'rev-parse' '--short'
'6f9872582246b9b8ee4bdc9f6a563b409aab1ecb'
trace: built-in: git 'repo-config' '--bool' 'http.noEPSV'
Fetching refs/heads/pu from http://www.kernel.org/pub/scm/git/git.git using http
Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
Getting pack list for http://www.kernel.org/pub/scm/git/git.git/
error: Unable to find 9a6e87b60dbd2305c95cecce7d9d60f849a0658d under
http://www.kernel.org/pub/scm/git/git.git/
Cannot obtain needed none 9a6e87b60dbd2305c95cecce7d9d60f849a0658d
while processing commit 0000000000000000000000000000000000000000.

FWIW, a patch changing it to:
git fetch
Fetching refs/heads/master from
http://www.kernel.org/pub/scm/git/git.git using http
Fetching refs/heads/pu from http://www.kernel.org/pub/scm/git/git.git using http
Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
Getting pack list for http://www.kernel.org/pub/scm/git/git.git/
error: Unable to find 9a6e87b60dbd2305c95cecce7d9d60f849a0658d under
http://www.kernel.org/pub/scm/git/git.git/
Cannot obtain needed object 9a6e87b60dbd2305c95cecce7d9d60f849a0658d

attached.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

------=_Part_115910_22424325.1165945428340
Content-Type: text/x-diff; name="needed-none.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="needed-none.patch"
X-Attachment-Id: file0

RnJvbSAzOGU0ZDI0M2ZkMTYzY2E3NzIzM2Y3MzAwN2I2YjYyM2VlYzgxYzY4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUdWUsIDEyIERlYyAyMDA2IDE4OjM0OjAyICswMTAwClN1YmplY3Q6IFtQQVRDSF0gQ2xhcmlm
eSBmZXRjaCBlcnJvciBmb3IgbWlzc2luZyBvYmplY3RzLgoKT3RoZXJ3aXNlIHRoZXJlJ3JlIHN1
Y2ggdGhpbmdzIGxpa2U6CgogICAgQ2Fubm90IG9idGFpbiBuZWVkZWQgbm9uZSA5YTZlODdiNjBk
YmQyMzA1Yzk1Y2VjY2U3ZDlkNjBmODQ5YTA2NThkCiAgICB3aGlsZSBwcm9jZXNzaW5nIGNvbW1p
dCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLgoKd2hpY2ggd2hpbGUg
bG9va3Mgd2VpcmQuIFdoYXQgaXMgdGhlIG5vbmUgbmVlZGVkIGZvcj8KCmRpZmYgLS1naXQgYS9m
ZXRjaC5jIGIvZmV0Y2guYwppbmRleCBjNDI2YzA0Li42NjNiNGIyIDEwMDY0NAotLS0gYS9mZXRj
aC5jCisrKyBiL2ZldGNoLmMKQEAgLTIyLDE0ICsyMiwxNSBAQCB2b2lkIHB1bGxfc2F5KGNvbnN0
IGNoYXIgKmZtdCwgY29uc3QgY2hhciAqaGV4KQogCQlmcHJpbnRmKHN0ZGVyciwgZm10LCBoZXgp
OwogfQogCi1zdGF0aWMgdm9pZCByZXBvcnRfbWlzc2luZyhjb25zdCBjaGFyICp3aGF0LCBjb25z
dCB1bnNpZ25lZCBjaGFyICptaXNzaW5nKQorc3RhdGljIHZvaWQgcmVwb3J0X21pc3NpbmcoY29u
c3Qgc3RydWN0IG9iamVjdCAqb2JqKQogewogCWNoYXIgbWlzc2luZ19oZXhbNDFdOwotCi0Jc3Ry
Y3B5KG1pc3NpbmdfaGV4LCBzaGExX3RvX2hleChtaXNzaW5nKSk7OwotCWZwcmludGYoc3RkZXJy
LAotCQkiQ2Fubm90IG9idGFpbiBuZWVkZWQgJXMgJXNcbndoaWxlIHByb2Nlc3NpbmcgY29tbWl0
ICVzLlxuIiwKLQkJd2hhdCwgbWlzc2luZ19oZXgsIHNoYTFfdG9faGV4KGN1cnJlbnRfY29tbWl0
X3NoYTEpKTsKKwlzdHJjcHkobWlzc2luZ19oZXgsIHNoYTFfdG9faGV4KG9iai0+c2hhMSkpOzsK
KwlmcHJpbnRmKHN0ZGVyciwgIkNhbm5vdCBvYnRhaW4gbmVlZGVkICVzICVzXG4iLAorCQlvYmot
PnR5cGUgPyB0eXBlbmFtZShvYmotPnR5cGUpOiAib2JqZWN0IiwgbWlzc2luZ19oZXgpOworCWlm
ICghaXNfbnVsbF9zaGExKGN1cnJlbnRfY29tbWl0X3NoYTEpKQorCQlmcHJpbnRmKHN0ZGVyciwg
IndoaWxlIHByb2Nlc3NpbmcgY29tbWl0ICVzLlxuIiwKKwkJCXNoYTFfdG9faGV4KGN1cnJlbnRf
Y29tbWl0X3NoYTEpKTsKIH0KIAogc3RhdGljIGludCBwcm9jZXNzKHN0cnVjdCBvYmplY3QgKm9i
aik7CkBAIC0xNzcsNyArMTc4LDcgQEAgc3RhdGljIGludCBsb29wKHZvaWQpCiAJCSAqLwogCQlp
ZiAoISAob2JqLT5mbGFncyAmIFRPX1NDQU4pKSB7CiAJCQlpZiAoZmV0Y2gob2JqLT5zaGExKSkg
ewotCQkJCXJlcG9ydF9taXNzaW5nKHR5cGVuYW1lKG9iai0+dHlwZSksIG9iai0+c2hhMSk7CisJ
CQkJcmVwb3J0X21pc3Npbmcob2JqKTsKIAkJCQlyZXR1cm4gLTE7CiAJCQl9CiAJCX0K
