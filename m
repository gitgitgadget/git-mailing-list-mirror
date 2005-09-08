From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [RFC] GIT Repository Annotation Convention
Date: Thu, 08 Sep 2005 14:32:34 -0400
Message-ID: <432083C2.6080704@gmail.com>
References: <87ll2aib73.fsf@gmail.com> <431DA8CD.9060009@gmail.com> <432060B8.6080408@gmail.com> <43207B68.5020204@citi.umich.edu>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 08 20:34:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDRCW-0006EL-N6
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 20:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbVIHScl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 14:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbVIHScl
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 14:32:41 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:25581 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964923AbVIHSck (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2005 14:32:40 -0400
Received: by wproxy.gmail.com with SMTP id i2so1231727wra
        for <git@vger.kernel.org>; Thu, 08 Sep 2005 11:32:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=bLSR+17ILbnk4FmVysO8/U/pO5Fr2tgXdDlSQcfKKizG5kpmPJaKgwBymrsrpVVuW8WZWdzcB9JHjW+MB7EqFs5RwvbHf98RRyLFJNmd1kJ6Nbql+ML91o5zkLX5an0mOS4SH5tKaEroMxoiLQDRPkYHlvrR5eH+XRemA/WG/WI=
Received: by 10.54.47.36 with SMTP id u36mr6796216wru;
        Thu, 08 Sep 2005 11:32:36 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.97])
        by mx.gmail.com with ESMTP id 14sm107897wrl.2005.09.08.11.32.35;
        Thu, 08 Sep 2005 11:32:35 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: cel@citi.umich.edu, Git Mailing List <git@vger.kernel.org>
In-Reply-To: <43207B68.5020204@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8209>

Chuck Lever wrote:
> yay!  are you also proposing some git tools to deal with these?  it 
> would be great to have some version control (keep these like generation 
> files so we can see the history of revisions).
> 
> A Large Angry SCM wrote:
>> GIT Repository Annotation Convention
[...]

I'm not proposing any new tools, just a convention that existing tools 
or tools that others may create can adopt to provide information to a 
repositories users. Some existing tools that could use the annotations are:
	git-branch
	git-show-branch
	gitweb
There are likely others.

Like any other file under $GIT_DIR, these files are not automatically 
versioned. Rather, each repository maintainer, needs to decide how a 
repository's meta-data (project meta-meta-data) is tracked or generated.
