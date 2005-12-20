From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: git /objects directory created 755 by default?
Date: Wed, 21 Dec 2005 12:25:07 +1300
Message-ID: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Dec 21 00:25:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eoqr5-0002wi-VW
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 00:25:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbVLTXZK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Dec 2005 18:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbVLTXZK
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Dec 2005 18:25:10 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:30436 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932210AbVLTXZI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2005 18:25:08 -0500
Received: by wproxy.gmail.com with SMTP id 57so14515wri
        for <git@vger.kernel.org>; Tue, 20 Dec 2005 15:25:08 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qlCpx9GhZFdFPZeCzdlyv1j7bRWvUEUJfl8ZsfFTZ9eizSZntwX9XsjuNjFHzjiUbdth9hfovP+n+R1mqR2pqSzJUPRjB52y0f+FJzgUDD842q6mTbkwk0M/Qo4/WUZPID75Uk1M0ie5++EvsdBsdIz9nowpae2vQs6+4fhSOb4=
Received: by 10.54.115.15 with SMTP id n15mr92098wrc;
        Tue, 20 Dec 2005 15:25:07 -0800 (PST)
Received: by 10.54.72.15 with HTTP; Tue, 20 Dec 2005 15:25:07 -0800 (PST)
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13856>

Junio,

Since git changed to creating the objects subdirectories "on demand",
these are created 755 regardless of the user's umask. This is quite
inconvenient in ("cvs style") team-shared repositories, which work
great otherwise.

Didn't find any relevant discussion in the archives... I am not sure
if this is by design. In any case it is something we could work around
with a post-update hook on the server side (and I'd be happy to
document).

cheers,


martin
