From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH] git-tag: Fix -l option to use better shell style globs.
Date: Sat, 1 Sep 2007 16:46:30 +0200
Message-ID: <1b46aba20709010746h204bfbbbtc0d83336f76570c3@mail.gmail.com>
References: <46D8F431.70801@gmail.com>
	 <7v8x7qvrka.fsf@gitster.siamese.dyndns.org>
	 <1b46aba20709010733x45960f00g8732f6a1af363768@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3173_28395643.1188657990336"
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 16:46:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRUFC-0007C3-3A
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 16:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753373AbXIAOqc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 10:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753243AbXIAOqc
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 10:46:32 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:40316 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbXIAOqb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 10:46:31 -0400
Received: by rv-out-0910.google.com with SMTP id k20so618767rvb
        for <git@vger.kernel.org>; Sat, 01 Sep 2007 07:46:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=Cf+2xIQaTagA97fJTY59XlzaX6lyPn+7vilUseY2wCrvXfObH+A/fww+r5u9vP9GN+kfHW+CoIFN7Kh/dPg6iscmCMG4QaBbneNwTh2EsbrPAlJtfzFUGt65eDf20CxJg1cOZefcfCkRKm0KTG0jhvxW+GAtOBcIh1aPGinyOSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=oAeEwEddZ0fOR6FXchZuzLgttOIXEBkobmrc3ov+CVrwifNXHmC1OpOYV+gwogHESNfx8ozhkx1PypiwG3BeYZO+1Yo9CP+qpUK8lOuowOgaiVOw6UfqtKVHdtQpVujC66AzXYfvekEcNOPxkWYaobSn/qGdxhxWwW0b0jd2fHs=
Received: by 10.142.156.2 with SMTP id d2mr133526wfe.1188657990393;
        Sat, 01 Sep 2007 07:46:30 -0700 (PDT)
Received: by 10.143.10.14 with HTTP; Sat, 1 Sep 2007 07:46:30 -0700 (PDT)
In-Reply-To: <1b46aba20709010733x45960f00g8732f6a1af363768@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57275>

------=_Part_3173_28395643.1188657990336
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2007/9/1, Carlos Rica <jasampler@gmail.com>:
> You are right. I changed the patch also to reflect this.

Sorry, it seems that it also has a different "version" of
my comments for the commit, I have the good/bad habit of
reading again the comments in patches (and changing them)
before send it out to the list...

6c6
This patch removes certain behaviour of "git tag -l foo", currently
This patch removes the behaviour of "git tag -l foo", currently

10c10
This feature was added recently when git-tag.sh got the -n option
The "feature" was added recently when git-tag.sh got the -n option

18c18
_only_ when * is inserted before and after (as in "*substring*"), and
_only_ when * is inserted before and after (as in "*substr*"), and

------=_Part_3173_28395643.1188657990336
Content-Type: text/x-patch; 
	name=0001-git-tag-Fix-l-option-to-use-better-shell-style-globs.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f6287tbs
Content-Disposition: attachment; filename="0001-git-tag-Fix-l-option-to-use-better-shell-style-globs.patch"

