From: "Praveen A" <pravi.a@gmail.com>
Subject: gitweb and unicode special characters
Date: Fri, 12 Dec 2008 10:33:03 -0800
Message-ID: <3f2beab60812121033r5d41894t77acc271b7c6955c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Santhosh Thottingal" <santhosh00@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 12 19:34:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBCqI-0005Id-LJ
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 19:34:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758411AbYLLSdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 13:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758384AbYLLSdI
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 13:33:08 -0500
Received: from mail-gx0-f12.google.com ([209.85.217.12]:63390 "EHLO
	mail-gx0-f12.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758033AbYLLSdH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 13:33:07 -0500
Received: by gxk5 with SMTP id 5so1045561gxk.13
        for <git@vger.kernel.org>; Fri, 12 Dec 2008 10:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=cYxFgIL5LSAynheZ6ke1MxXz6wgv/awolePq7Q7liyY=;
        b=grwbLn7ejblovdvPIBOZ5C74OQniIE/OFtv2QmDtDhOEar5PDtA7HrzVPv0PF/PKRr
         JXLjYvOpE6CyzcowjYl6wU1Uy4rAhidoym+bfw8ziET9j4seqjDFowNIf5yUn3TyHc+v
         gLT0TONxTUOqysUhf0MWXPX4aD0Y2zJYYLg1M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=gWYV8zrvLIDSfbvbl9gkSmhmx8r/goco+MC6zdcq+LYDVq8lSb4TWP7Om4kyEuctdd
         SR6dJLqmkJYzOVjdN6LlteCH8pbveEYvlYFXPBtBr8VZzqgntT8LV5ZoTE23eA1lysp0
         NyP0/cNqrDYQra4hWQX053iCG4iJB9Z3N+2Nc=
Received: by 10.90.83.2 with SMTP id g2mr2426765agb.79.1229106783754;
        Fri, 12 Dec 2008 10:33:03 -0800 (PST)
Received: by 10.90.56.1 with HTTP; Fri, 12 Dec 2008 10:33:03 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102924>

SGksCgpHaXQgY3VycmVudGx5IGRvZXMgbm90IGhhbmRsZSB1bmljb2RlIHNwZWNpYWwgY2hhcmFj
dGVycyBaV0ogYW5kIFpXTkosCmJvdGggYXJlIGhlYXZpbHkgdXNlZCBpbiBNYWxheWFsYW0gYW5k
IGNvbW1vbiBpbiBvdGhlciBsYW5ndWFnZXMKbmVlZGluZyBjb21wbGV4IHRleHQgbGF5b3V0IGxp
a2UgU2luaGFsYSBhbmQgQXJhYmljLgoKQW4gZXhhbXBsZSBvZiB0aGlzIGlzIHNob3duIGluIHRo
ZSBjb21taXQgbWVzc2FnZSBoZXJlCmh0dHA6Ly9naXQuc2F2YW5uYWguZ251Lm9yZy9naXR3ZWIv
P3A9c21jLmdpdDthPWNvbW1pdDtoPWMzZjM2OGM2MGFhYmRjMzgwYzc3NjA4YzYxNGQ5MWIwYTYy
ODU5MGEKClwyMDAxNCBhbmQgXDIwMDE1IHNob3VsZCBoYXZlIGJlZW4gWldOSiBhbmQgWldKIHJl
c3BlY3RpdmVseS4gWW91IGp1c3QKbmVlZCB0byBoYW5kbGUgdGhlbSBhcyBhbnkgb3RoZXIgdW5p
Y29kZSBjaGFyYWN0ZXIgLSBlc3BlY2lhbGx5IGl0IGlzCmEgY29tbWl0IG1lc3NhZ2UgYW5kIGV4
cGVjdGF0aW9uIGlzIG5vcm1hbCBwYWluIHRleHQgZGlzcGxheS4KCkkgaG9wZSBzb21lIG9uZSB3
aWxsIGZpeCB0aGlzLgoKLSBQcmF2ZWVuCi0tIArgtKrgtY3gtLDgtLXgtYDgtKPgtY3igI0g4LSF
4LSw4LS/4LSu4LWN4LSq4LWN4LSw4LSk4LWN4LSk4LWK4LSf4LS/4LSv4LS/4LSy4LWN4oCNCjxH
UEx2Mj4gSSBrbm93IG15IHJpZ2h0czsgSSB3YW50IG15IHBob25lIGNhbGwhCjxEUk0+IFdoYXQg
dXNlIGlzIGEgcGhvbmUgY2FsbCwgaWYgeW91IGFyZSB1bmFibGUgdG8gc3BlYWs/CihhcyBzZWVu
IG9uIC8uKQpKb2luIFRoZSBEUk0gRWxpbWluYXRpb24gQ3JldyBOb3chCmh0dHA6Ly9mY2kud2lr
aWEuY29tL3dpa2kvQW50aS1EUk0tQ2FtcGFpZ24K
