From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/14] Sparse checkout
Date: Sat, 20 Sep 2008 19:07:01 +0700
Message-ID: <fcaeb9bf0809200507j61f42369o4a22a02f58733ae1@mail.gmail.com>
References: <1221904913-25887-1-git-send-email-pclouds@gmail.com>
	 <adf1fd3d0809200348h1170e8cm302e92043da8995d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "=?UTF-8?Q?Santi_B=C3=A9jar?=" <santi@agolina.net>
X-From: git-owner@vger.kernel.org Sat Sep 20 14:08:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kh1G2-0007SP-QM
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 14:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbYITMHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2008 08:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbYITMHE
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 08:07:04 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:20412 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbYITMHD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 08:07:03 -0400
Received: by fg-out-1718.google.com with SMTP id 19so831857fgg.17
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 05:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Uo0UceJcEi2Py2nPmDwY5RybxTvuONS2kcl7kSb0bX0=;
        b=pguAMILFPbQiNldZ/cXhdK4fo4p0S4lhaNSpf9xBw41qIQxcLjUrjciEkZ3miIst/2
         rTDX05eDgD/r7tGsF1M6uVAApOeSoCMaERALbxnuhoRg4EB+U+ny0uCdE7+cLo6hIVbt
         awQ3nzPa1xursb3BQUOfsHi/LLnIIo/X2epZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=eSB3NlTgIFMLCAwNw8ftT6Pqo3MvxUSReibZqHTB+EONL4fCZux8nncllw5HVIBJMj
         qIZWMgdnYMdq4R6PaoRRRNw3NSfoFMTKIlQEQTmK5JQmjfP5hCld5KJcE6s8qfEied0K
         RUg/YP7jl0R5cSE1J09RM/RLAsGscdnf23nqE=
Received: by 10.86.92.7 with SMTP id p7mr3007610fgb.8.1221912421074;
        Sat, 20 Sep 2008 05:07:01 -0700 (PDT)
Received: by 10.86.59.5 with HTTP; Sat, 20 Sep 2008 05:07:01 -0700 (PDT)
In-Reply-To: <adf1fd3d0809200348h1170e8cm302e92043da8995d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96355>

T24gOS8yMC8wOCwgU2FudGkgQsOpamFyIDxzYW50aUBhZ29saW5hLm5ldD4gd3JvdGU6Cj4gT24g
U2F0LCBTZXAgMjAsIDIwMDggYXQgMTI6MDEgUE0sIE5ndXnhu4VuIFRow6FpIE5n4buNYyBEdXkK
PiAgPHBjbG91ZHNAZ21haWwuY29tPiB3cm90ZToKPiAgPgo+ICA+IE5ndXnhu4VuIFRow6FpIE5n
4buNYyBEdXkgKDE0KToKPiAgPiAgRXh0ZW5kIGluZGV4IHRvIHNhdmUgbW9yZSBmbGFncwo+ICA+
ICBJbnRyb2R1Y2UgQ0VfTk9fQ0hFQ0tPVVQgYml0Cj4gID4gIGxzLWZpbGVzOiBhZGQgb3B0aW9u
cyB0byBzdXBwb3J0IHNwYXJzZSBjaGVja291dAo+ICA+ICB1cGRhdGUtaW5kZXg6IHJlZmFjdG9y
IG1hcmtfdmFsaWQoKSBpbiBwcmVwYXJhdGlvbiBmb3IgbmV3IG9wdGlvbnMKPiAgPiAgdXBkYXRl
LWluZGV4OiBhZGQgLS1jaGVja291dC8tLW5vLWNoZWNrb3V0IHRvIHVwZGF0ZSBDRV9OT19DSEVD
S09VVCBiaXQKPiAgPiAgbHMtZmlsZXM6IEFkZCB0ZXN0cyBmb3IgLS1zcGFyc2UgYW5kIGZyaWVu
ZHMKPiAgPiAgUHJldmVudCBkaWZmIG1hY2hpbmVyeSBmcm9tIGV4YW1pbmluZyB3b3JrdHJlZSBv
dXRzaWRlIHNwYXJzZSBjaGVja291dAo+ICA+ICBjaGVja291dF9lbnRyeSgpOiBDRV9OT19DSEVD
S09VVCBvbiBjaGVja2VkIG91dCBlbnRyaWVzLgo+ICA+ICBncmVwOiBza2lwIGZpbGVzIG91dHNp
ZGUgc3BhcnNlIGNoZWNrb3V0IGFyZWEKPiAgPiAgbHMtZmlsZXM6IHN1cHBvcnQgInNwYXJzZSBw
YXR0ZXJucyIsIHVzZWQgdG8gZm9ybSBzcGFyc2UgY2hlY2tvdXQgYXJlYXMKPiAgPiAgdW5wYWNr
X3RyZWVzKCk6IGFkZCBzdXBwb3J0IGZvciBzcGFyc2UgY2hlY2tvdXQKPiAgPiAgY2xvbmU6IHN1
cHBvcnQgc3BhcnNlIGNoZWNrb3V0IHdpdGggLS1uYXJyb3ctcGF0aCBvcHRpb24KPiAgPiAgY2hl
Y2tvdXQ6IGFkZCBuZXcgb3B0aW9ucyB0byBzdXBwb3J0IHNwYXJzZSBjaGVja291dAo+ICA+ICB3
dC1zdGF0dXM6IFNob3cgb3JwaGFuZWQgZW50cmllcyBpbiAiZ2l0IHN0YXR1cyIgb3V0cHV0Cj4g
ID4KPgo+Cj4gSSB3b3VsZCBsaWtlIHRvIHRlc3QgaXQsIGRvIHlvdSBoYXZlIGEgcHVibGljIHJl
cG8gdG8gZmV0Y2ggaXQ/CgpnaXQ6Ly9yZXBvLm9yLmN6L2dpdC9wY2xvdWRzLmdpdCBicmFuY2gg
c3BhcnNlLWNoZWNrb3V0LgotLSAKRHV5Cg==
