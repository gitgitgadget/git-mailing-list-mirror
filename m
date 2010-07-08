From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t9118 (git-svn): prevent early failure from taking
 down later tests
Date: Thu, 8 Jul 2010 11:48:35 -0500
Message-ID: <20100708164835.GA17870@burratino>
References: <4C352EB5.5020005@gmail.com>
 <20100708133602.GA1882@burratino>
 <4C35E230.8020202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Torsten Schmutzler <git-ts@theblacksun.eu>,
	Eric Wong <normalperson@yhbt.net>
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 18:49:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWuI2-0001IO-J6
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 18:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023Ab0GHQt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 12:49:29 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35503 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123Ab0GHQt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 12:49:28 -0400
Received: by gxk23 with SMTP id 23so525639gxk.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 09:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=lhHhwgvchoV9/R1z2lcCN3tjm7N2HC7OacczFVM3tZI=;
        b=I+g4I1lnqW0gaWWkHK0NbmPIs9y4ohabl4Q121V57ZEkppIO/678otN021dfhKDv7G
         rg86UBrM8Tb8eRZYwxWcCvVoEYp4KhN3myopzpp20YRT6lAjyM5Y/9musPaZ40Od5Y8T
         zXaN1USvDiMiWW9too05eqPRCpt4d7mccuAic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jYBbnxfdrI5AZSfrp5NgfJmNUlyiXNZoFuROpedU4kpEGwzCP1aFSZmqubbqXGlcyi
         d/WxmtNYBGVL8UeCoWM+igozt7/MBprcyJfJI6kgOzXo3RZcBpPss1zGQzRuCwbTlPOE
         nG5gpNEgpmibqZtbYKYUOPs6g3mpbK5mvCy4s=
Received: by 10.90.98.10 with SMTP id v10mr3150251agb.79.1278607759910;
        Thu, 08 Jul 2010 09:49:19 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 34sm34845174ibi.18.2010.07.08.09.49.19
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 08 Jul 2010 09:49:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C35E230.8020202@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150586>

A Large Angry SCM wrote:

> With this patch, test 2 still fails but the others now pass.

Good, it works as designed then.  Thanks for checking.
