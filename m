From: David Aguilar <davvid@gmail.com>
Subject: Re: Purpose of "struct object_entry *oe = oe;"?
Date: Fri, 2 Jul 2010 01:48:48 -0700
Message-ID: <20100702084846.GA4682@gmail.com>
References: <8039w681lo.fsf@tiny.isode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Bruce Stephens <bruce.stephens@isode.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 10:49:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUbw7-0006kI-Ej
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 10:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756853Ab0GBItF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 04:49:05 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:34041 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756228Ab0GBItD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 04:49:03 -0400
Received: by pxi14 with SMTP id 14so722397pxi.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 01:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=AUEqRjmPgUNLfUMv6PJxBteX46bGdcy/zndjoQ52AvY=;
        b=eYbM4CRuAXwu08WAcu24iaW8hnPZ0lITrKPzqDDH6vyKCBsDvJSQEx5NbuhCGKUts3
         aAtl7trQnnm0uVAX5NoXYoWzCPK8Kq+CJwQs36b0fTBoMWoy/YixeyZI5JVNCKYZOPw7
         m8a/YaWDcN7JBCZHBcu9GYJme012UId8YgUa0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=R6zRsH8yhXB9CSet5RuUFLaNUc1NL1IpZlFhfJ7B99fwAPvLhiXvhRrADSSQjLVyVf
         z2oH4ou/fgwW50oTDcp/BoXwOjoUZkjxIn89L3qTiypVBbXuog93Lfl/CXtUDgH8Ap1a
         GKxcDlDtQRRWkpbFoD5Y6hoUtu2uIQO7TmZGI=
Received: by 10.142.229.7 with SMTP id b7mr592611wfh.230.1278060539621;
        Fri, 02 Jul 2010 01:48:59 -0700 (PDT)
Received: from gmail.com ([208.106.56.2])
        by mx.google.com with ESMTPS id 33sm530429wfg.9.2010.07.02.01.48.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Jul 2010 01:48:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8039w681lo.fsf@tiny.isode.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150118>

On Tue, Jun 29, 2010 at 01:28:19PM +0100, Bruce Stephens wrote:
> Out of curiousity, where did this convention/idiom come from, and what's
> it for?
> 
> I presume it's to remove a warning ("oe might be used uninitialised") on
> a compiler (or something) that's clever enough to attempt such analysis
> but too stupid to notice that the supposed initialisation is using
> something uninitialised (or perhaps the compiler's deliberately
> recognising the convention?).  Is that right, or does it actually do
> something more?
> 
> I'm mostly surprised that it surprises me.  Is it used commonly in other
> projects?  (It appears not to be mentioned in CodingGuidelines; should
> it be?)
> 
> (First instance in git that I can see is
> 67affd5173da059ca60aab7896985331acacd9b4, 2006.)


There are some good explanations in the list archives.
http://thread.gmane.org/gmane.comp.version-control.git/133278/focus=133422
http://thread.gmane.org/gmane.comp.version-control.git/124676/focus=124803


-- 
		David
