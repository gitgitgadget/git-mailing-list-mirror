From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: gitignore broken in git 1.7.0.1: slash checks leading dirs
Date: Fri, 5 Mar 2010 11:25:49 -0600
Message-ID: <20100305172549.GA28562@progeny.tock>
References: <4B90C701.3070308@gmail.com>
 <4B90C974.2050405@viscovery.net>
 <4B90C9BE.1030407@gmail.com>
 <4B90CBE5.9090102@viscovery.net>
 <4B90CEDD.6020106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 05 18:26:15 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnbHn-0003gb-D2
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 18:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754628Ab0CERZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Mar 2010 12:25:42 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:65009 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581Ab0CERZk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 12:25:40 -0500
Received: by fxm19 with SMTP id 19so4369770fxm.21
        for <git@vger.kernel.org>; Fri, 05 Mar 2010 09:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Rw9Qipz7MuXO9xjPwG/y6wL/sAr30cOGloSGb/spkL8=;
        b=EhePgGjeDMzD+5Cr+dug4mJNimNqszVLq+Yscwd02GbVRMROKarzdptxXcTWHTlhG1
         j7+OlCPOMO4TcKhYjgIfUbBWTH+MQQtB83peKRwG7MPRuDsxVjPQ5wT5ydmbI4H/Dy6V
         tHCNo0ICBn2kN2Min2lD17RPQG9DOS/gM3PnE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hnC/q4PHlkGD0/wvJa1EPHF/+MmkmfwGNN8QD6DA8QfeR7QsjHJANk4L3dLzDXC8qA
         bN76PG2nFVPyNJS2dYfEEdJMAzerD6lWBu00IdZLP3KduB8m9SLVdOSxkjcshIKf6Xqe
         Nb6eCiiyHpZ93mNNZcy/yho9cx7LAl2s/rt88=
Received: by 10.87.48.35 with SMTP id a35mr2545818fgk.30.1267809939375;
        Fri, 05 Mar 2010 09:25:39 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id d6sm2880046fga.12.2010.03.05.09.25.37
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 05 Mar 2010 09:25:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B90CEDD.6020106@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141590>

Jiri Slaby wrote:

> Thinking about it, there is no way to specify a *filename* no matter
> where it lies? I.e. patterns such as *.o matches also a/b/test.o/test.c?
> Am I missing something?

Is

 *.o
 !*.o/

what you are looking for?  The first line matches *.o anywhere, and
the second matches *.o anywhere as long as it is a directory.
