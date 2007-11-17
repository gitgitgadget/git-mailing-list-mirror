From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] user-manual: Talk about tracking third-party snapshots
Date: Sat, 17 Nov 2007 19:18:40 +0100
Message-ID: <200711171918.40981.jnareb@gmail.com>
References: <11949569992214-git-send-email-msmith@cbnco.com> <fhcb29$ef$2@ger.gmane.org> <20071117164501.GB5198@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sat Nov 17 19:19:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItSG0-0003Nw-VK
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 19:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758879AbXKQSSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 13:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757283AbXKQSSr
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 13:18:47 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:11512 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816AbXKQSSq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 13:18:46 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1075224nfb
        for <git@vger.kernel.org>; Sat, 17 Nov 2007 10:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=FVQWBXCW7mgxE+cMeTih7VoPOA479FW+R+SXNMSG6As=;
        b=CwVIpUAhHsOmDs+vnZ1RGyubuYTx3pdq13eWIHAmw7g4YhBHgCcysbwvvrZQ6glYfxJdoZrlBRWnqnAWJmw39RYYQOHRSyEPLxH0PdNWQ65+fHdxJCTqFQ7pn2N5Mn18W9K594FYP6rKBKJQzU1Oa71STBf1kJv+CGskkMpEvBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QvEzZ+7axFJYswa0WdM5VDKwRv0gtioXYyaw4zlUQZkzO343AtDxMSZvrVlKE7OKVXn/sflpIV5JZIxoha/ba44uojpPs6tdPvB3HpOgp45PeiKd+lX81mcbc0J+3i6Bt6whtywmf0hAWeB7I9MzTN+IjSByyqeHNVpdbfAquUo=
Received: by 10.86.81.8 with SMTP id e8mr3073663fgb.1195323524138;
        Sat, 17 Nov 2007 10:18:44 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.236.102])
        by mx.google.com with ESMTPS id d4sm2264947fga.2007.11.17.10.18.41
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Nov 2007 10:18:42 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20071117164501.GB5198@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65293>

On Sat, Nov 17, 2007, Jan Hudec wrote:
> On Tue, Nov 13, 2007 at 15:07:05 +0100, Jakub Narebski wrote:
>> Michael Smith wrote:
>> 
>>> +You can use the gitlink:git-cherry[1] command to display the commit
>>> +IDs that are only present on your local branch, or only on the remote
>>> +branch, respectively:
>> 
>> I think git-cherry is deprecated in favor of "git log --left-right" (with
>> appropriate format, for example '--abbrev-commit --pretty=oneline')

Not true. git-cherry is more than --left-right, as it checks
if changesets matches, not if commit id matches.

> git log has such option?
> 
> $ man git-log | grep -e --left-right; echo $?
> 1
> $ git --version
> git version 1.5.3.5

It has, although it is hidden in git-rev-list(1) manpage. It is a bit
obscure corner...

-- 
Jakub Narebski
Poland
