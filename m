From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH v4] git remote: Separate usage strings for subcommands
Date: Thu, 19 Nov 2009 09:51:18 -0500
Message-ID: <32c343770911190651w3f1ac9b6i2d3b1a62a032489f@mail.gmail.com>
References: <4B04B4A2.8090001@gmail.com>
	 <20091119124040.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, jrnieder@gmail.com,
	git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Nov 19 15:51:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NB8M1-00077J-M7
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 15:51:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749AbZKSOvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 09:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752261AbZKSOvO
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 09:51:14 -0500
Received: from gv-out-0910.google.com ([216.239.58.191]:58123 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbZKSOvN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 09:51:13 -0500
Received: by gv-out-0910.google.com with SMTP id r4so397232gve.37
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 06:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=P41YGkyQOqVb8QqbR1t/gS1LqLSHVc+CFOctsTQoEuM=;
        b=uS1gJi593/NqHF9lvjsUaUd2X9dleNeDvcD6+Cj9Lr/ACx9nPCYzvCtb1hpHkwae1x
         aAFCILmJKRkqfgg+3WrWOoszHQSGqs4QNagnKs1B0wby7jRZE8AcSWv7LOvytz7++Etd
         4FxLipGpEcgzftbM3MFXl+sceJK42NIwk1zok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=chdCYMX63EklJiMoeM8arigseuYPRHoHoFuLrFrFCS4AOcrs12KBBzTt/MYy2EfIu1
         sHbQmGZGPEREZJz19XbMAkJg4BZ29vstW7WuGFPcovF69+h8/bbEFEPugU3759cQlRiX
         Tgfd9KTSZfGXaoDlctu76kixpbzaOuEVo2zuM=
Received: by 10.216.93.1 with SMTP id k1mr15974wef.151.1258642278221; Thu, 19 
	Nov 2009 06:51:18 -0800 (PST)
In-Reply-To: <20091119124040.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133230>

On Wed, Nov 18, 2009 at 10:40 PM, Nanako Shiraishi <nanako3@lavabit.com> wrote:
> Quoting Tim Henigan <tim.henigan@gmail.com>
>
>> When the usage string for a subcommand must be printed,
>> only print the information relevant to that command.
>
> I think this is a huge improvement.
>
> Often people look at this part of the manual page to quickly remind
> themselves what options are available, and it is better to keep the
> current text. Some manual pages have to use [options...] when there
> are too many to list, but each subcommand of git-remote doesn't have
> that many options.

... snip ...

> For the same reason, I don't think this is a good change, if these
> lines are used to show the first lines of 'git-remote -h' output.

The original version of this patch [1] left the contents of the usage
strings intact.  However, Junio expressed a preference to change
them to use the generic <options>.  See this thread for the
discussion [2].

[1] http://article.gmane.org/gmane.comp.version-control.git/133048/
[2] http://thread.gmane.org/gmane.comp.version-control.git/132968/focus=133050
