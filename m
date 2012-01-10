From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: [PATCH] rebase --fix: interactive fixup mode
Date: Tue, 10 Jan 2012 13:58:04 -0600
Message-ID: <4F0C984C.8040907@gmail.com>
References: <20120108213134.GA18671@ecki.lan> <4F0AA7E2.9010200@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jan 10 20:58:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rkhq6-0000sU-7E
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 20:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556Ab2AJT6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 14:58:10 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42201 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932527Ab2AJT6I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 14:58:08 -0500
Received: by ghbg21 with SMTP id g21so2350774ghb.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 11:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=DQqmfin2WhMgW1laRrNxE+PrRDgaLZp4NpKszrsuTzY=;
        b=i6P3ONYIqpYtphSPfyz3ClCsv+WSUYbaTVQOaRG9p/Tlka1FJohDaT0kItxdZn7SIC
         Q5EivbJQiAo75XQJM8K17vYgOmZmuWoNS2qyeye5dGBHJvE7D0W+ZkFxXIkxmbNMcFAf
         0JLAkCHhwDwSeLNzvG6XHp2mF7OnAVsT3iC1c=
Received: by 10.236.156.7 with SMTP id l7mr29533856yhk.60.1326225488405;
        Tue, 10 Jan 2012 11:58:08 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id h11sm4991659and.7.2012.01.10.11.58.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 11:58:07 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.25) Gecko/20111213 Thunderbird/3.1.17
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4F0AA7E2.9010200@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188289>

On 1/9/2012 2:40 AM, Michael Haggerty wrote:
>
> Two comments:
>
> * The name "--fix" might be confusing because of its similarity to the
> "fixup" command that can be specified in the interactive instructions file.
>
> * I agree with you that "interactive rebase is frequently used not to
> rebase history, but to manipulate recent commits".  In fact, I use
> interactive rebase *only* for manipulating recent commits and
> non-interactive rebase *only* for changing commits' ancestry.  I think
> it is a good idea to make these two uses more distinct.  For example, it
> makes me nervous that I might mis-type the<upstream>  parameter when I
> am trying to touch up commits and end up inadvertently rebasing the
> commits onto a new parent.
>
He could all it --touchup like you did above.

v/r,
neal
