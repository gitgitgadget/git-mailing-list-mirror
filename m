From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv2 0/2] fixes to gitweb feature check code
Date: Sat, 29 Nov 2008 12:13:26 +0100
Message-ID: <cb7bb73a0811290313v735ba182hc13a9ae6f39b7e27@mail.gmail.com>
References: <1227904793-1821-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200811291148.15182.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 29 12:15:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6NnJ-0007JY-J6
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 12:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbYK2LN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 06:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbYK2LN3
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 06:13:29 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:51655 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbYK2LN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 06:13:28 -0500
Received: by nf-out-0910.google.com with SMTP id d3so931280nfc.21
        for <git@vger.kernel.org>; Sat, 29 Nov 2008 03:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=9kmy0iQSeWqOib8YpPQJRAVmuA74rFFtZFbIVHEVpv4=;
        b=U3vihXPWcpiFc9SfLp6Is0UOWxLOu7b4YVc+H7dvvjpOsWBjd0w/CB7d3oik68h2M9
         C3WfWEzQq5IDO0s+iiuPhFcqoGBhtKuX6FY3HciYSSOuyStL34a5cL7mLTrBi2YW2cry
         Xk+NW7Ece0cLt2UbtxXX2wnoN1WlyZJ80GMNI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Wrpebjp7RQPt82eC8VJpRl/RzO7yLA+lvD9/tJuf+5krplIbQiX6fCXSO2oX1key9z
         ON4UE+7EKTFq6vfgLiNhzN4FcHEP5b5Ac9gGp402V3eORhKSM3si6SlNt6a+KNh/t5d0
         ariRtqFdeiFtAYGVf86ipVQ5fsSRyEjJImLMI=
Received: by 10.210.36.8 with SMTP id j8mr10019199ebj.155.1227957206603;
        Sat, 29 Nov 2008 03:13:26 -0800 (PST)
Received: by 10.210.79.12 with HTTP; Sat, 29 Nov 2008 03:13:26 -0800 (PST)
In-Reply-To: <200811291148.15182.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101904>

MjAwOC8xMS8yOSBKYWt1YiBOYXJlYnNraSA8am5hcmViQGdtYWlsLmNvbT46Cj4gRG5pYSBwabF0
ZWsgMjguIGxpc3RvcGFkYSAyMDA4IDIxOjM5LCBHaXVzZXBwZSBCaWxvdHRhIG5hcGlzYbM6Cgo+
PiBUaGUgZmlyc3QgcGF0Y2ggaW50cm9kdWNlcyBnaXRfZ2V0X2ZlYXR1cmUoKSB0byBjbGVhcmx5
IGRpc3Rpbmd1aXNoIHRoZQo+PiBmZWF0dXJlIHJldHJpZXZhbCBmcm9tIHRoZSBib29sZWFuIGZl
YXR1cmUgY2hlY2sgKHdoaWNoIGlzIGtlcHQgYXQKPj4gZ2l0X2NoZWNrX2ZlYXR1cmUoKSkuIFRo
ZSBuZXcgZnVuY3Rpb24gaXMgdXNlZCB3aGVyZSBhcHByb3ByaWF0ZS4KCj4gSXQgaXMgZ2l0d2Vi
X2dldF9mZWF0dXJlKCkgKGZvciByZXRyaWV2YWwpIGFuZCBnaXR3ZWJfY2hlY2tfZmVhdHVyZSgp
Cj4gKGZvciBjaGVja2luZyksIG5vdCBnaXRfZ2V0X2ZlYXR1cmUoKSBhbmQgZ2l0X2NoZWNrX2Zl
YXR1cmUoKS4KCkFoZW0uIFJpZ2h0LiBJJ2xsIHJlc2VuZCB0aGUgc2Vjb25kIHBhdGNoIHdpdGgg
YSBmaXhlZCBzdWJqZWN0IGFuZApjb21taXQgbWVzc2FnZSA4LVAKCi0tIApHaXVzZXBwZSAiT2Js
b21vdiIgQmlsb3R0YQo=
