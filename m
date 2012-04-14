From: Brian Cardarella <brian@dockyard.com>
Subject: Pushing to a remote repo from a remote repo?
Date: Sat, 14 Apr 2012 18:08:59 -0400
Message-ID: <CAAnwhhWTcfOi+qqXPnGNXSKHbFh5L=+6eSKaaex5mq6VTwSxEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 15 00:09:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJB9Y-0006ee-9l
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 00:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756363Ab2DNWJD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 18:09:03 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:40259 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756232Ab2DNWJA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 18:09:00 -0400
Received: by lbbgm6 with SMTP id gm6so3225879lbb.19
        for <git@vger.kernel.org>; Sat, 14 Apr 2012 15:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:date:message-id:subject:from:to
         :content-type:x-gm-message-state;
        bh=McTo6LSNBu/dZHt6mNhxmYdZ/epqFEo+vdC1kOU5ihA=;
        b=bfgn5O36IrUbIuyzB9/mJCAU6Ca/zozda1jL/4waE9PXyhUv2A4Xonu3jrsbi0WuJV
         QoBZk0BNiC/G0HNdpmfs72BZhDhU9N0dVz1PPmsC8pxbe0KsRCdqMWzxBOb3SOmnluNO
         VA4y+XudrkwxNTolZFsXJ8i5GI1YwS+dyA6OCTVMLnAQvoxAGRy1IEoK/bK9+nYSEol7
         Otpd9zOEapLP7zXruwaWl/9N2OmHHP0nqkqGqPf3v85dmMzS2BrhYn9NDGRog45q9FnY
         lvdSHolHcFBWjhTkSLxcMe817GtUaSmG9Fa7/9vQDn7E3GuA+Vy/886W0gjWadB8Xodh
         0m+Q==
Received: by 10.152.147.202 with SMTP id tm10mr6099112lab.49.1334441339389;
 Sat, 14 Apr 2012 15:08:59 -0700 (PDT)
Received: by 10.112.102.197 with HTTP; Sat, 14 Apr 2012 15:08:59 -0700 (PDT)
X-Originating-IP: [108.49.61.94]
X-Gm-Message-State: ALoCoQn0lXp6piNSqxTMsD2PQRdnKmS6o0JOdFC8SrfXqRBtJ4CBHWK0sswx1LRi21TM7+9tn2Qj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195526>

So I have a destination repo that is remote. And I have a source repo
that is also remote. I would like my local machine to act as a proxy
to allow me to push to the destination from the source without ever
download the repo to my machine. Is this possible?
