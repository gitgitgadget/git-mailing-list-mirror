From: "Lars Hjemli" <lh@elementstorage.no>
Subject: [PATCH] git-submodule: re-enable 'status' as the default subcommand
Date: Fri, 17 Aug 2007 09:25:04 +0200
Message-ID: <8c5c35580708170025g70db9f3eu664551400e9430d4@mail.gmail.com>
References: <11862375532593-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 09:25:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILwCm-0003K6-RZ
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 09:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756174AbXHQHZI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 03:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753474AbXHQHZH
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 03:25:07 -0400
Received: from rv-out-0910.google.com ([209.85.198.189]:5523 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755225AbXHQHZF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 03:25:05 -0400
Received: by rv-out-0910.google.com with SMTP id k20so407268rvb
        for <git@vger.kernel.org>; Fri, 17 Aug 2007 00:25:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=HeVAMbm1OwI7boQNlvWqOkl3Ev7EC8UW9ueNgB5CDDnl6lD+7359jxn2SYjEQ6t/NAaob6GmOfNt8GsgkCpsQ0P/yK2vFcZAgaElf8j59TR7XXAhS9n6/m9sP7Vtonn+mbDYIYXPuPu0fZ7Z5r9qL1pcRbbiAot/Q2LzGqJGwK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=UDDczBLvsbxC1pcTR64wFoV6ODEzqlLkXouvRL+6KfE4MNrANCK4yJO2dxj0Q7zR+CN30v1y4W5i25uWBTGCNRJse5wQ20vX73/E0kXS8TtcQ5sQ+Z1SyiXZ/DcsWqqnfDKUuovFoP5aQdevYYPjFC5drVjyxw3k7h3x8CEV9mU=
Received: by 10.114.59.1 with SMTP id h1mr588231waa.1187335504989;
        Fri, 17 Aug 2007 00:25:04 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Fri, 17 Aug 2007 00:25:04 -0700 (PDT)
In-Reply-To: <11862375532593-git-send-email-hjemli@gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 6de6ce8c64052715
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56048>

Hi

I got no response on this patch, was it simply overlooked? I really think

$ git submodule

should show the available submodules and their status.

--
larsh
