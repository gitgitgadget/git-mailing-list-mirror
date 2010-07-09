From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Add svnrdump
Date: Fri, 9 Jul 2010 16:17:46 +0200
Message-ID: <20100709141746.GA20383@debian>
References: <20100708083516.GD29267@debian>
 <002d01cb1e7f$e0ff03c0$a2fd0b40$@nl>
 <20100709134228.GB12315@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dev@subversion.apache.org, 'Jonathan Nieder' <jrnieder@gmail.com>,
	'Sverre Rabbelier' <srabbelier@gmail.com>,
	'Git Mailing List' <git@vger.kernel.org>
To: Bert Huijben <bert@qqmail.nl>
X-From: git-owner@vger.kernel.org Fri Jul 09 16:16:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXENC-0006rb-Uh
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 16:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756867Ab0GIOQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 10:16:10 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59703 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029Ab0GIOQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 10:16:09 -0400
Received: by ewy23 with SMTP id 23so486899ewy.19
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 07:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=TifrNy/7o4+nsKSrTiqQN3dEaQQroSbTTbBWXUuYvuU=;
        b=RQvrCzUwz/fkPYDE6plKUtCcn5Gg13mLpsh3y+au4ZaX0fRisMt/x2MtSgwRZgspa0
         haTBkWnmXJ5QJcUwZss/64OHbUeUkMMNtQuMvqiqr0HxYUx3y65bTEyeOxMy94FmY2dT
         T7Zetu4OYH/gDcV5TNlFMtGzoG5F2GT5y5jqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lj7XYrUrrMkZNMz6zGRfcU8G8b+OqNMPwVbsAmDsbad3NpAISTpFYTTnmoH/KNv9JU
         QP0MzpTuGUhTtqBmyJGRpqjh4y6AOFlaIh+7ZIQauTabzjxw/QTgH7AuII/MxSRQ7Alq
         8/cCnRVSMOJI5cYE0ooucCKquQ+toVi2p+Wdo=
Received: by 10.213.14.20 with SMTP id e20mr8360275eba.21.1278684964424;
        Fri, 09 Jul 2010 07:16:04 -0700 (PDT)
Received: from debian (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id v8sm7910045eeh.2.2010.07.09.07.16.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Jul 2010 07:16:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100709134228.GB12315@debian>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150670>

Hi,

Ramkumar Ramachandra writes:
> Where is svn_dirent_basename defined? I can't seem to find it in the
> codebase at all.

np, I found it. It's svn_relpath_basename.

-- Ram
