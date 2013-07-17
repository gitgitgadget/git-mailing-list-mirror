From: Doug Bell <madcityzen@gmail.com>
Subject: [PATCH v3] show-ref: make --head always show the HEAD ref
Date: Tue, 16 Jul 2013 19:05:13 -0500
Message-ID: <1374019514-15309-1-git-send-email-madcityzen@gmail.com>
References: <7vtxjvbwyo.fsf@alter.siamese.dyndns.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 17 02:06:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzFG6-0002RN-EE
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 02:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933947Ab3GQAGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 20:06:14 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:52767 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933546Ab3GQAGN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 20:06:13 -0400
Received: by mail-oa0-f46.google.com with SMTP id h1so1676759oag.5
        for <git@vger.kernel.org>; Tue, 16 Jul 2013 17:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=VOda7/Csnlzv7G7cPoL9MKbXedWob93UGIMbXMM3ojU=;
        b=MO4VSW/bUw+vL16uaF+cYemrovA0fJ/ATE1CMMEpB8bbHZ8nNgBfCJeIGOo7GW/TIx
         iyJAQozxr/rfBravUDxlgE09dsbBpoF0jU8vdRsnf9YRgixg3+O1o8up4vMwkrDQyMJw
         WDJoO0RSDAk7FaUtBvhZYfReUJFcmTViwIZMRg0XNAFtFtNlUFfugix00pMl3D7W0aGC
         uwSzrsXsOI3A4BcJqaw3H+mMaHgeZpp516ouy8veQwmEyu5UoaD8WSf2rzWGphPixAAy
         4DPf7OqPU9fAnpvCkRLowKibMYRSZV0GDDau3hjBYMREGVWNzEhTg0biFC6Vu9DFMzMp
         YUwA==
X-Received: by 10.60.102.100 with SMTP id fn4mr5188986oeb.3.1374019573552;
        Tue, 16 Jul 2013 17:06:13 -0700 (PDT)
Received: from localhost.localdomain (c-67-162-112-255.hsd1.il.comcast.net. [67.162.112.255])
        by mx.google.com with ESMTPSA id b7sm3633983oby.5.2013.07.16.17.06.12
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 16 Jul 2013 17:06:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <7vtxjvbwyo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230597>


Added the test that Junio wrote, just need to take some more time to
understand it. Thanks for the tests!
