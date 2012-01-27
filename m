From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PULL] svn-fe updates for master or next
Date: Fri, 27 Jan 2012 01:20:23 -0600
Message-ID: <20120127072023.GB806@burratino>
References: <CAFfmPPOZfDdH+GF91Dxyy5yfX8TmGDmsbpHz=CVLcBY0c-pCsQ@mail.gmail.com>
 <CALkWK0nsO2EBLUrO_iWAdGYpULt=oug4yPDnczX9c44hzdwzqg@mail.gmail.com>
 <alpine.DEB.2.02.1201221310540.28747@asgard.lang.hm>
 <3BC64515-C4C0-4D32-97B0-8FFD14BB903C@silverinsanity.com>
 <CAP2yMaLHK2md=MHFmV--R6rmr4q3XuZxqsb2fUszMhssx3GDoA@mail.gmail.com>
 <CAFfmPPPvpbsYz9cjN6OspivCN3dbuPGOU7fyaVdnic3D4V855w@mail.gmail.com>
 <20120127001041.GB6158@burratino>
 <20120127003258.GA6946@burratino>
 <20120127004605.GA31538@burratino>
 <CAFfmPPN-g+Lk2n9tzXe=CfyK8OZ7nGu4NwX0cXjtxS0W7SwPHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Brian Gernhardt <benji@silverinsanity.com>, david@lang.hm,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Dmitry Ivankov <divanorama@gmail.com>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 08:20:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rqg6t-0000hz-0F
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 08:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755958Ab2A0HUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 02:20:30 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45076 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257Ab2A0HU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 02:20:29 -0500
Received: by iacb35 with SMTP id b35so1714521iac.19
        for <git@vger.kernel.org>; Thu, 26 Jan 2012 23:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=rg+JKKuWsHFWeWVxaWliJ+WpvegSnwC6Bd2g9V29sEU=;
        b=YLZuoJPVI/d7WFli2f3qAG5QUs7nKHzozET9nb6fysJo37m4bKiCQCXWEE9C8DKGCl
         POv/BvzyJ3Kb7PoNWsSxm6yX4FE4t5nm+W8OJlZ+prqjM3nFyZqL4nydfVGC+LzDx7ji
         biJ7dv1Bq67era0zUwcXZXsbNxZlTUQTfg//k=
Received: by 10.50.6.138 with SMTP id b10mr5385244iga.21.1327648829054;
        Thu, 26 Jan 2012 23:20:29 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id vg9sm3268865igb.4.2012.01.26.23.20.27
        (version=SSLv3 cipher=OTHER);
        Thu, 26 Jan 2012 23:20:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAFfmPPN-g+Lk2n9tzXe=CfyK8OZ7nGu4NwX0cXjtxS0W7SwPHA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189201>

David Barr wrote:

> I do think we need to gather Dmitry's work on svn-fe

Listed at [1].  Thanks for the nice and well maintained overview,
Dmitry.

>                                                      and propose a
> front-end for core so that it is no longer relegated to contrib.

Yep.  Should such a remote helper link directly to the vcs-svn lib, or
would it make sense to start with a script that makes use of svn-fe
(possibly with a different name once it is hoisted out of contrib)?

[1] http://divanorama.github.com/gsoc11/streams.html
