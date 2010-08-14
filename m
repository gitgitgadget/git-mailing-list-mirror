From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Silent maintenance
Date: Sat, 14 Aug 2010 16:05:56 -0500
Message-ID: <20100814210556.GB2372@burratino>
References: <20100814131156.GA24769@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 14 23:07:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkNwz-0006ny-Oy
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 23:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755875Ab0HNVH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Aug 2010 17:07:29 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59132 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755973Ab0HNVH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Aug 2010 17:07:29 -0400
Received: by ywh1 with SMTP id 1so1485815ywh.19
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 14:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=NhP0cudEvQBD6wgVr8/hjHCkDrisDcOx+U4KshuyBZc=;
        b=ev48PJO5H0fyRPfWOyoXbpDy/VtQeD2RJ+i8A7EtBp3FE+UHK1P+JbXxKPpSo4oPn2
         5WgW80qGrdm9v8TKW959oMpfW7KtOEQxhDnY4Z0P6QxIJE4tRKdnxSs8qg/eZW22sZYg
         8sQzB1eAB4tcf9fLwtxAVgeb7ud2SPq2x7jvo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rkYjjOc97P1B37oIFAr5fG4e6Gi0a/7xPCAiU0Xn/jA0U22UHygmfZRnw0JUgQArYZ
         tDrIbvA8jQmPGBWg8DWKyj/iB8ij4iQ7e6GA553dO4A0Hzs1j1tVh47Jdk/cSQo51byK
         rXu4YxCbPetI5JpoCCgvWNmHEiwupLuDE20mc=
Received: by 10.151.17.4 with SMTP id u4mr3766222ybi.346.1281820048372;
        Sat, 14 Aug 2010 14:07:28 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q1sm4637506ybk.20.2010.08.14.14.07.27
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 14 Aug 2010 14:07:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100814131156.GA24769@nibiru.local>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153579>

Enrico Weigelt wrote:

> are there some flags to make the maintenance commands like
> git-repack and git-gc silent, so they only output errors ?

Does --quiet work?  If not, patches would be welcome.
