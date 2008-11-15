From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH v2 04/11] gitweb: optional custom name for refs in git_heads_body
Date: Sat, 15 Nov 2008 11:11:16 +0100
Message-ID: <cb7bb73a0811150211g1a48f0d1m184bbe193dea6542@mail.gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1226616555-24503-4-git-send-email-giuseppe.bilotta@gmail.com>
	 <1226616555-24503-5-git-send-email-giuseppe.bilotta@gmail.com>
	 <200811150032.14558.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 11:18:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1IEI-00045k-Sx
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 11:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619AbYKOKLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 05:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753609AbYKOKLS
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 05:11:18 -0500
Received: from ik-out-1112.google.com ([66.249.90.180]:62174 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536AbYKOKLR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 05:11:17 -0500
Received: by ik-out-1112.google.com with SMTP id c29so1464090ika.5
        for <git@vger.kernel.org>; Sat, 15 Nov 2008 02:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=jja470LqzGBKhJDwZZvO7v7XQ3UEKez06gYeEi0ljww=;
        b=BJ0BcIYSBI1ZZab9YNivkpfRx1vztoo1n5kW/mYW83iwRpny3mIy3Djg34YeACkJd2
         L2KGw2sXqK6OFBNAd6rkRUzz4zDqtM5JQ211mYmmgp7Wnf3GCnzUISCvQKa4aCWaBDxi
         ohUEESeVezlrS/FiZ4RZW6EszfZOaiV4py/xI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ca5nOQqWXISx9+HnV30H7tt6ZnfwJh3562ypKVaT+puQtSJTj2fC1jHygEMurOlwzi
         WcI/J0wItrXSeMPCaye5tJRV853YgmYhcSg7luEGvni9zs/zuB3yHovDHF8srhF0WAxb
         W0cce1dixFuSwgCdVPxokXCeK+FWVMk1fl/vg=
Received: by 10.210.46.4 with SMTP id t4mr1988451ebt.166.1226743876191;
        Sat, 15 Nov 2008 02:11:16 -0800 (PST)
Received: by 10.210.132.16 with HTTP; Sat, 15 Nov 2008 02:11:16 -0800 (PST)
In-Reply-To: <200811150032.14558.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101055>

On Sat, Nov 15, 2008 at 12:32 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Thu, 13 Nov 2008, Giuseppe Bilotta wrote:
>
>> We make a clear separation between the hash reference and the displayed
>> name for refs displayed by git_heads_body. This can be used e.g. to
>> group them and display only the distinct part of the name.
>
> It is not clear for me from this commit message what this patch
> is meant to do. Already git_heads_body (and also git_tags_body)
> uses $ref{'name'} for display, and $ref{'fullname'} for linking
> (to avoid possibility of tag/branch name conflict).

>> +             my $hname = $ref{'hname'} || $ref{'fullname'} || $ref{'name'};
>
> I don't remember setting $ref{'hname'} anywhere; if there is a patch
> that sets this, it should really be squashed together with this commit.
> Otherwise the commit is not standalone, as it should be.

The patch that sets hname is the next patch (the one that introduces
git_split_heads_body. It's quite obvious that this whole 'split head
lists' part needs some rethinking.

-- 
Giuseppe "Oblomov" Bilotta
