From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: the meaning of keephardlinks
Date: Tue, 13 Jan 2009 10:47:53 +1030
Message-ID: <93c3eada0901121617m43af82a7te946b1607fbf3f77@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 01:19:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMX02-0008Vr-VX
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 01:19:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbZAMARz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 19:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbZAMARz
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 19:17:55 -0500
Received: from rv-out-0506.google.com ([209.85.198.230]:30102 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559AbZAMARy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 19:17:54 -0500
Received: by rv-out-0506.google.com with SMTP id k40so10459597rvb.1
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 16:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=qLzbhWcOfJqJQRj+JWBS1lKWoGNCn36pm9Qf6u/qyS8=;
        b=VVYahkRmpzxC231mih9F8TL7yDlMGuAVTGT1YCSpcM5x48EZZW/BvqkrWASUJDLsLm
         3vVr+MYKBWK3dL7llBCEsXicpWHIAmsheT3lsiQ6W3VH+tzY856lDdJgqMI39peDImyM
         x2ZOnPtooDp4//nX9lD2zeK+vISuTlMI+IBiE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=bV5lrqJ21AQoL9Sn9INENM1qvt372Gm2AeY3ryxJrbjxVGr2XMDxaqbN8TW4qfZOHS
         Dyq/kD4SkO9Y9TDBK14fkvqXpRWxyn8m4Y1JPdiWm9x2xIGYvh2ec082YyEOzv1vB0ho
         YqHCuNS/Ytquvz9lu4n9kSDTDIXvNsjISQSwY=
Received: by 10.141.201.1 with SMTP id d1mr14943674rvq.293.1231805873824;
        Mon, 12 Jan 2009 16:17:53 -0800 (PST)
Received: by 10.140.136.16 with HTTP; Mon, 12 Jan 2009 16:17:53 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105423>

I'm curious about what keephardlinks means.

If I do: "ln X Y ; git add Y ; git commit" in my origin and then
"git pull" in my cloned repository,
should I get a hard linked file in the clone
when core.keephardlinks is set to true?

Cheers,
Geoff Russell
