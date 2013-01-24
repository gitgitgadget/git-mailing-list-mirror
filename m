From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH] send-email: Honor multi-part email messages
Date: Thu, 24 Jan 2013 14:38:16 +0400
Message-ID: <20130124143816.7c33fc1c@ashu.dyn1.rarus.ru>
References: <1316507347-6693-1-git-send-email-zapped@mail.ru> <7v1uvb6mn9.fsf@alter.siamese.dyndns.org> <20110921001925.03a83d3a@zappedws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 11:44:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyKI1-0003LB-6r
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 11:44:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934Ab3AXKnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 05:43:52 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:57314 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270Ab3AXKnv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 05:43:51 -0500
Received: by mail-lb0-f177.google.com with SMTP id go11so2929122lbb.8
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 02:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:in-reply-to
         :references:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=oCaTwUO61EKoGZY2Ahq+ObW1AgVGpkSQEBlkDouqgwk=;
        b=UwGyTt1FZ67WJGwFV0vemSzNnrqzRcGag7HAw6pN6o5lT9mlf8cCI5BzdmaQ7GkgT9
         c0SXhHk/JzGs3fu4vGAoNyG4B1aiqusLdKYGGTjnodNcGp7UlQLSiUmFXBwklMZvxL/i
         t47aSQ9HSXtlYWyzkmrGoZ1DwURlajl0kBPQJ+Dvp76ZiIeXf02cWL0O6yunbiXiajUp
         FRVQ72pn8xTLCvIqqlkVZnwIkpAPhG6gZYhNwJX0etn82Li/OuWsPJkbRzjGBVuH8/+6
         pCKJxG683k2P8J+um7gcwA5ur9mQIWyc0x++tpkwNFBgQoyIzGsG0JT9Z14yH02Uhhpa
         Bong==
X-Received: by 10.152.134.243 with SMTP id pn19mr1394972lab.11.1359023899232;
        Thu, 24 Jan 2013 02:38:19 -0800 (PST)
Received: from ashu.dyn1.rarus.ru ([85.21.218.130])
        by mx.google.com with ESMTPS id ew10sm9428005lbb.10.2013.01.24.02.38.18
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 24 Jan 2013 02:38:18 -0800 (PST)
In-Reply-To: <20110921001925.03a83d3a@zappedws>
X-Mailer: Claws Mail 3.9.0 (GTK+ 2.24.13; x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214426>

Bump