RnJvbSBlYTg4MWZkZmQzOWNlNWZiNWFhYTI3M2Q5MGM2YmY4ZWQ1ZjhkOWIwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDYXJsb3MgUmljYSA8amFzYW1wbGVyQGdtYWlsLmNvbT4KRGF0
ZTogU2F0LCAxIFNlcCAyMDA3IDA2OjU4OjQwICswMjAwClN1YmplY3Q6IFtQQVRDSF0gZ2l0LXRh
ZzogRml4IC1sIG9wdGlvbiB0byB1c2UgYmV0dGVyIHNoZWxsIHN0eWxlIGdsb2JzLgoKVGhpcyBw
YXRjaCByZW1vdmVzIGNlcnRhaW4gYmVoYXZpb3VyIG9mICJnaXQgdGFnIC1sIGZvbyIsIGN1cnJl
bnRseQpsaXN0aW5nIGV2ZXJ5IHRhZyBuYW1lIGhhdmluZyAiZm9vIiBhcyBhIHN1YnN0cmluZy4g
IFRoZSBzYW1lCnRoaW5nIG5vdyBjb3VsZCBiZSBhY2hpZXZlZCBkb2luZyAiZ2l0IHRhZyAtbCAn
KmZvbyonIi4KClRoaXMgZmVhdHVyZSB3YXMgYWRkZWQgcmVjZW50bHkgd2hlbiBnaXQtdGFnLnNo
IGdvdCB0aGUgLW4gb3B0aW9uCmZvciBzaG93aW5nIHRhZyBhbm5vdGF0aW9ucywgYmVjYXVzZSB0
aGF0IGNvbW1pdCBhbHNvIHJlcGxhY2VkIHRoZQpvbGQgImdyZXAgcGF0dGVybiIgYmVoYXZpb3Vy
IHdpdGggYSBtb3JlIHByZWZlcmFibGUgInNoZWxsIHBhdHRlcm4iCmJlaGF2aW91ciAoYWx0aG91
Z2ggc2xpZ2h0bHkgbW9kaWZpZWQgYXMgeW91IGNhbiBzZWUpLgpUaHVzLCB0aGUgZm9sbG93aW5n
IGJ1aWx0aW4tdGFnLmMgaW1wbGVtZW50ZWQgaXQgaW4gb3JkZXIgdG8KZW5zdXJlIHRoYXQgdGVz
dHMgd2VyZSBwYXNzaW5nIHVuY2hhbmdlZCB3aXRoIGJvdGggcHJvZ3JhbXMuCgpTaW5jZSBjb21t
b24gInNoZWxsIHBhdHRlcm5zIiBtYXRjaCBuYW1lcyB3aXRoIGEgZ2l2ZW4gc3Vic3RyaW5nCl9v
bmx5XyB3aGVuICogaXMgaW5zZXJ0ZWQgYmVmb3JlIGFuZCBhZnRlciAoYXMgaW4gIipzdWJzdHJp
bmcqIiksIGFuZAp0aGUgInBsYWluIiBiZWhhdmlvdXIgY2Fubm90IGJlIGFjaGlldmVkIGVhc2ls
eSB3aXRoIHRoZSBjdXJyZW50CmltcGxlbWVudGF0aW9uLCB0aGlzIGlzIG1vc3RseSB0aGUgcmln
aHQgdGhpbmcgdG8gZG8sIGluIG9yZGVyIHRvCm1ha2UgaXQgbW9yZSBmbGV4aWJsZSBhbmQgY29u
c2lzdGVudC4KClRlc3RzIGZvciAiZ2l0IHRhZyIgd2VyZSBhbHNvIGNoYW5nZWQgdG8gcmVmbGVj
dCB0aGlzLgoKU2lnbmVkLW9mZi1ieTogQ2FybG9zIFJpY2EgPGphc2FtcGxlckBnbWFpbC5jb20+
Ci0tLQogYnVpbHRpbi10YWcuYyAgfCAgIDE0ICsrLS0tLS0tLS0tLS0tCiB0L3Q3MDA0LXRhZy5z
aCB8ICAgMjAgKysrKysrKysrLS0tLS0tLS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0
aW9ucygrKSwgMjMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYnVpbHRpbi10YWcuYyBiL2J1
aWx0aW4tdGFnLmMKaW5kZXggZDZkMzhhZC4uMGUwMWI5OCAxMDA2NDQKLS0tIGEvYnVpbHRpbi10
YWcuYworKysgYi9idWlsdGluLXRhZy5jCkBAIC03NSw3ICs3NSw3IEBAIHN0YXRpYyBpbnQgc2hv
d19yZWZlcmVuY2UoY29uc3QgY2hhciAqcmVmbmFtZSwgY29uc3QgdW5zaWduZWQgY2hhciAqc2hh
MSwKIHsKIAlzdHJ1Y3QgdGFnX2ZpbHRlciAqZmlsdGVyID0gY2JfZGF0YTsKIAotCWlmICghZm5t
YXRjaChmaWx0ZXItPnBhdHRlcm4sIHJlZm5hbWUsIDApKSB7CisJaWYgKCFmaWx0ZXItPnBhdHRl
cm4gfHwgIWZubWF0Y2goZmlsdGVyLT5wYXR0ZXJuLCByZWZuYW1lLCAwKSkgewogCQlpbnQgaTsK
IAkJdW5zaWduZWQgbG9uZyBzaXplOwogCQllbnVtIG9iamVjdF90eXBlIHR5cGU7CkBAIC0xMjMs
MjIgKzEyMywxMiBAQCBzdGF0aWMgaW50IHNob3dfcmVmZXJlbmNlKGNvbnN0IGNoYXIgKnJlZm5h
bWUsIGNvbnN0IHVuc2lnbmVkIGNoYXIgKnNoYTEsCiBzdGF0aWMgaW50IGxpc3RfdGFncyhjb25z
dCBjaGFyICpwYXR0ZXJuLCBpbnQgbGluZXMpCiB7CiAJc3RydWN0IHRhZ19maWx0ZXIgZmlsdGVy
OwotCWNoYXIgKm5ld3BhdHRlcm47CiAKLQlpZiAocGF0dGVybiA9PSBOVUxMKQotCQlwYXR0ZXJu
ID0gIiI7Ci0KLQkvKiBwcmVwZW5kL2FwcGVuZCAqIHRvIHRoZSBzaGVsbCBwYXR0ZXJuOiAqLwot
CW5ld3BhdHRlcm4gPSB4bWFsbG9jKHN0cmxlbihwYXR0ZXJuKSArIDMpOwotCXNwcmludGYobmV3
cGF0dGVybiwgIiolcyoiLCBwYXR0ZXJuKTsKLQotCWZpbHRlci5wYXR0ZXJuID0gbmV3cGF0dGVy
bjsKKwlmaWx0ZXIucGF0dGVybiA9IHBhdHRlcm47CiAJZmlsdGVyLmxpbmVzID0gbGluZXM7CiAK
IAlmb3JfZWFjaF90YWdfcmVmKHNob3dfcmVmZXJlbmNlLCAodm9pZCAqKSAmZmlsdGVyKTsKIAot
CWZyZWUobmV3cGF0dGVybik7Ci0KIAlyZXR1cm4gMDsKIH0KIApkaWZmIC0tZ2l0IGEvdC90NzAw
NC10YWcuc2ggYi90L3Q3MDA0LXRhZy5zaAppbmRleCBjNGZhNDQ2Li42MDZkNGYyIDEwMDc1NQot
LS0gYS90L3Q3MDA0LXRhZy5zaAorKysgYi90L3Q3MDA0LXRhZy5zaApAQCAtMTg1LDE4ICsxODUs
MTcgQEAgY2JhCiBFT0YKIHRlc3RfZXhwZWN0X3N1Y2Nlc3MgXAogCSdsaXN0aW5nIHRhZ3Mgd2l0
aCBzdWJzdHJpbmcgYXMgcGF0dGVybiBtdXN0IHByaW50IHRob3NlIG1hdGNoaW5nJyAnCi0JZ2l0
LXRhZyAtbCBhID4gYWN0dWFsICYmCisJZ2l0LXRhZyAtbCAiKmEqIiA+IGFjdHVhbCAmJgogCWdp
dCBkaWZmIGV4cGVjdCBhY3R1YWwKICcKIAogY2F0ID5leHBlY3QgPDxFT0YKIHYwLjIuMQogdjEu
MC4xCi12MS4xLjMKIEVPRgogdGVzdF9leHBlY3Rfc3VjY2VzcyBcCi0JJ2xpc3RpbmcgdGFncyB3
aXRoIHN1YnN0cmluZyBhcyBwYXR0ZXJuIG11c3QgcHJpbnQgdGhvc2UgbWF0Y2hpbmcnICcKLQln
aXQtdGFnIC1sIC4xID4gYWN0dWFsICYmCisJJ2xpc3RpbmcgdGFncyB3aXRoIGEgc3VmZml4IGFz
IHBhdHRlcm4gbXVzdCBwcmludCB0aG9zZSBtYXRjaGluZycgJworCWdpdC10YWcgLWwgIiouMSIg
PiBhY3R1YWwgJiYKIAlnaXQgZGlmZiBleHBlY3QgYWN0dWFsCiAnCiAKQEAgLTIwNSwzNyArMjA0
LDM2IEBAIHQyMTAKIHQyMTEKIEVPRgogdGVzdF9leHBlY3Rfc3VjY2VzcyBcCi0JJ2xpc3Rpbmcg
dGFncyB3aXRoIHN1YnN0cmluZyBhcyBwYXR0ZXJuIG11c3QgcHJpbnQgdGhvc2UgbWF0Y2hpbmcn
ICcKLQlnaXQtdGFnIC1sIHQyMSA+IGFjdHVhbCAmJgorCSdsaXN0aW5nIHRhZ3Mgd2l0aCBhIHBy
ZWZpeCBhcyBwYXR0ZXJuIG11c3QgcHJpbnQgdGhvc2UgbWF0Y2hpbmcnICcKKwlnaXQtdGFnIC1s
ICJ0MjEqIiA+IGFjdHVhbCAmJgogCWdpdCBkaWZmIGV4cGVjdCBhY3R1YWwKICcKIAogY2F0ID5l
eHBlY3QgPDxFT0YKIGExCi1hYTEKIEVPRgogdGVzdF9leHBlY3Rfc3VjY2VzcyBcCi0JJ2xpc3Rp
bmcgdGFncyB1c2luZyBhIG5hbWUgYXMgcGF0dGVybiBtdXN0IHByaW50IHRob3NlIG1hdGNoaW5n
JyAnCisJJ2xpc3RpbmcgdGFncyB1c2luZyBhIG5hbWUgYXMgcGF0dGVybiBtdXN0IHByaW50IHRo
YXQgb25lIG1hdGNoaW5nJyAnCiAJZ2l0LXRhZyAtbCBhMSA+IGFjdHVhbCAmJgogCWdpdCBkaWZm
IGV4cGVjdCBhY3R1YWwKICcKIAogY2F0ID5leHBlY3QgPDxFT0YKIHYxLjAKLXYxLjAuMQogRU9G
CiB0ZXN0X2V4cGVjdF9zdWNjZXNzIFwKLQknbGlzdGluZyB0YWdzIHVzaW5nIGEgbmFtZSBhcyBw
YXR0ZXJuIG11c3QgcHJpbnQgdGhvc2UgbWF0Y2hpbmcnICcKKwknbGlzdGluZyB0YWdzIHVzaW5n
IGEgbmFtZSBhcyBwYXR0ZXJuIG11c3QgcHJpbnQgdGhhdCBvbmUgbWF0Y2hpbmcnICcKIAlnaXQt
dGFnIC1sIHYxLjAgPiBhY3R1YWwgJiYKIAlnaXQgZGlmZiBleHBlY3QgYWN0dWFsCiAnCiAKIGNh
dCA+ZXhwZWN0IDw8RU9GCit2MS4wLjEKIHYxLjEuMwogRU9GCiB0ZXN0X2V4cGVjdF9zdWNjZXNz
IFwKIAknbGlzdGluZyB0YWdzIHdpdGggPyBpbiB0aGUgcGF0dGVybiBzaG91bGQgcHJpbnQgdGhv
c2UgbWF0Y2hpbmcnICcKLQlnaXQtdGFnIC1sICIxLjE/IiA+IGFjdHVhbCAmJgorCWdpdC10YWcg
LWwgInYxLj8uPyIgPiBhY3R1YWwgJiYKIAlnaXQgZGlmZiBleHBlY3QgYWN0dWFsCiAnCiAKLS0g
CjEuNS4wCgo=
------=_Part_3173_28395643.1188657990336--
