From: "Matthias Kestenholz" <mk@spinlock.ch>
Subject: Re: gitk in a bare repo?
Date: Sat, 17 Nov 2007 17:06:18 +0100
Message-ID: <1f6632e50711170806x3d0c73eam7e341e73f637fc83@mail.gmail.com>
References: <004101c8292b$cd4b5d20$5267a8c0@Jocke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Sat Nov 17 17:06:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItQBs-0000hu-Ha
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 17:06:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244AbXKQQGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 11:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752029AbXKQQGY
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 11:06:24 -0500
Received: from fk-out-0910.google.com ([209.85.128.187]:9358 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbXKQQGX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 11:06:23 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1253744fkz
        for <git@vger.kernel.org>; Sat, 17 Nov 2007 08:06:19 -0800 (PST)
Received: by 10.82.114.3 with SMTP id m3mr8431834buc.1195315578641;
        Sat, 17 Nov 2007 08:06:18 -0800 (PST)
Received: by 10.82.162.10 with HTTP; Sat, 17 Nov 2007 08:06:18 -0800 (PST)
In-Reply-To: <004101c8292b$cd4b5d20$5267a8c0@Jocke>
Content-Disposition: inline
X-Google-Sender-Auth: 53e035e6b676acd1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65285>

Hi Joakim,

2007/11/17, Joakim Tjernlund <joakim.tjernlund@transmode.se>:
> How do I tell gitk I am in a bare repo?
>

The following command works for me:

$ ls
foo.git
$ GIT_DIR=foo.git gitk &
