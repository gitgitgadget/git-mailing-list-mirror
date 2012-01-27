From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PULL] svn-fe updates for master or next
Date: Thu, 26 Jan 2012 18:46:05 -0600
Message-ID: <20120127004605.GA31538@burratino>
References: <CAFfmPPMH2643JMMZdVbOQJL7DB-DiRYQS8x0TqEaSbGmhMdBNw@mail.gmail.com>
 <CALkWK0kMmDMZ4wiMSmOfwBLzd+xBEA+WKsviu9FVcvj9eZEahg@mail.gmail.com>
 <CAFfmPPOZfDdH+GF91Dxyy5yfX8TmGDmsbpHz=CVLcBY0c-pCsQ@mail.gmail.com>
 <CALkWK0nsO2EBLUrO_iWAdGYpULt=oug4yPDnczX9c44hzdwzqg@mail.gmail.com>
 <alpine.DEB.2.02.1201221310540.28747@asgard.lang.hm>
 <3BC64515-C4C0-4D32-97B0-8FFD14BB903C@silverinsanity.com>
 <CAP2yMaLHK2md=MHFmV--R6rmr4q3XuZxqsb2fUszMhssx3GDoA@mail.gmail.com>
 <CAFfmPPPvpbsYz9cjN6OspivCN3dbuPGOU7fyaVdnic3D4V855w@mail.gmail.com>
 <20120127001041.GB6158@burratino>
 <20120127003258.GA6946@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <davidbarr@google.com>,
	Scott Chacon <schacon@gmail.com>,
	Brian Gernhardt <benji@silverinsanity.com>, david@lang.hm,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Dmitry Ivankov <divanorama@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 01:46:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqZxL-00081N-E1
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 01:46:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363Ab2A0AqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 19:46:15 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:44838 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941Ab2A0AqO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 19:46:14 -0500
Received: by yenm6 with SMTP id m6so571172yen.19
        for <git@vger.kernel.org>; Thu, 26 Jan 2012 16:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ECZjCejW0P9OZaOUo49ZncPmAHzy/8zCTcGWqsbeDWk=;
        b=PbN9SGNeTQ2I6DCwyO3kyeS3ENynubYucRnDk4BTNY+Q6sXV3egIsTdF0UlkEAT5at
         28Ix+7JK0f41JRj7o2fZxIEWTQ/WgHsxKsFG5UA5drYt12i1SyZgJPni2ddUoSsFcplK
         PBUX8lGRvplelx6g6jPyJqfEGuKAlUquU3npc=
Received: by 10.236.75.163 with SMTP id z23mr6779895yhd.79.1327625173687;
        Thu, 26 Jan 2012 16:46:13 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id o61sm9996129yhk.10.2012.01.26.16.46.12
        (version=SSLv3 cipher=OTHER);
        Thu, 26 Jan 2012 16:46:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120127003258.GA6946@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189180>

Jonathan Nieder wrote:

>                                           It simplifies svn-fe a great
> deal and fulfills a longstanding wish: support for dumps with deltas
> in them.

Oh, and incremental imports, too. ;-)
