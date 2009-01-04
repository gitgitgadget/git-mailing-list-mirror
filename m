From: "Arnaud Lacombe" <lacombar@gmail.com>
Subject: Re: git-rev-parse --symbolic-abbrev-name
Date: Sun, 4 Jan 2009 15:23:03 -0500
Message-ID: <1a69a9d80901041223r1f3d2956ne05996793bb23e97@mail.gmail.com>
References: <quack.20090101T1928.lthzliaqtdf@roar.cs.berkeley.edu>
	 <402731c90901012026j470f35ffj1eaa189a837054f3@mail.gmail.com>
	 <quack.20090103T1818.lth7i5bg6f7@roar.cs.berkeley.edu>
	 <20090104033839.GD21154@genesis.frugalware.org>
	 <quack.20090103T2026.lth3afzg0hx@roar.cs.berkeley.edu>
	 <7vzli73b1g.fsf@gitster.siamese.dyndns.org>
	 <quack.20090104T0434.lthfxjz1c8x_-_@roar.cs.berkeley.edu>
	 <7v63kuyibi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_113088_18898090.1231100583853"
Cc: "Karl Chen" <quarl@cs.berkeley.edu>,
	"Miklos Vajna" <vmiklos@frugalware.org>,
	"David Aguilar" <davvid@gmail.com>,
	"Git mailing list" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 04 21:24:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJZWT-0005nt-UT
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 21:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753637AbZADUXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 15:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752199AbZADUXJ
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 15:23:09 -0500
Received: from mail-gx0-f13.google.com ([209.85.217.13]:43828 "EHLO
	mail-gx0-f13.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbZADUXH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 15:23:07 -0500
Received: by gxk6 with SMTP id 6so5528994gxk.13
        for <git@vger.kernel.org>; Sun, 04 Jan 2009 12:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type:references;
        bh=piF4HrhekxGeBIh6Wwtd17Oi0OwuTEZlg9CiQmwFJE8=;
        b=ZEPnK+Qc9k5zurp+J+f1k7QTVI4n2osiaOIEKmS4AEICrYY5FMukgh+DBpBscV0ElR
         /Ycn+gV9IZXcqzYD9Vn5Phcs1RbrbJsKNakvP187sbx4jNJrXFJuf/dqDyp1FZne+OVB
         DF/QxXh7HDAafLm8wI2Vn+x43jpxktSf++nPE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:references;
        b=gXFIHQoBV0hugzKEg7R7MWnI8P7yIPYruYfIa/FpsTy+WIXYv0cWXzZV1tGSMEexHo
         OIj4fomM3fE/e+m3eTIBO3WNWXEaog6Mk54N6nSPtZy/sHna+r8w74FOTfu7VmhCKOpd
         EP9uKqrn3SAU0BuaypmuDw75E9/AbvTdr8qwY=
Received: by 10.150.182.16 with SMTP id e16mr1046448ybf.12.1231100583861;
        Sun, 04 Jan 2009 12:23:03 -0800 (PST)
Received: by 10.151.48.18 with HTTP; Sun, 4 Jan 2009 12:23:03 -0800 (PST)
In-Reply-To: <7v63kuyibi.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104539>

------=_Part_113088_18898090.1231100583853
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Sun, Jan 4, 2009 at 2:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karl Chen <quarl@cs.berkeley.edu> writes:
>
>> ... you really think "branchfoo" instead of
>> "refs/heads/branchfoo" is a narrow special case?
>
> Of course it is narrower.  There are namespaces other than "heads" under
> refs, and not everybody is interested in branches.
>
>> obviously all those people posting on blogs don't know about it :)
>
> Yes, and that won't be helped by any new option to the plumbing.
>
> The above two does not necessarily mean that it is useless to add a new
> option to help a narrow special case that is common, though.
>
You'll find hereafter two patches which implements this in
git-symbolic-ref and git-rev-parse. Feel free to choose the one you
find the best. If you choose to integrate one of these, tells me and
I'll do a proper documentation bits and patch submission.

Sample output:

~/git/% ./git-rev-parse --symbolic-short-name HEAD
master
~/git/% ./git-symbolic-ref -a HEAD
master
~/git/% git checkout v1.6.1
~/git/% ./git-rev-parse --symbolic-short-name HEAD
HEAD
~/git/% ./git-symbolic-ref -a HEAD
fatal: ref HEAD is not a symbolic ref
~/git/% ./git-symbolic-ref -qa HEAD
~/git/%

Thanks in advance,

 - Arnaud

ps: I choose --symbolic-short-name as the opposite of
--symbolic-full-name for consistency.
ps2: sorry for the bogus mime-type

------=_Part_113088_18898090.1231100583853
Content-Type: application/octet-stream;
 name=git-rev-parse_symbolic-short-name.diff
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fpk5fw0s0
Content-Disposition: attachment;
 filename=git-rev-parse_symbolic-short-name.diff

ZGlmZiAtLWdpdCBhL2J1aWx0aW4tcmV2LXBhcnNlLmMgYi9idWlsdGluLXJldi1wYXJzZS5jCmlu
ZGV4IDgxZDVhNmYuLjcwZjRhMzMgMTAwNjQ0Ci0tLSBhL2J1aWx0aW4tcmV2LXBhcnNlLmMKKysr
IGIvYnVpbHRpbi1yZXYtcGFyc2UuYwpAQCAtMjQsNiArMjQsNyBAQCBzdGF0aWMgaW50IHNob3df
dHlwZSA9IE5PUk1BTDsKIAogI2RlZmluZSBTSE9XX1NZTUJPTElDX0FTSVMgMQogI2RlZmluZSBT
SE9XX1NZTUJPTElDX0ZVTEwgMgorI2RlZmluZSBTSE9XX1NZTUJPTElDX1NIT1JUIDMKIHN0YXRp
YyBpbnQgc3ltYm9saWM7CiBzdGF0aWMgaW50IGFiYnJldjsKIHN0YXRpYyBpbnQgb3V0cHV0X3Nx
OwpAQCAtMTEwLDcgKzExMSwxMCBAQCBzdGF0aWMgdm9pZCBzaG93X3JldihpbnQgdHlwZSwgY29u
c3QgdW5zaWduZWQgY2hhciAqc2hhMSwgY29uc3QgY2hhciAqbmFtZSkKIAlkZWYgPSBOVUxMOwog
CiAJaWYgKHN5bWJvbGljICYmIG5hbWUpIHsKLQkJaWYgKHN5bWJvbGljID09IFNIT1dfU1lNQk9M
SUNfRlVMTCkgeworCQlzd2l0Y2ggKHN5bWJvbGljKSB7CisJCWNhc2UgU0hPV19TWU1CT0xJQ19G
VUxMOgorCQljYXNlIFNIT1dfU1lNQk9MSUNfU0hPUlQ6CisJCQl7CiAJCQl1bnNpZ25lZCBjaGFy
IGRpc2NhcmRbMjBdOwogCQkJY2hhciAqZnVsbDsKIApAQCAtMTI1LDEzICsxMjksMjAgQEAgc3Rh
dGljIHZvaWQgc2hvd19yZXYoaW50IHR5cGUsIGNvbnN0IHVuc2lnbmVkIGNoYXIgKnNoYTEsIGNv
bnN0IGNoYXIgKm5hbWUpCiAJCQkJICovCiAJCQkJYnJlYWs7CiAJCQljYXNlIDE6IC8qIGhhcHB5
ICovCisJCQkJaWYgKHN5bWJvbGljID09IFNIT1dfU1lNQk9MSUNfU0hPUlQpIHsKKwkJCQkJY2hh
ciAqcDsKKwkJCQkJcCA9IHN0cnJjaHIoZnVsbCwgKGludCknLycpOworCQkJCQlpZiAocCAhPSBO
VUxMKQorCQkJCQkJZnVsbCA9IHAgKyAxOworCQkJCX0KIAkJCQlzaG93X3dpdGhfdHlwZSh0eXBl
LCBmdWxsKTsKIAkJCQlicmVhazsKIAkJCWRlZmF1bHQ6IC8qIGFtYmlndW91cyAqLwogCQkJCWVy
cm9yKCJyZWZuYW1lICclcycgaXMgYW1iaWd1b3VzIiwgbmFtZSk7Ci0JCQkJYnJlYWs7CiAJCQl9
Ci0JCX0gZWxzZSB7CisJCQlicmVhazsKKwkJCX0KKwkJZGVmYXVsdDoKIAkJCXNob3dfd2l0aF90
eXBlKHR5cGUsIG5hbWUpOwogCQl9CiAJfQpAQCAtNTA2LDYgKzUxNywxMCBAQCBpbnQgY21kX3Jl
dl9wYXJzZShpbnQgYXJnYywgY29uc3QgY2hhciAqKmFyZ3YsIGNvbnN0IGNoYXIgKnByZWZpeCkK
IAkJCQlzeW1ib2xpYyA9IFNIT1dfU1lNQk9MSUNfRlVMTDsKIAkJCQljb250aW51ZTsKIAkJCX0K
KwkJCWlmICghc3RyY21wKGFyZywgIi0tc3ltYm9saWMtc2hvcnQtbmFtZSIpKSB7CisJCQkJc3lt
Ym9saWMgPSBTSE9XX1NZTUJPTElDX1NIT1JUOworCQkJCWNvbnRpbnVlOworCQkJfQogCQkJaWYg
KCFzdHJjbXAoYXJnLCAiLS1hbGwiKSkgewogCQkJCWZvcl9lYWNoX3JlZihzaG93X3JlZmVyZW5j
ZSwgTlVMTCk7CiAJCQkJY29udGludWU7Cg==
------=_Part_113088_18898090.1231100583853
Content-Type: application/octet-stream;
 name=git-symbolic-refs_abbrev-name.diff
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fpk5g9om1
Content-Disposition: attachment;
 filename=git-symbolic-refs_abbrev-name.diff

ZGlmZiAtLWdpdCBhL2J1aWx0aW4tc3ltYm9saWMtcmVmLmMgYi9idWlsdGluLXN5bWJvbGljLXJl
Zi5jCmluZGV4IGJmYzc4YmIuLmZmOWZmNDYgMTAwNjQ0Ci0tLSBhL2J1aWx0aW4tc3ltYm9saWMt
cmVmLmMKKysrIGIvYnVpbHRpbi1zeW1ib2xpYy1yZWYuYwpAQCAtOCw3ICs4LDcgQEAgc3RhdGlj
IGNvbnN0IGNoYXIgKiBjb25zdCBnaXRfc3ltYm9saWNfcmVmX3VzYWdlW10gPSB7CiAJTlVMTAog
fTsKIAotc3RhdGljIHZvaWQgY2hlY2tfc3ltcmVmKGNvbnN0IGNoYXIgKkhFQUQsIGludCBxdWll
dCkKK3N0YXRpYyB2b2lkIGNoZWNrX3N5bXJlZihjb25zdCBjaGFyICpIRUFELCBpbnQgcXVpZXQs
IGludCBhYmJyZXYpCiB7CiAJdW5zaWduZWQgY2hhciBzaGExWzIwXTsKIAlpbnQgZmxhZzsKQEAg
LTIyLDE1ICsyMiwyMSBAQCBzdGF0aWMgdm9pZCBjaGVja19zeW1yZWYoY29uc3QgY2hhciAqSEVB
RCwgaW50IHF1aWV0KQogCQllbHNlCiAJCQlleGl0KDEpOwogCX0KKwlpZiAoYWJicmV2KSB7CisJ
CWNoYXIgKnAgPSBzdHJyY2hyKHJlZnNfaGVhZHNfbWFzdGVyLCAoaW50KScvJyk7CisJCWlmIChw
ICE9IE5VTEwpCisJCQlyZWZzX2hlYWRzX21hc3RlciA9IHAgKyAxOworCX0KIAlwdXRzKHJlZnNf
aGVhZHNfbWFzdGVyKTsKIH0KIAogaW50IGNtZF9zeW1ib2xpY19yZWYoaW50IGFyZ2MsIGNvbnN0
IGNoYXIgKiphcmd2LCBjb25zdCBjaGFyICpwcmVmaXgpCiB7Ci0JaW50IHF1aWV0ID0gMDsKKwlp
bnQgYWJicmV2ID0gMCwgcXVpZXQgPSAwOwogCWNvbnN0IGNoYXIgKm1zZyA9IE5VTEw7CiAJc3Ry
dWN0IG9wdGlvbiBvcHRpb25zW10gPSB7CiAJCU9QVF9fUVVJRVQoJnF1aWV0KSwKKwkJT1BUX0JP
T0xFQU4oJ2EnLCBOVUxMLCAmYWJicmV2LCAic2hvdyBvbmx5IGJyYW5jaCBuYW1lIiksCiAJCU9Q
VF9TVFJJTkcoJ20nLCBOVUxMLCAmbXNnLCAicmVhc29uIiwgInJlYXNvbiBvZiB0aGUgdXBkYXRl
IiksCiAJCU9QVF9FTkQoKSwKIAl9OwpAQCAtNDEsNyArNDcsNyBAQCBpbnQgY21kX3N5bWJvbGlj
X3JlZihpbnQgYXJnYywgY29uc3QgY2hhciAqKmFyZ3YsIGNvbnN0IGNoYXIgKnByZWZpeCkKIAkJ
ZGllKCJSZWZ1c2luZyB0byBwZXJmb3JtIHVwZGF0ZSB3aXRoIGVtcHR5IG1lc3NhZ2UiKTsKIAlz
d2l0Y2ggKGFyZ2MpIHsKIAljYXNlIDE6Ci0JCWNoZWNrX3N5bXJlZihhcmd2WzBdLCBxdWlldCk7
CisJCWNoZWNrX3N5bXJlZihhcmd2WzBdLCBxdWlldCwgYWJicmV2KTsKIAkJYnJlYWs7CiAJY2Fz
ZSAyOgogCQljcmVhdGVfc3ltcmVmKGFyZ3ZbMF0sIGFyZ3ZbMV0sIG1zZyk7Cg==
------=_Part_113088_18898090.1231100583853--
