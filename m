From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] shortlog: initialize nongit variable
Date: Tue, 25 Mar 2008 22:39:38 +0700
Message-ID: <fcaeb9bf0803250839p721e1870l8fbc8715b3c6e7cb@mail.gmail.com>
References: <1206456377-2735-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "=?UTF-8?Q?SZEDER_G=C3=A1bor?=" <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Mar 25 16:40:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeBGA-0007WP-4n
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 16:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755567AbYCYPjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 11:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755497AbYCYPjl
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 11:39:41 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:63934 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755632AbYCYPjk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 11:39:40 -0400
Received: by fg-out-1718.google.com with SMTP id l27so3542565fgb.17
        for <git@vger.kernel.org>; Tue, 25 Mar 2008 08:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=BGeHnQhxaD2NUjovRW4tQjW2xscDiOYj0Ffa5zrPCOE=;
        b=d8HsLKA24PejN988A8TvUhCIHyMPoR4QPYIBD6AMS9vgwuoSk7CAq1Or9aGocivGa1J7IIQ+kZ0wvK0sQ/3yvuKZUBLdtLM6S5EkhjWFZAQ77UBoKuo6mV6fmSNu0OFrtvKRp386eOVrKpyDVajevdhFixSg8Y+Ojn356IbF8fo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uWf/HYdVXsW+Ibie8DTBgAenlPY/t9PASrfU5jA2juI8fcyZBc4msHfEXPuNDY2U0OncR9zYVXzRUTOJJ894V1o+MxsHAjT2XddGaoTvpdcWKPoKYIeGQB3CEpWKbGeG3RrkAA0ScJu8yqg16Fcv/8dgrjVznebW8PPyRA/oUI0=
Received: by 10.86.66.19 with SMTP id o19mr5555105fga.46.1206459578877;
        Tue, 25 Mar 2008 08:39:38 -0700 (PDT)
Received: by 10.86.81.4 with HTTP; Tue, 25 Mar 2008 08:39:38 -0700 (PDT)
In-Reply-To: <1206456377-2735-1-git-send-email-szeder@ira.uka.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78193>

T24gVHVlLCBNYXIgMjUsIDIwMDggYXQgOTo0NiBQTSwgU1pFREVSIEfDoWJvciA8c3plZGVyQGly
YS51a2EuZGU+IHdyb3RlOgo+IHNldHVwX2dpdF9kaXJlY3RvcnlfZ2VudGx5KCkgb25seSBtb2Rp
ZmllcyB0aGUgdmFsdWUgb2YgdGhlIG5vbmdpdAo+ICB2YXJpYWJsZSBpZiB3ZSBhcmUgbm90IGlu
IGEgZ2l0IHJlcG9zaXRvcnksIHRoZXJlZm9yZSBub25naXQgaXMgbGVmdAo+ICB1bmluaXRpYWxp
emVkIGlmIHdlIGFyZSBpbiBhIGdpdCByZXBvc2l0b3J5LiAgVGhpcyBzb21ldGltZXMgYnJva2UK
PiAgc2hvcnRsb2cgd2hlbiBpdCB3YXMgbm90IGZlZCB3aXRoIGEgbG9nIG9uIGl0cyBzdGFuZGFy
ZCBpbnB1dC4KCmNtZF9oZWxwKCkgaGFzIHRoZSBzYW1lIHByb2JsZW0uIENhbiB5b3UgbWFrZSBh
IHNpbWlsYXIgcGF0Y2ggZm9yCmNtZF9oZWxwIGFzIHdlbGw/CgpUaGFua3MKLS0gCkR1eQo=
