From: "Paul Holbrook" <paul.holbrook@gmail.com>
Subject: Accessing a single repository with different addresses?
Date: Tue, 6 May 2008 12:51:13 -0400
Message-ID: <8c0610ed0805060951x70ede89bq5a93e69aece8c8c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 18:52:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtQOg-0004vQ-RE
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 18:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765077AbYEFQvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 12:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760626AbYEFQvT
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 12:51:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:20642 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758998AbYEFQvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 12:51:16 -0400
Received: by ug-out-1314.google.com with SMTP id h2so381436ugf.16
        for <git@vger.kernel.org>; Tue, 06 May 2008 09:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=/K3rZYDNhCC7f3hyOqvSBzmrCR2DddgwFrP9KCiBJxs=;
        b=AcA/g4UNKwc9fp0i6rCWq6TjwzdqdFfp5uw9ChB7+admGq7A2yh7FuofD+EAjC4SLabv/DARZz/Xn6Zfqobaz6urFg2ZeBp8O8Nvtiw9ADCGH+NU6/2BrwYEJCwQRUbKynkmpu8SDLfaGPq3TxCYZMrp7osx47JmwWGb1Vp5GeA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pnkiXh21GTb9e3FRfnpcepbBq8a3bJ9sB44U4NRz0++7Jl9P048cG6LJJHMRg0NPnLp6juoJi+SA4dqK3eW9W/KaS1UAV6ZT8KP+8wh0eD8cbaZZtt+yi4FYG/Bb4Ks54Lov7oz+Z9kdoMzWRhhH/pjjMPl3hS2CCeWJYAZRafQ=
Received: by 10.67.89.17 with SMTP id r17mr5627727ugl.2.1210092673349;
        Tue, 06 May 2008 09:51:13 -0700 (PDT)
Received: by 10.66.224.13 with HTTP; Tue, 6 May 2008 09:51:13 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81369>

I have two machines at home that I've been using to play with git: a
desktop box and a laptop.  I set up a repository on the desktop, and
cloned it to the laptop via ssh, but using just a local 192.168.x.x
address.  However, when I leave the house, I'd still like to be able
to talk to the desktop repository, which I can still do via ssh back
to the house - but now the address for that very same repository is
not a 192 address, but a DNS name.   What's the best way to handle
this?

I'm aware that with git I don't need to have the all-the-time
connectivity to make it work - but when I leave the house,  there may
be changes on the desktop repository that I haven't yet pulled to the
laptop.  I still want to be able to get at those when I'm away from
home.

-- Paul
