From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] post-receive-email hook: handle order of arguments consistently
Date: Thu, 14 Jun 2007 11:19:17 +0100
Message-ID: <200706141119.18724.andyparkins@gmail.com>
References: <20070614090929.31616.qmail@c76df6d65db410.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Gerrit Pape <pape@smarden.org>, Junio C Hamano <junkio@cox.net>,
	428413@bugs.debian.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 14 12:19:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HymQl-00065B-Ux
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 12:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbXFNKT1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 06:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbXFNKT1
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 06:19:27 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:14625 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbXFNKTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 06:19:25 -0400
Received: by ug-out-1314.google.com with SMTP id j3so626823ugf
        for <git@vger.kernel.org>; Thu, 14 Jun 2007 03:19:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=IdyyNu5AO86ecyux/X5aEXolQQrg9SsvDbP6A7hKeUVo2MsFntNboZ3SwwvGbBiwLu/SF0eS5KvbHU1WSKJJ+dH37Oq9jhWJBnav+VIr9rfURfacYBA5HOm2wuaSSaF35y9Tyktm9AmyV7y7YqquUHkilmaIpEVwX7t3QjKxdck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=g77z0GrGV0DAP5KXkyjCR6ookZr30+WOXpkD5QbW2YoH2DYfBGjdTKOTzid9FLGa8nRwi7flYAiqKk0bN6fJzwrm2y9d3/df2fM6YdiNtYY90nNLPH2Tp5gw3TnWT97Ww9UE4qGf1g3L0Toq4ToXOPaLa5PYb7riEAYp/hcbBno=
Received: by 10.67.98.4 with SMTP id a4mr1979759ugm.1181816363654;
        Thu, 14 Jun 2007 03:19:23 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id z40sm3873248ikz.2007.06.14.03.19.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jun 2007 03:19:22 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <20070614090929.31616.qmail@c76df6d65db410.315fe32.mid.smarden.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50187>

On Thursday 2007 June 14, Gerrit Pape wrote:
> The post-receive-email hook usually gets its arguments through stdin, but
> also supports them to be specified at the command line.  The order of the
> arguments should consistently follow the documentation no matter how they
> are passed to the script.

That wasn't done casually.  It was done so that the same script would work as 
an update hook as well.

I have no objection to the change, as the update hook was not the right place 
for generating emails.  However, it let me use that same update hook on a 
system that did not have a git with support for the post-receive hook.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
