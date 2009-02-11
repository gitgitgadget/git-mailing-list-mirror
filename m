From: Robin Rosenberg <robin.rosenberg@gmail.com>
Subject: Re: [EGIT PATCH v2 08/12] Add icon decoration for tracked and untracked resources
Date: Wed, 11 Feb 2009 23:16:28 +0100
Message-ID: <200902112316.28646.robin.rosenberg@gmail.com>
References: <1234377614-23798-1-git-send-email-torarnv@gmail.com> <1234377614-23798-8-git-send-email-torarnv@gmail.com> <1234377614-23798-9-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Tor Arne =?utf-8?q?Vestb=C3=B8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 23:18:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXNPD-0006dM-S2
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 23:18:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756069AbZBKWQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 17:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754219AbZBKWQk
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 17:16:40 -0500
Received: from ti-out-0910.google.com ([209.85.142.188]:51308 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756032AbZBKWQj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 17:16:39 -0500
Received: by ti-out-0910.google.com with SMTP id d10so210329tib.23
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 14:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=NS3RpxRGfZlNZwcCuScwVTEDPZl7dvXyWtDjnu5LXHs=;
        b=RlgEcpZZeGgrKqqiijX1gxBJrQTphcDRpT/3pZaVdiDepMvgw5kab8L9l0E6mm363h
         zwGpllteDc3F4gmqZu0RsfxPhJenmo88+2o+aBajY/qyroIxDNOwMte98ZFt9fAGgutx
         P1jcAM5PLUiLRSMW62BliNaQ+2MOajlGNV2pw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=utBdR0rDvvOhYye3AZrrMuQdD7A8pDdxSAeKmKOpTEifI9i6cMMI0SScBrLd0bNYXT
         4MUtxSH+byke5laOIO69MINzr/nqSYr/9K1x451G+KKhByRyF/mNfcIWQUV7CDje7tH2
         npNI6iL2DRBRNNjnzSzp6wcGY8xer1cGp8cfU=
Received: by 10.110.8.5 with SMTP id 5mr127171tih.59.1234390596652;
        Wed, 11 Feb 2009 14:16:36 -0800 (PST)
Received: from sleipner.localnet (h59n1fls34o811.telia.com [213.67.102.59])
        by mx.google.com with ESMTPS id w12sm2050772tib.0.2009.02.11.14.16.32
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Feb 2009 14:16:35 -0800 (PST)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <1234377614-23798-9-git-send-email-torarnv@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109537>


This one fails to compile, 

Description	Resource	Path	Location	Type
fPreview cannot be resolved	GitDecoratorPreferencePage.java	org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences	line 279	Java Problem

With patch 9 things build again, but swapping the patches does not help.

Every patch should build and pass unit tests so we can perform bisect over the patches.

-- robin
