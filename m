From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH] git push: Interpret $GIT_DIR/branches in a Cogito compatible way
Date: Tue, 11 Nov 2008 08:45:41 +0000
Message-ID: <e2b179460811110045r4ef02285x3f31f0444980c20f@mail.gmail.com>
References: <1226353631-3716-1-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Martin Koegler" <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Tue Nov 11 09:46:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzotk-0005lK-9e
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 09:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbYKKIpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 03:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbYKKIpm
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 03:45:42 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:14912 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbYKKIpl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 03:45:41 -0500
Received: by qw-out-2122.google.com with SMTP id 3so1696532qwe.37
        for <git@vger.kernel.org>; Tue, 11 Nov 2008 00:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=hBZ/o7VR8u1WTNKNVCXBPabfNWrtrbEdZkm7lQnvEiw=;
        b=wlW/sCh2RPHyz7BYz6PFguOa6x2PFstEaDJs3EQGNiTzM7GaUoWw/WujLNNnQF6nMK
         82PxATpoP14AxomlF10SN4M72oWdC0v1Gfinef1OaCSeOzb0SRa6cjpYFneicA4STe+F
         TdJz/xtdprmj9MlT9yLpNWXCu2JqgrApqiKLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=t1TP8pL074QWYElue3EOYUXXtNAr4YpYh6A1xOmMbpX7Il1RUG9DibNKZL9TXIJXMh
         I12p5nCyYJECmbkXGYQRJaR8OIibzL0ubPJpEsu1yAJzwtTXWR7U3wmr6QMcOLjFJx50
         wIoxFn04GYifGjxSsMZc3zyVWTBKSLQ0kwddc=
Received: by 10.215.15.3 with SMTP id s3mr7882700qai.333.1226393141060;
        Tue, 11 Nov 2008 00:45:41 -0800 (PST)
Received: by 10.215.41.11 with HTTP; Tue, 11 Nov 2008 00:45:41 -0800 (PST)
In-Reply-To: <1226353631-3716-1-git-send-email-mkoegler@auto.tuwien.ac.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100631>

2008/11/10 Martin Koegler <mkoegler@auto.tuwien.ac.at>:
> +Depending on the operation, git will use one of the following
> +refsprecs, if you don't provide one on the command line.

s/refsprecs,/refspecs/
