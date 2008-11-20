From: David Aguilar <davvid@gmail.com>
Subject: Re: Git commit won't add an untracked file given on the command
	line
Date: Thu, 20 Nov 2008 02:18:46 -0800
Message-ID: <20081120101845.GA3291@gmail.com>
References: <20081118211237.234d8035@crow> <200811182227.20076.fge@one2team.com> <20081118214730.005fc72d@crow> <alpine.DEB.1.00.0811190206170.30769@pacific.mpi-cbg.de> <20081119095452.3018d2de@crow>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Burton <markb@ordern.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 11:24:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L36i5-0001sB-9u
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 11:24:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633AbYKTKXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 05:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753566AbYKTKXO
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 05:23:14 -0500
Received: from rv-out-0506.google.com ([209.85.198.227]:39600 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753455AbYKTKXN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 05:23:13 -0500
Received: by rv-out-0506.google.com with SMTP id k40so393837rvb.1
        for <git@vger.kernel.org>; Thu, 20 Nov 2008 02:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=E1ToT5JBwaoGbvif/IdRR4eVQJKA8i99IdMWTkKAlHM=;
        b=IaAoATBUxHLmmPZ7J304Fo8hUNkMQngw7t1JhBQkEii3GX5dCFtd07nr2VbrcIhSiR
         kCdXZ8nCsfXOyr2BoUm2+itiV7zzEKYlKDEPJiQ+kPAvj0otAYkx4DdGLSJvtFSSXGrV
         sKrSGdy4Z1MxkFyKCgjXXntBCCjiJ+qDSP8As=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cPS9JFJoW0ZHhwGxz6cp5RK/YAZgzltk6tb9iUldKThe/CU7cFMjp8fJjzDM907+Zc
         FejlnJ8Mq24zU9jX8s8XKfbJD7lSFdurM4T3sqqJgURX44zCSPKwTYMYPT8Todjb1TbG
         jMcC6RMvOvIKnlnDrSdICLxRz1KVcS7TOzHjs=
Received: by 10.141.122.1 with SMTP id z1mr1163469rvm.49.1227176592400;
        Thu, 20 Nov 2008 02:23:12 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id k41sm1140944rvb.4.2008.11.20.02.23.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Nov 2008 02:23:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20081119095452.3018d2de@crow>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101400>

On  0, Mark Burton <markb@ordern.com> wrote:
> 
> Hi,
> 
> Feature request for the git gui people:
> 
>   It would be nice if git gui was able to stage a highlighted region
>   rather than either the whole hunk or just the line under the cursor
>   as I believe it behaves now. I might be wrong but I don't think it
>   can do that at the moment. I think that would be useful because
>   although it's a step forward to be able to stage individual lines in
>   a hunk, it can be laborious if you want to pick out more than just a
>   couple of lines.
> 
> Cheers,
> 
> Mark


git-cola can do that.
http://cola.tuxfamily.org/


-- 

	David
