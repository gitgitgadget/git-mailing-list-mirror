From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH] Implement a new patch identification scheme and id command
Date: Sat, 14 Jun 2008 08:32:29 +0100
Message-ID: <b0943d9e0806140032p53a02352h5de1b8aa3a37e07f@mail.gmail.com>
References: <20080614072833.7899.91460.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 14 09:33:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7QGM-0000rI-2G
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 09:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415AbYFNHcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 03:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752843AbYFNHcc
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 03:32:32 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:46421 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbYFNHcb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 03:32:31 -0400
Received: by wa-out-1112.google.com with SMTP id j37so3577287waf.23
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 00:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=N2YY9bfMO1k3jMTf7aHGpjPPwN3X7aepvUAe0VVMjts=;
        b=stZvPuGSTzlmxRd3pHwse4yM/oesfMu1rON4PCYxrJc735WUKC9yDWF7RO/6wYlGTl
         MnSesHhhcAHM1xxOyQCUPsZ3xvC/5VkpxFmQ7tnFmOr5B7oYiq3wewCE1ROv3KtQy/nh
         D0jsoSathar3F0WSIhWIq/ZvCPhCZV9N1Czyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=YYIIyIfuT58md3HddCZ6DCT1ytZctmmTDFHulTVZ0tqWUA/vuJUIe3J6S8SlhgtmL4
         Ak65PfK5R/vlUxTbAbS/mE1KkfCo5GufPhb9RzwaBntjHbe2yDiU3CHw8t8t2I0HSbT2
         Mzn/+XgzId/jaFPBhIy3zMhRbnTA5CTt/9eoQ=
Received: by 10.115.76.5 with SMTP id d5mr4112829wal.191.1213428750675;
        Sat, 14 Jun 2008 00:32:30 -0700 (PDT)
Received: by 10.114.171.16 with HTTP; Sat, 14 Jun 2008 00:32:29 -0700 (PDT)
In-Reply-To: <20080614072833.7899.91460.stgit@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84987>

MjAwOC82LzE0IENhdGFsaW4gTWFyaW5hcyA8Y2F0YWxpbi5tYXJpbmFzQGdtYWlsLmNvbT46Cj4g
LS0tIGEvdC90MDAwMS1zdWJkaXItYnJhbmNoZXMuc2gKPiArKysgYi90L3QwMDAxLXN1YmRpci1i
cmFuY2hlcy5zaAo+IEBAIC0xLDYgKzEsNiBAQAo+ICAjIS9iaW4vc2gKPiAgIwo+IC0jIENvcHly
aWdodCAoYykgMjAwNiBLYXJsIEhhc3NlbHN0csO2bQo+ICsjIENvcHlyaWdodCAoYykgMjAwNiBL
YXJsIEhhc3NlbHN0cu+/vW0KCkknbGwgcmVtb3ZlIHRoaXMgaHVuayA6LSkgKG5vdCBzdXJlIGhv
dyBpdCBnb3QgaGVyZSkuCgotLSAKQ2F0YWxpbgo=
