From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: Error in Git
Date: Tue, 3 Nov 2009 13:18:42 +0100
Message-ID: <20091103121842.GA13210@vidovic>
References: <4AEFEF22.9000909@globaledgesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Ravindra <ravindra.kulkarni@globaledgesoft.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 13:18:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5ILe-0004zU-Ha
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 13:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbZKCMSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 07:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752188AbZKCMSn
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 07:18:43 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:57179 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956AbZKCMSn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 07:18:43 -0500
Received: by bwz27 with SMTP id 27so7516005bwz.21
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 04:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=QnfilssCKPhSbGOvTFSObTdLXi3llWXdW6/B0fTprR8=;
        b=LLi0y0csMHJcnnMUXOg8C1yQKXZ2Jfr+x+ao4BisDClM4Taozu2QIADu52NrU9MGTu
         gk10bbFx0H5BjaevoMhti06aIvDMLN5PvZ2znvn5/jcQamSC2m9pSFraP+huHM1Yjw+6
         86IiPrkEh2/k0PAE3tNH2RkvJOaq8NFwPmsLY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OhrbVN009QAgZAb+P2oTkncgRiDDtpnACIxehFx7We2UOZI9b/kS9OVyrU8Z270Ss1
         Fwy5x5U214N6+io0OtnabA82jJmRhH+aJGU5qXZ+oQQ0zS167G0Uvyd8WdQLoNP4d6zx
         65r+lsR6sTGabnqWESi83Yrkflba0ERjX8ARs=
Received: by 10.204.154.150 with SMTP id o22mr4881632bkw.154.1257250726725;
        Tue, 03 Nov 2009 04:18:46 -0800 (PST)
Received: from @ (91-164-153-120.rev.libertysurf.net [91.164.153.120])
        by mx.google.com with ESMTPS id 18sm84627fkq.7.2009.11.03.04.18.44
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Nov 2009 04:18:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4AEFEF22.9000909@globaledgesoft.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131970>

The 03/11/09, Ravindra wrote:

> When i execute the git command for the url
> git://git.openezx.org/sgh-i900.git I am getting the following error,
> Please let me know how to solve this.

It really looks like a problem coming from the remote side only. I'm not
sure why. You should contact the admin of the repository.

> error: waitpid (async) failed fatal: error in sideband demultiplexer

I've had a similar error here :

  % git clone git://git.openezx.org/sgh-i900.git
  Initialized empty Git repository in /tmp/sgh-i900/.git/
  remote: Counting objects: 128422, done.
  remote: Compressing objects: 100% (122355/122355), done.
  remote: Total 128422 (delta 6110), reused 128357 (delta 6067)
  remote: aborting due to possible repository corruption on the remote side.
  Receiving objects: 100% (128422/128422), 46.32 MiB | 519 KiB/s, done.
  Resolving deltas: 100% (6110/6110), done.
  fatal: error in sideband demultiplexer
  %

And at my first try :

  % git clone git://git.openezx.org/sgh-i900.git
  Initialized empty Git repository in /tmp/sgh-i900/.git/
  remote: fatal: Out of memory, realloc failed
  remote: aborting due to possible repository corruption on the remote side.
  fatal: early EOF
  fatal: index-pack failed
  %

% git --version
git version 1.6.5.2.293.ge3812c

-- 
Nicolas Sebrecht
