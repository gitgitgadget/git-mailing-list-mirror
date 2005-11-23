From: Morten Welinder <mwelinder@gmail.com>
Subject: pack-redundant.c:689: warning: long unsigned int format, size_t arg (arg 3)
Date: Tue, 22 Nov 2005 20:34:57 -0500
Message-ID: <118833cc0511221734r33b20f6au97fe2e93243f5ccf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Nov 23 02:36:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EejXJ-0002xu-3k
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 02:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964769AbVKWBe6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 20:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965054AbVKWBe6
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 20:34:58 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:18937 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964769AbVKWBe5 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 20:34:57 -0500
Received: by zproxy.gmail.com with SMTP id 13so1240463nzn
        for <git@vger.kernel.org>; Tue, 22 Nov 2005 17:34:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dWakx3yi77CSUSDMgdcdpdADQRbg9iEypN3R0AfwH+rUnrPxT7Oveq7abrayMQCT5v4PQnhDaIF78q7WWmuqeuh74JFo1DditJRHG2qmgnBB37sN30qxOE/g2Tlk4gmirT7b5LDzmjZB1mjE9puD71HwP9Pp3ZJkrUfw333yJgs=
Received: by 10.65.243.18 with SMTP id v18mr5377741qbr;
        Tue, 22 Nov 2005 17:34:57 -0800 (PST)
Received: by 10.65.154.6 with HTTP; Tue, 22 Nov 2005 17:34:57 -0800 (PST)
To: GIT Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12594>

Maybe cast the size to unsigned long to make it match the format.

M.


pack-redundant.c: In function `main':
pack-redundant.c:689: warning: long unsigned int format, size_t arg (arg 3)
