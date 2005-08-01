From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: cg-clone failing to get cogito latest tree.
Date: Mon, 1 Aug 2005 14:49:37 +1200
Message-ID: <46a038f905073119492e521bde@mail.gmail.com>
Reply-To: Martin Langhoff <martin.langhoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Aug 01 04:50:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzQNK-0002me-Mw
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 04:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbVHACtm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 22:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbVHACtm
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 22:49:42 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:32067 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262001AbVHACtm convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2005 22:49:42 -0400
Received: by rproxy.gmail.com with SMTP id i8so1201442rne
        for <git@vger.kernel.org>; Sun, 31 Jul 2005 19:49:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NarIB0Ajb9ZL5NIKCrVP1a3d3WXcze2VztdjomWwiuk2B/NsmCr57wc+D+CTdF4q7PtrgENKOY3lqv3lFwE59q6IHN8nLftoxVnNQ5Fsgiy1qZXRMIdtkTnSWNimgyXYMR9ybotraXNj6u6JptlkZp3v/WEZZu7DiVM72MmJteM=
Received: by 10.38.75.30 with SMTP id x30mr782670rna;
        Sun, 31 Jul 2005 19:49:37 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Sun, 31 Jul 2005 19:49:37 -0700 (PDT)
To: GIT <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On a new machine, trying to boostrap into latest cogito, I download
and make cogito 0.12.1, and then...

$ cg-clone http://www.kernel.org/pub/scm/cogito/cogito.git cogito
defaulting to local storage area
14:48:53 URL:http://www.kernel.org/pub/scm/cogito/cogito.git/refs/heads/master
[41/41] -> "refs/heads/origin" [1]
progress: 34 objects, 45126 bytes
error: File d2072194059c65f92487c84c53b9f6b5da780d14
(http://www.kernel.org/pub/scm/cogito/cogito.git/objects/d2/072194059c65f92487c84c53b9f6b5da780d14)
corrupt

Cannot obtain needed blob d2072194059c65f92487c84c53b9f6b5da780d14
while processing commit 0000000000000000000000000000000000000000.
cg-pull: objects pull failed
cg-init: pull failed

any hints? I have a similar problem fetching git with cg-clone: 

$ cg-clone http://www.kernel.org/pub/scm/git/git.git git
defaulting to local storage area
14:53:44 URL:http://www.kernel.org/pub/scm/git/git.git/refs/heads/master
[41/41] -> "refs/heads/origin" [1]
progress: 2 objects, 4666 bytes
error: File 6ff87c4664981e4397625791c8ea3bbb5f2279a3
(http://www.kernel.org/pub/scm/git/git.git/objects/6f/f87c4664981e4397625791c8ea3bbb5f2279a3)
corrupt

Cannot obtain needed blob 6ff87c4664981e4397625791c8ea3bbb5f2279a3
while processing commit 0000000000000000000000000000000000000000.
cg-pull: objects pull failed
cg-init: pull failed

Probably doing somethginf hopelessly wrong...


martin
