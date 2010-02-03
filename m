From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor
 with no changes written
Date: Wed, 3 Feb 2010 11:53:04 -0600
Message-ID: <20100203175304.GB2982@progeny.tock>
References: <76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com>
 <77153A83-158D-4D36-A622-7AA3947C7D52@wincent.com>
 <76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com>
 <alpine.DEB.1.00.1002022356460.4985@pacific.mpi-cbg.de>
 <76c5b8581002021534i1f0dbd18y1b216233d282cd84@mail.gmail.com>
 <40aa078e1002021540i13e35776xd733a4e40f34b477@mail.gmail.com>
 <76c5b8581002021548n129b3997r48ee6f6df5a1a4eb@mail.gmail.com>
 <vpqeil2kc6b.fsf@bauges.imag.fr>
 <76c5b8581002030745g634d6ec1hb9e87b687e58e521@mail.gmail.com>
 <20100203175118.GA2982@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, kusmabite@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wincent Colaiuta <win@wincent.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 18:53:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcjPd-0006I2-Te
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 18:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932789Ab0BCRxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 12:53:09 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:42095 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932768Ab0BCRxH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 12:53:07 -0500
Received: by iwn39 with SMTP id 39so1828714iwn.1
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 09:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=81PSl+YVqlOv8gzHWpDfGyozCYaP/1SECCQBgBKTo58=;
        b=eUmXnyqi2bFx5SLkeOHOssqZPr5Bpffaa9SQlQ70ShQIJzPpMjA3ttjsrmB4dGl0lz
         Lep2dX1mj+M96cB7hxzDJKBW/OmyqXG/Zkp+TApFA3mi9tBChnbIRiXVB1qbW+jBtK8u
         StgXlI6mhn0GDPSNcc6t3CpwEiWm9/QVQgr/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dIIu6LltWluAEOJ7D/fRBG5l8FNDOJVDFblUNgkmp9Q1yoq2Si8jYn2fjZ/8dkt6+R
         dbbXP7pMNSXF4v/sfDVdYZHXcGE2B3yP3wobd2pgrRUZkNFiFU68pNhTFZ06rIJjXCQU
         cD9j9WWy6d+NW2Vmn3/lhULuUYRrnbWGoacNQ=
Received: by 10.231.160.149 with SMTP id n21mr843445ibx.93.1265219586531;
        Wed, 03 Feb 2010 09:53:06 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm5724184iwn.13.2010.02.03.09.53.05
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 03 Feb 2010 09:53:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100203175118.GA2982@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138851>

Jonathan Nieder wrote:

> It is a bit frustrating to read this thread because Mattheiu was not the
> first thing to say this

s/thing/person/

Sorry, Mattheiu. ;-)

Kind regards,
Jonathan
