From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Sun, 14 Jul 2013 13:49:20 -0700
Message-ID: <20130714204920.GF8564@google.com>
References: <51E03B18.5040502@kdbg.org>
 <7vli5bllsd.fsf@alter.siamese.dyndns.org>
 <51E0605E.9020902@kdbg.org>
 <7vy59biih4.fsf@alter.siamese.dyndns.org>
 <51E0F93A.8050201@kdbg.org>
 <7vwqougwec.fsf@alter.siamese.dyndns.org>
 <51E1B5DB.9080904@kdbg.org>
 <7v61wdgdd1.fsf@alter.siamese.dyndns.org>
 <51E3084D.2040504@kdbg.org>
 <20130714203403.GE8564@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Jul 14 22:49:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyTEl-0006Um-TE
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 22:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753235Ab3GNUtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 16:49:24 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:47219 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753099Ab3GNUtY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 16:49:24 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp16so10660150pbb.14
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 13:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9iPMdLsktGO4hkvdJQpbNMfUulHrBgyRgptfB1X57jU=;
        b=bEuIVhtcTeIcSoo3rdj98cnPD7PqJC/FOwMiD3pn5UQY6b+Gyjq3J89e+aF2zgsZd2
         nhSrL5Od0Mz9HNcKEsOuLfuOF2Az92cZaN1rz2MiE0OcZIchT41AK9v/xpY3kbfmPXQY
         pPfwniwVnVXVMI6+dkOK86oyCvLTMBhat4micYgqev+VrxqqrOmcEvMd2KGMbaj10GQU
         R8IeUnBmmT4BMWtECHCnxiHueJyUYc2M5jnVALTlGCypVHbHTXMLKcz4T51Da1jODBKW
         ZIOl8PJ6s+TEJPi0BAYGqXmt9TxndbL3HhVbsSG+1NoOcP6i6VOzGP6foUZVASc29Amc
         h8Pg==
X-Received: by 10.66.161.166 with SMTP id xt6mr53032360pab.87.1373834963745;
        Sun, 14 Jul 2013 13:49:23 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id vo8sm19045430pbc.5.2013.07.14.13.49.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 13:49:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130714203403.GE8564@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230390>

Jonathan Nieder wrote:
> Johannes Sixt wrote:

>> Sorry, IMO, this goes into a totally wrong direction, in particular, I
>> think that this is going to close to door to make --lockref the default
>> some day in a way that helps everyone.
>
> Would a '*' that acts like --lockref on a per ref basis address your
> concerns?

(Aside: '*' is not a great character for that.  * is already taken in
refspec syntax.  There's no clash but the two uses would be confusing.

	*:
	*:*

Some other single-character prefix could work, such as '.' or '~'.)
