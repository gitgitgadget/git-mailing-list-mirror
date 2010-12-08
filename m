From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv3 4/6] web--browse: better support for chromium
Date: Wed, 8 Dec 2010 08:21:08 +0100
Message-ID: <AANLkTinhRUTy6pSiPZnkpj-pSA57VodFVCALfxe8UCH8@mail.gmail.com>
References: <1291657790-3719-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291657790-3719-5-git-send-email-giuseppe.bilotta@gmail.com> <7vy681m9w5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 08:29:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQESo-0002Sy-6w
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 08:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644Ab0LHH3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 02:29:16 -0500
Received: from mail-iw0-f172.google.com ([209.85.214.172]:51931 "EHLO
	mail-iw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320Ab0LHH3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 02:29:16 -0500
Received: by iwn40 with SMTP id 40so1175077iwn.3
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 23:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=U1k5sRj8STiPn5utofMV+Ym0mXRHpALJ2cVk/kQgk/c=;
        b=WDXJwXZO+dDjYGPaDc6pHZiTehubUafMajx47W1LlC30FktmyN6l/E7mG5lpdGoNd8
         qnmBnqMBD0K6OWQS9DW9rx1qyC86bcKEaxUKOCedSfslGVq+G8p4t4FEJUWA0Vw1jav0
         OGqtrVksTUC2Fr2e5lz2o+tgshsQZvDe599Gg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=lUB0YwrZJSK8pVUcla3JkNaSaJIisbEUEoaJq/BhOLVm/SCfRiPbhCDVh70v9Js2dv
         pj4Nh1bdn8RMZzKs2zeMZfR45KJW1AV8XXRJjqfXh1zQ+S4ged9vEUSoH0BndBDEEnjU
         TTHmPuaXZiSDknFLabtz8AiDqBz7e7IdvYlSY=
Received: by 10.231.19.139 with SMTP id a11mr8782106ibb.81.1291792888742; Tue,
 07 Dec 2010 23:21:28 -0800 (PST)
Received: by 10.231.39.3 with HTTP; Tue, 7 Dec 2010 23:21:08 -0800 (PST)
In-Reply-To: <7vy681m9w5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163172>

On Wed, Dec 8, 2010 at 12:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Up to this point of the series, I think v3 is a regression compared to
> what is queued on 'pu'.

Ouch. Including or excluding this one? (Unless I did a mistake, the
only difference here was the merging of the conditionals when
path-checking chromium)

-- 
Giuseppe "Oblomov" Bilotta
