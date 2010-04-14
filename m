From: David Aguilar <davvid@gmail.com>
Subject: Re: My solution
Date: Tue, 13 Apr 2010 23:41:08 -0700
Message-ID: <20100414064107.GA3254@gmail.com>
References: <loom.20090804T204107-117@post.gmane.org> <200908042347.48705.trast@student.ethz.ch> <loom.20090804T224435-568@post.gmane.org> <loom.20100414T040717-222@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Seb <seba.illingworth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 08:41:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1wHr-0004K3-AB
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 08:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753811Ab0DNGlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 02:41:17 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:63811 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482Ab0DNGlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 02:41:16 -0400
Received: by ywh36 with SMTP id 36so3540163ywh.4
        for <git@vger.kernel.org>; Tue, 13 Apr 2010 23:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=acE/nHW+YZHnxjzaPS8gz0ktElN+WjTaDvyahRUb6Kw=;
        b=IukULn4M+7VyLxuWFq1rK8omyaOyuctwElYIb5E1mRrLKibmwElbcsA83Fr9Taypuv
         sgujaCdxQOUXyXsbUybjObE5RTNUCCn8caiOYD2RqhnFTfaFG+Y6GJ/ReejVWd8KeIiJ
         esEqvu+9uur417TqslA69+RaAVTyeWOGyJ1gQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LE5kcdWNSTBk2rbKQRQrNkDokdZhthDrJgcNRKMcfW4KcpWD5jeJJuPG10Kwrs+Ghb
         5Um192Fze0S4t7MV6GK8Efix0+PEwxwoDFQSgzXHKTugdnuvc7D4b1XX263oezIh65QT
         hqS3Rn7G8gaO7fedpMwNyVnOR/6lgKVnQ6n9Q=
Received: by 10.150.208.15 with SMTP id f15mr6198885ybg.8.1271227275662;
        Tue, 13 Apr 2010 23:41:15 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 7sm2450ywf.55.2010.04.13.23.41.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Apr 2010 23:41:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <loom.20100414T040717-222@post.gmane.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144854>

On Wed, Apr 14, 2010 at 02:16:07AM +0000, Seb wrote:
> Seba Illingworth <seba.illingworth <at> gmail.com> writes:
> 
> > 
> > Thomas Rast <trast <at> student.ethz.ch> writes:
> > 
> > > 
> > > I posted the script below on IRC the other week[1] in reply to someone
> > > looking for a way to do this for 'meld'.
> > ...
> 
> Just realised I never posted my solution. This works great for me, I wouldn't do 
> without it:
> http://blog.codefarm.co.nz/2009/08/git-diff-and-difftool-open-all-files.html

Thanks.  We should add git difftool --all, what do you think?

Do you have any thoughts about difftool's defaults?
I've always kind of felt that --no-prompt was a possible candidate...

-- 
		David
