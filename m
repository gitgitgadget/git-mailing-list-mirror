From: =?utf-8?B?SsSBbmlzIFLFq2Npcw==?= <parasti@gmail.com>
Subject: Re: git svn should refuse to checkin .svn directories
Date: Sat, 19 Apr 2008 21:49:33 +0300
Message-ID: <20080419184933.GA9724@localhost.localdomain>
References: <200804181346.50755.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Thomas Koch <thomas@koch.ro>
X-From: git-owner@vger.kernel.org Sat Apr 19 20:51:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnI94-0004Gf-Rt
	for gcvg-git-2@gmane.org; Sat, 19 Apr 2008 20:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762508AbYDSSt4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Apr 2008 14:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762487AbYDSSt4
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 14:49:56 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:61603 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758052AbYDSSty (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 14:49:54 -0400
Received: by fk-out-0910.google.com with SMTP id 19so1384563fkr.5
        for <git@vger.kernel.org>; Sat, 19 Apr 2008 11:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        bh=xOy4JGo3dj8nFVDh/wa8N0hUxvZdoS6B9XSSiD6ONLw=;
        b=G5VVXRRBRdZ0EFWiK+ILkUPCDDZwp6CcXA5cJ64wzLtM5Pl6n0aG0s/xNiwmVtW8hDikHMy8GOASv0mXoFYikPFWzwNXqpVV/hzaLMPnsSKCBabVVQEOqSIkLJjUyoj6joBznZcIGJaYp2yX7fWC36kqCYs529SpgUr83FlTMag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=ZDveVZpq0muVYuRvVqpvxDhF97JPf5UH9rV7asvksUK5a68PUH8w4bzMZY4qblY6bpG+GFvNlWaWm57ruU4LIw/U1ApA4KSWyzmciYB51xEyAEy097PqZpyf3efR2AGOur8KyBXFxbMtq8SlfXMZH/gXMQM2VJH8TCgdk0r2bB8=
Received: by 10.82.134.12 with SMTP id h12mr757031bud.6.1208630993117;
        Sat, 19 Apr 2008 11:49:53 -0700 (PDT)
Received: from localhost.localdomain ( [62.63.162.71])
        by mx.google.com with ESMTPS id f4sm1912079nfh.26.2008.04.19.11.49.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Apr 2008 11:49:52 -0700 (PDT)
Received: from parasti by localhost.localdomain with local (Exim 4.69)
	(envelope-from <parasti@gmail.com>)
	id 1JnI7x-0002X5-Fe; Sat, 19 Apr 2008 21:49:33 +0300
Mail-Followup-To: Thomas Koch <thomas@koch.ro>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200804181346.50755.thomas@koch.ro>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79917>

Hi,

On Fri, Apr 18, 2008 at 01:46:50PM +0200, Thomas Koch wrote:
> I'm sure that there is also a config option somewhere to get .svn dir=
ectories=20
> ignored (also subdirs when adding the parent dir?). But this check sh=
ould=20
> really be a default setting to avoid other newcommers to get into tro=
uble=20
> because they gave git svn a try.

Perhaps it would help if you clarified why there are .svn directories i=
n
your working copy.  They are neither required nor created by git-svn.

J=C4=81nis
