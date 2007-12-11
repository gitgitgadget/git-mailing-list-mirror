From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Fix typo: we require Python 2.4, not 2.5
Date: Tue, 11 Dec 2007 15:02:21 +0000
Message-ID: <b0943d9e0712110702m170ba227g2d2224f4f6af3cf0@mail.gmail.com>
References: <b0943d9e0712100340p78326b4avf2b7e64008bba6d6@mail.gmail.com>
	 <20071211142347.GA22879@diana.vm.bytemark.co.uk>
	 <b0943d9e0712110627g70ad0aecyfeaafd8b8655fb57@mail.gmail.com>
	 <m3r6hts2yk.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 16:02:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J26dF-0008Pg-OS
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 16:02:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbXLKPC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 10:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752299AbXLKPC1
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 10:02:27 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:57215 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282AbXLKPC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 10:02:26 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2064707rvb
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 07:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=fYLqKKWtDJEjh0LDsIkbug/IRSk7DNJmojwdXXwsU5Y=;
        b=NAKpLMaqA4elKgUGLtR1S+t2E3sUnLMe6X19MgXyTp2Dzqv5EuhoTYxxHOoMmZnjKIkbC5UJznVwC0U7fkQA1MveO5qtCvhKKkWKSoGkb0fQ+89aimiLKeOu+oL2ZwSn5NH9isWzi5OrtPJ2JBPDRHHdipdJYRRRVFoes8gM8vQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=xpEvP4pFC7stHc44Q/hueAIK4t5hKBARXMF2F6+U/g1ZyjZj40RLGvjba1JtjQw4o0it2Sya/Veiv3M2Lq3RNYFC/JcPgY8WItG7QWRriaytovTQY+e2NFxq6v2gDnqCuXYrixkPl58lmHQBksIluFahsytbxjN2hAzwL+3yEAg=
Received: by 10.141.189.4 with SMTP id r4mr172632rvp.1197385341882;
        Tue, 11 Dec 2007 07:02:21 -0800 (PST)
Received: by 10.141.186.5 with HTTP; Tue, 11 Dec 2007 07:02:21 -0800 (PST)
In-Reply-To: <m3r6hts2yk.fsf@roke.D-201>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67866>

On 11/12/2007, Jakub Narebski <jnareb@gmail.com> wrote:
> $ rpm -Uhv --test stgit-0.14-1.noarch.rpm
> error: Failed dependencies:
>         python(abi) = 2.5 is needed by stgit-0.14-1.noarch

I use Ubuntu 7.10, not the best system for building RPMs.

> Although I guess that it is something that rpmbuild sets (if not set)
> automatically during building.

Yes. If you know what to add to setup.py, please let me know.

> I'll just download SRPMS (which is available, just not linked from
> download area on homepage).

It's not linked as I always thought people would use the .tar.gz.

What about adding it to cheeseshop.python.org and only run
"easy_install stgit"? The drawback of easy_install is that there is no
easy_uninstall yet.

> P.S. By the way: [application/x-wais-source]?

I don't control the web server my ISP provides. I should move
everything to gna.org but I was too lazy to modify my release script
(for Debian, gna.org even gives information on how to set up an apt
repository).

-- 
Catalin
