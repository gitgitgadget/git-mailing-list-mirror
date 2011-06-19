From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 04/20] t5800: document some non-functional parts of
 remote helpers
Date: Sun, 19 Jun 2011 17:02:46 -0500
Message-ID: <20110619220246.GE23893@elie>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
 <1308496725-22329-5-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 20 00:03:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYQ5C-0006sV-Nc
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 00:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799Ab1FSWCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 18:02:53 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47365 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366Ab1FSWCw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 18:02:52 -0400
Received: by iwn6 with SMTP id 6so719771iwn.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 15:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=y3gdR/xp417al1cDycZOwaYzMaVxY96MiwPM6wns02g=;
        b=wehJgND7qQehvBmCQgOGDBFgkVr4u3MHfx0fUgLEDvNu57YxQRL6GnYi8gj92K1dsT
         5gPcCBzGgEJn/IVf1fYWeXR6RsuyFpubhFnmRp0D7UyJ4J0d8980w77oir6QPcm3+I8R
         cxcmALh9USIAb2ykZPjzGvOZFpYQu2X6sccgo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=eoM7ObcKsp9xvFsrMN2HQtNBZxP0VF2Olu9kYZg0q3s2l92OpzJEGwzq/1fQxyh8QT
         HE2WLXEdighS8O5es09V9uGPqYY87y9PmcPg603FpyqAXZYZSZClWc2PfbgotReCg+WM
         QVsEhbmfjFq9BRS3DNprG9KCXJIp84GQPThzU=
Received: by 10.42.173.9 with SMTP id p9mr5353718icz.268.1308520971972;
        Sun, 19 Jun 2011 15:02:51 -0700 (PDT)
Received: from elie (adsl-69-209-50-158.dsl.chcgil.ameritech.net [69.209.50.158])
        by mx.google.com with ESMTPS id hp8sm4877286icc.23.2011.06.19.15.02.50
        (version=SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 15:02:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1308496725-22329-5-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176029>

Sverre Rabbelier wrote:

>   Culled the part of the commit message that is discussion of a
>   possible implementation, but kept the parts describing the tests
>   and why the last one is failing.

Looks good.  What happened to the extra tests (e.g., push tag)
mentioned in the last round?
