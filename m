From: David Turner <dturner@twopensource.com>
Subject: [PATCH v11 0/3] cat-file --follow-symlinks
Date: Thu, 14 May 2015 16:38:05 -0400
Message-ID: <1431635888-11538-1-git-send-email-dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 14 22:38:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yszti-0007sY-4I
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 22:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934009AbbENUiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 16:38:16 -0400
Received: from mail-qc0-f171.google.com ([209.85.216.171]:32774 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932953AbbENUiN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 16:38:13 -0400
Received: by qcvo8 with SMTP id o8so46560598qcv.0
        for <git@vger.kernel.org>; Thu, 14 May 2015 13:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=ApntZ951iCb/WbM4mIqHLer5DHlcKI9gRdtbKJcXmec=;
        b=AxNIxbyNwNCFwgG+/Xs+pmisbVjYRA+yFYsz8OBbeUKtzMXBzirJDi+ednYwACRuJF
         5RWJG+Li95cv7iGzW5Kad5OBcX0FoOox8WiGJIj9dV+KVbpZp3y8/p2id9CPhBVa/LNO
         Lww9UqVe1jQNbh0cSVrColpg7qD7lQRdbfaCMZ1oLamViYSWD4M9LODbKLGZKrhT9DZb
         Ts8uS+YG2/njbFJa5DqbBovekZAffBYn2SjYI/1E/0fJSoD3XUzsldxFvsUHcPrkYnAr
         ehloepOZK/fAsdPvyX6DGiT8dfoEZ61YCDpIdvid9GKSKEfurU8JeQAjug8h1C9N8oZs
         ujXA==
X-Gm-Message-State: ALoCoQlcQElsvlWyhWBW07svs3gbvovfXxe3F+w0Agb37h3RzuNNPVd7R8nnqs5ZOXPLudMXnQGL
X-Received: by 10.140.202.4 with SMTP id x4mr8404440qha.27.1431635893100;
        Thu, 14 May 2015 13:38:13 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by mx.google.com with ESMTPSA id r33sm107494qkh.12.2015.05.14.13.38.12
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 May 2015 13:38:12 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269087>

Squashes Junio's formatting and text to cat-file.c on top of my doco
fixes from v10.
