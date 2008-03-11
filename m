From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 04/10] Make setup_work_tree() return new prefix
Date: Tue, 11 Mar 2008 22:18:03 +0700
Message-ID: <fcaeb9bf0803110818t6c009b29k5afb4f8b3833d475@mail.gmail.com>
References: <cover.1204453703.git.pclouds@gmail.com>
	 <20080302103405.GA8942@laptop>
	 <alpine.LSU.1.00.0803111426521.3873@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 11 16:19:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ6Fi-0006Kq-Jd
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 16:18:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753764AbYCKPSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 11:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753090AbYCKPSI
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 11:18:08 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:40494 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017AbYCKPSH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 11:18:07 -0400
Received: by fk-out-0910.google.com with SMTP id z23so2301719fkz.5
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 08:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4pjdnHqI2vbKxuylJE7dXr0ikicPg91SP+L62PIVgGk=;
        b=GwnY90X3UVujxqKX861CTjYHlZH+D2xw7NwoWLevcSaR3IDWgJEdXvycZdNNIaOjfsL+fATUmPVkhcW6GUu2iNf6aS9CmvDR6tX7OPk7DaIeZZ8s/cEgG6OY/2/GmwaJsczTujt1U1hJvYFnFBTWNSA4mTu4vGRWrt/+qSPA7fI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tiF5Cd/4u4V0tbHAXULlhwFbAsBfSfBqH+RYM1kcjmwDFEy03RIevGAHk5GnwbzndyiQWYfJeYag7DQP/oU7onxaexEBVjkB4dBT6tU6Xxla0ixvbv7GDmjkDFIoUDX4mAVJAKjgiqfeuBYnfaprp08fMVQkAeqhNTblW9IIcoE=
Received: by 10.82.113.6 with SMTP id l6mr16703274buc.20.1205248683911;
        Tue, 11 Mar 2008 08:18:03 -0700 (PDT)
Received: by 10.86.81.4 with HTTP; Tue, 11 Mar 2008 08:18:03 -0700 (PDT)
In-Reply-To: <alpine.LSU.1.00.0803111426521.3873@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76865>

T24gVHVlLCBNYXIgMTEsIDIwMDggYXQgODoyNyBQTSwgSm9oYW5uZXMgU2NoaW5kZWxpbgo8Sm9o
YW5uZXMuU2NoaW5kZWxpbkBnbXguZGU+IHdyb3RlOgo+IEhpLAo+Cj4KPiAgT24gU3VuLCAyIE1h
ciAyMDA4LCBOZ3V54buFbiBUaMOhaSBOZ+G7jWMgRHV5IHdyb3RlOgo+Cj4gID4gd29ya3RyZWUg
c2V0dXAgaW5zaWRlIHNldHVwX2dpdF9kaXJlY3RvcnkqKCkgaXMgbm90IHBlcmZlY3QuIEl0IGRv
ZXMgbm90Cj4gID4gdGFrZSBjb3JlLndvcmt0cmVlIGludG8gYWNjb3VudC4gU28gd2hlbiB5b3Ug
ZG8gc2V0dXBfd29ya190cmVlKCksIHRoZQo+ICA+IHJlYWwgd29yayB0cmVlIG1heSBiZSBub3Qg
dGhlIG9uZSBzZXR1cF9naXRfZGlyZWN0b3J5KigpIGdpdmVzIHlvdS4gWW91Cj4gID4gbmVlZCBh
IG5ldyBwcmVmaXggaW4gdGhhdCBjYXNlLgo+Cj4gIFByb2JhYmx5IHRoZSByZWFsIGZpeCB3b3Vs
ZCBiZSB0byBzZXR1cF9naXRfZGlyZWN0b3J5KCksIG5vPwoKc2V0dXBfd29ya190cmVlKCkgZG9l
cyB0aGUgam9iIGZpbmUuIFdoeSBkdXBsaWNhdGUgdGhlIGNvZGUgb25lIG1vcmU/CkluIHRoZSBv
bGQgZGF5cywgc2V0dXBfZ2l0X2RpcmVjdG9yeSgpIHdhcyBqdXN0IGEgc2ltcGxlIHdyYXBwZXIK
YXJvdW5kIHNldHVwX2dpdF9kaXJfZ2VudGx5KCkuIEkgd2FudGVkIHRvIG1vdmUgaXQgYmFjayB0
byB0aG9zZSBkYXlzLgpBbmQgc2V0dXBfZ2l0X2RpcmVjdG9yeSgpIGlzIGZpeGVkICBpbiAiQ29t
cGxldGVseSBtb3ZlIG91dCB3b3JrdHJlZQpzZXR1cCBmcm9tIHNldHVwX2dpdF9kaXJlY3Rvcnlf
Z2VudGx5KCkiIHNvIHNldHVwX2dpdF9kaXJlY3RvcnkoKSBkb2VzCmNvbnRhaW4gdGhlIHJlYWwg
Zml4IGluIHRoZSBlbmQuCgo+ICBDaWFvLAo+ICBEc2NobwotLSAKRHV5Cg==
