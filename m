From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git-svn branches creation question
Date: Thu, 26 Jun 2008 12:08:20 -0400
Message-ID: <32541b130806260908m7ca2060bub071da52aa7a33ce@mail.gmail.com>
References: <4863BBFB.8010305@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing-List" <git@vger.kernel.org>
To: "Pascal Obry" <pascal@obry.net>
X-From: git-owner@vger.kernel.org Thu Jun 26 18:09:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBu2C-0000Ap-Hk
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 18:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754292AbYFZQIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 12:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753724AbYFZQIX
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 12:08:23 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:23926 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbYFZQIW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 12:08:22 -0400
Received: by fk-out-0910.google.com with SMTP id 18so84454fkq.5
        for <git@vger.kernel.org>; Thu, 26 Jun 2008 09:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ITUB5lDE1oTO82KMm0YZ4FGZ2HhVUsL3VzjZQHFXaY4=;
        b=A5La2Z4IewXM+QME41uMI+Yycpe/Ixka5CR4YFPOeJfFavzKSMeoiiPBi0MQXh9GrP
         JXsf3NilvAm5gpHjwb2RQlft+buNK70zdq5+DlsI3tmw9OpNykO1JYL6h2jwJKaRIDAl
         EoYQesJfUNuw2alNSXgrnv0F35u6bmdzhKnEs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=eyav38X0j3TEzV+Oee0IOtWS3NxBglF8Bnq9IHz/ivAoD9s1zkRNfxIJtzl2rRmozs
         co+fqemVnierKeQieAjVBZQT5z1xMIr55khyY79uu9OR1VS3fdQyPqZjdGFrudw769Cv
         qkrldiowozezLy5Ur4eT7y99IS5A3UwgTk9BM=
Received: by 10.82.107.3 with SMTP id f3mr1716buc.87.1214496500688;
        Thu, 26 Jun 2008 09:08:20 -0700 (PDT)
Received: by 10.82.175.10 with HTTP; Thu, 26 Jun 2008 09:08:20 -0700 (PDT)
In-Reply-To: <4863BBFB.8010305@obry.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86459>

On 6/26/08, Pascal Obry <pascal@obry.net> wrote:
>  Is it possible to create and track new branches (or tags) using git-svn?
>
>  I know how to track existing branches, but new ones?
>
>  Some context. I'm tracking a CVS repository doing update from time to time
> on the master branch (using simply rsync and git-svn dcommit). Now I want to
> add a new tag for updates on the master. Currently I'm using svn copy. I'd
> like to do this directly from Git.

I don't think there's a way to do this.  You can create branches in
git that *aren't* tracked in svn, of course, if you want to do that.

And creating branches in svn is a single command, even if you don't
have an svn checkout:

   svn cp $SVN/trunk $SVN/branches/whatever

So it seems unnecessary to duplicate this feature in git.

Have fun,

Avery
