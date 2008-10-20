From: "Harvey Harrison" <harvey.harrison@gmail.com>
Subject: Re: [PATCH] fix for "index-pack: rationalize delta resolution code"
Date: Mon, 20 Oct 2008 12:07:54 -0700
Message-ID: <590657100810201207s9a5f4f5j8572f570928e97c8@mail.gmail.com>
References: <alpine.LFD.2.00.0810201357340.26244@xanadu.home>
	 <590657100810201137m477b834cr9c940851b1a599d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Jeff King" <peff@peff.net>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Oct 20 23:49:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks07o-00081U-J1
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 21:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180AbYJTTH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 15:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753059AbYJTTH4
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 15:07:56 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:42962 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126AbYJTTHz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 15:07:55 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1006748wah.21
        for <git@vger.kernel.org>; Mon, 20 Oct 2008 12:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=sDwCglYVAKEQRW17yXLoxkz3d7YvzB6318g1a2qJo/s=;
        b=D/BTNp1ITuxpwCyHZ6cZsr1x+WZH+Sb2QrlKTPs4MoI+NWnOEM73wNbB/t7RDVG+IQ
         I1pucOu7MfkpmIz3Wc27jNVyILohNg+PkJnBLgr9eWfZMyE9peBlN1Gx5NkYdJaF1lAZ
         UZRCT09/jWmHAO0DMd/r8mWLqQ1TZ9MYrqT1A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=wb8St2yCnGnla8FukAnvwTOlqofVDK18h6sUUY9BtZZKJaddYnCOUYsSxUG0SISP2x
         pHfKFkTNtLTo7kdWCzfE9mSZJNABWnKOQ8ALNW3CQXp8r6dFSbJroDyBgs1pXJXtNklu
         x+7Gu39FylR+KVF0+qms7Do57ACub4Uf3YKus=
Received: by 10.114.181.1 with SMTP id d1mr5674205waf.185.1224529674600;
        Mon, 20 Oct 2008 12:07:54 -0700 (PDT)
Received: by 10.115.55.11 with HTTP; Mon, 20 Oct 2008 12:07:54 -0700 (PDT)
In-Reply-To: <590657100810201137m477b834cr9c940851b1a599d8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98717>

On Mon, Oct 20, 2008 at 11:37 AM, Harvey Harrison
<harvey.harrison@gmail.com> wrote:
> On Mon, Oct 20, 2008 at 11:12 AM, Nicolas Pitre <nico@cam.org> wrote:
>> My bad.  A small detail went through the crack: the real_type of
>> a delta object is the real_type of its base object.
>>
>> Without this, the created index will be wrong as the actual object SHA1
>> won't match the object.
>>
>> Signed-off-by: Nicolas Pitre <nico@cam.org>
>
> This fixes it for me, thanks for the quick fix.
>
> Tested-by: Harvey Harrison <harvey.harrison@gmail.com>
>

Scratch that, it's back to failing again on my next update.

Harvey
