From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSoC idea: adding JavaScript library / framework in gitweb
Date: Sat, 24 Mar 2012 19:49:04 +0100
Message-ID: <201203241949.04956.jnareb@gmail.com>
References: <CACeyogcFJoUyAiTReDJK_nCMGBp+23OjcS407A1X=fqFR+aGag@mail.gmail.com> <201203241417.10478.jnareb@gmail.com> <CACeyoge7_=aigOnJiXvp=SfVaBVO+4Or_x7Jcnmw-3pj8+VtoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: chaitanyaa nalla <nallachaitu@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 24 19:49:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBW1a-0007tH-4e
	for gcvg-git-2@plane.gmane.org; Sat, 24 Mar 2012 19:49:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754325Ab2CXStI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Mar 2012 14:49:08 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:54029 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716Ab2CXStH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2012 14:49:07 -0400
Received: by wibhj6 with SMTP id hj6so3041230wib.1
        for <git@vger.kernel.org>; Sat, 24 Mar 2012 11:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=7LY9zR9fncL5x/WicuRWghyh4TsEAVjFq8lQk2/HasE=;
        b=MVNgDtQAGtZj+8/DcUvpvqSJibgQV6m2zUCHuhlfV8uHAA1XbwylyOib7wqDW4UUkB
         7hYe60M/AYrYaql+legIzB7ZIQgDcXqhzAH7AGi8lk4BVk8OIFIbN5Ilffj0gZs0E4nw
         KurSlHDUZffZDUdjK94jDBIG11oRbkSsDVd8kupB1Q4N/nWLJWY+5FxsKJUbmbuh5UDH
         kpXUk3RrWXh7LxmISLcU/4VBAtncTtOufg/+Fsf2PmX1OZKlfroMo62eQfzJEXDox3TF
         j8MMpTB6wCRfBmcDHyK70Spt6kMSfzppjja/RIuk2BzQAQNhoxFLhsleTLvXKr7ispau
         1xdA==
Received: by 10.180.79.72 with SMTP id h8mr6604223wix.1.1332614946077;
        Sat, 24 Mar 2012 11:49:06 -0700 (PDT)
Received: from [192.168.1.13] (epw177.neoplus.adsl.tpnet.pl. [83.20.64.177])
        by mx.google.com with ESMTPS id fz9sm25062349wib.3.2012.03.24.11.49.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 24 Mar 2012 11:49:05 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <CACeyoge7_=aigOnJiXvp=SfVaBVO+4Or_x7Jcnmw-3pj8+VtoA@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193837>

On Sat, 24 Mar 2012, chaitanyaa nalla wrote:

> Dear Jakub ,
> 
>  could you please suggest any other ideas or features so that i can
> think upon them and come up with further good ideas.

One idea for additional feature that I have already mentioned, and which
I have put on https://github.com/peff/git/wiki/SoC-2012-Ideas is
client-side sorting of tables, e.g. of list of all projects, a la
jQuery / MediaWiki (Wikipedia) "sorttable".

Another would be using deferreds or queues for interactive blame, so
that repainting (editing DOM) happens asynchronously to avoid locking
up browser, like in 
  http://www.nczonline.net/blog/2009/08/11/timed-array-processing-in-javascript/

There was also some time ago a patch that added ability to mark a commit
to compare current commit to (using JavaScript and cookies), to have an
UI to compare arbitrary commits using 'commitdiff' view.  Or something
similar to MediaWiki (Wikipedia) page history view. 


Yet another would be support for graphical representation of history in
'log', 'shortlog' and 'history' views e.g. using Raphael.js

Perhaps it would be possible to employ some JavaScript syntax highlighter
to pretty-print contents of 'blob' view.


Hope That Helps.


P.S. You can see gitweb at work here:

  http://git.kernel.org/?p=git/git.git
  http://repo.or.cz/w/git.git
-- 
Jakub Narebski
Poland
