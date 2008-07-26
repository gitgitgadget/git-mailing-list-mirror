From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: Re: Mailing lists, was Re: [RFC] Git User's Survey 2008
Date: Sat, 26 Jul 2008 14:19:35 +0200
Message-ID: <488B1657.4090308@gmail.com>
References: <200807230325.04184.jnareb@gmail.com> <7vabg5r4vy.fsf@gitster.siamese.dyndns.org> <20080725221331.GE23202@spearce.org> <200807261254.53939.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 14:21:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMilP-0000zK-Qv
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 14:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbYGZMTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 08:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbYGZMTm
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 08:19:42 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:31397 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbYGZMTl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 08:19:41 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2709565fkq.5
        for <git@vger.kernel.org>; Sat, 26 Jul 2008 05:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=FbgGG0n96hlK2L8zuPVgokWITPLLceOiR+4wGirO+s8=;
        b=CqRyClulP6S4yXMjr2rmInSRJQ+w3wlSVbSZdtN/1LrGTFJ/WYAyh/ZFUJtYiejTZv
         JXSAzMTlQHsmYS24L0I/FMKrPDq1R24PMil5pUphYFmtvg7Kjcij3zMGAUQag4ekEri5
         ZkbXy+GRdXzp9QTb5nmauWYl/cjg7ETKYxfyk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=HqjaYswbYH1rUgi1Gf4QF3DBM/x8uua2kxyMqcUmDVNifbUxr4Owj0V8JH38ta1OhL
         3IO1v/NcCZGkIff8eJpjnE9O421XGDNzMCspse6hqahzy/rw6g0pq5118yy9v5a8RVgN
         bY9KAkwe4WlTBMcMpuevwhhz+pXZe+9XJYze8=
Received: by 10.103.168.5 with SMTP id v5mr1672357muo.35.1217074777991;
        Sat, 26 Jul 2008 05:19:37 -0700 (PDT)
Received: from ?62.21.4.140? ( [62.21.4.140])
        by mx.google.com with ESMTPS id u26sm27628108mug.4.2008.07.26.05.19.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 26 Jul 2008 05:19:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.15) Gecko/20080615 Iceape/1.1.10 (Debian-1.1.10-1)
In-Reply-To: <200807261254.53939.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90219>

Jakub Narebski wrote:
> On Sat, 26 July 2008, Shawn O. Pearce wrote:
(...)
>> Actually I'd like the editor integration to be broken out (if
>> it isn't already) so we can see which editors (and thus which
>> integrations) are popular among users.  I think it would help all
>> of the integration authors, as well as make it clear to end-users
>> where we have integration available/under development, in case they
>> were not aware of it previously.
> 
> So you would like to see something like the following question in the
> upcoming Git User's Survey?
> 
>    xx. Which editors/IDEs/RADs do you use?
>        (zero or more; multiple choice with 'other')
>     -  Emacs, Vim, Eclipse, KDevelop, Anjuta, TextMate, Notepad++,
>        Visual Studio, other
>     +  what choices should be in the list of editors and IDE;
>        or should perhaps this question be free-form?

If we stay with hard coded list of IDEs, I'd add NetBeans to this list.

I have an impression that quite many folks are asking about NetBeans 
support for Git. Particularly, comparison between number of Eclipse and 
NetBeans users using Git is interesting matter for potential jgit usage.

-- 
Marek Zawirski [zawir]
marek.zawirski@gmail.com
