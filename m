From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: SSH keys location
Date: Thu, 22 Apr 2010 11:42:39 -0700
Message-ID: <20100422184239.GA29426@spearce.org>
References: <v2rb42431c81004221140n31c76030m74656d01950b8ae0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mahesh Vaidya <forvaidya@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 20:42:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O51MT-00060k-VA
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 20:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754883Ab0DVSms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 14:42:48 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61710 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561Ab0DVSms (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 14:42:48 -0400
Received: by wyb39 with SMTP id 39so5060320wyb.19
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 11:42:46 -0700 (PDT)
Received: by 10.216.163.7 with SMTP id z7mr426562wek.123.1271961765446;
        Thu, 22 Apr 2010 11:42:45 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id r29sm1688794wbv.15.2010.04.22.11.42.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Apr 2010 11:42:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <v2rb42431c81004221140n31c76030m74656d01950b8ae0@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145547>

Mahesh Vaidya <forvaidya@gmail.com> wrote:
> I have a situation where I must save my private keys location other
> than ~/.ssh ; How do I tell git URL that please take public key from
> so and so location equivalent of ssh -i <identity-file> flag
> 
> example my clone command is
> 
> git clone gitosis@server:repos.git

Just use ~/.ssh/config to rewrite the options:

  Host server
    IdentityFile /some/private/key/path

-- 
Shawn.
