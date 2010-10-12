From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Documentation for git gui blame
Date: Tue, 12 Oct 2010 12:50:50 -0700 (PDT)
Message-ID: <m3iq176vh2.fsf@localhost.localdomain>
References: <4CB48909.6050708@workspacewhiz.com> <4CB48C5F.2030007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 21:51:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5ksM-000722-Vg
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 21:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754834Ab0JLTu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 15:50:56 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45578 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754453Ab0JLTuz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 15:50:55 -0400
Received: by bwz15 with SMTP id 15so2686207bwz.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 12:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=HEbjJYY6YZ0U5cZcSa2l5rv4wt1ZNm/FIs1XtBJzLUE=;
        b=m9h8E908i7CfORL6ZvdIZu9NYLNGqZ030fvPtuwjDoLLmhP9wIhB5ClJJqC9QG2ruL
         NXbPFxete4UBafJDjnKv0LhMJNok1pltTNKZ7hmUW3P3pmBNv45P9wVjkxyfgxjTT04B
         A4p8FW+6Dt3IeE9ehvD6EpzUgiptUvNBX1Sdg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=D/isjEDi5MXp/oS5xzgr64sgTb6/CUKkM3ITI3plaMs6YK9RJlevI885KhxFIxJImh
         9v8oYSKxprUVupvnDKJpGFNN25UhPL/x9XQH4phd4VXxnSiVBQ+XHI+GkOI8TzijN0xT
         0uoberhYzxPVlEF6AFDvZyc+FC0O9FNfgufhk=
Received: by 10.204.113.20 with SMTP id y20mr6161484bkp.170.1286913052643;
        Tue, 12 Oct 2010 12:50:52 -0700 (PDT)
Received: from localhost.localdomain (abve214.neoplus.adsl.tpnet.pl [83.8.202.214])
        by mx.google.com with ESMTPS id y19sm7301529bkw.18.2010.10.12.12.50.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 12 Oct 2010 12:50:50 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9CJpGBl003681;
	Tue, 12 Oct 2010 21:51:26 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9CJp5uM003677;
	Tue, 12 Oct 2010 21:51:05 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4CB48C5F.2030007@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158873>

Chris Packham <judge.packham@gmail.com> writes:

> On 12/10/10 09:12, Joshua Jensen wrote:
> >  Is there any documentation for git gui blame 
> 
> Not sure but it's displaying the same info as git blame so start with
> man git-blame. That probably covers most of what you want to know
> 
> > that explains what the two left columns containing 4 letter SHAs are?
> 
> These are the first 4 characters of the commit id that last
> added/changed that line of code.

Note that there are *two* columns because one column contains plain blame,
and second contains blame with code movement and copying detection and
discarding changes in whitespace (like "git blame -C -C -w").  So if those
columns are different, one column would show commit that put code here,
and the other would show commit that changed this code.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
