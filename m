From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] bash: offer to show (un)staged changes
Date: Mon, 19 Jan 2009 14:12:20 -0500
Message-ID: <46a038f90901191112p6626c670md219191d6bc46725@mail.gmail.com>
References: <1232240184-10906-1-git-send-email-trast@student.ethz.ch>
	 <20090119172939.GA14053@spearce.org>
	 <46a038f90901191000i250326e7k2184c149b70fcc8d@mail.gmail.com>
	 <200901191306.49979.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Mon Jan 19 20:32:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOzZC-000072-WC
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 20:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913AbZASTMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 14:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753853AbZASTMW
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 14:12:22 -0500
Received: from yw-out-2324.google.com ([74.125.46.31]:63469 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700AbZASTMV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 14:12:21 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1319145ywe.1
        for <git@vger.kernel.org>; Mon, 19 Jan 2009 11:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=IPBWE/Axhwrzgj+UKfy83FiR6ZtDDmADLf9Ghvc/pyI=;
        b=JsdiVpck0NJBw5A//j7DHFrVTarLUUkDRCNI/qTdF2iEakR+sEKv2tFP3arAFk9mCd
         MXEKkj+nG809LS2tPG6xU3kB7w0H+aOrH02U2pV7dJ1plHaESr6I/CrwWlgLdXyy0M3k
         Me6pAplKxxcwlor2LQHX8EHyBf9iNab49gm6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=BPEoTQ5O+GJs3zTNvIIREfuLRxUNhqzF59hFs0Uq5AYhuoYzjStRVyYj3YQKjPKdkI
         O+hWrVdoosX+4a0IL/KbX5flopRqN+BindlKHTZJZIgPd9cKxq2J4n1GA2JvLMM2tmSi
         N2PU7ViCql130nPCY7KLxQy6IyJf5wAgusNTg=
Received: by 10.100.119.17 with SMTP id r17mr4180578anc.61.1232392340296;
        Mon, 19 Jan 2009 11:12:20 -0800 (PST)
Received: by 10.100.8.5 with HTTP; Mon, 19 Jan 2009 11:12:20 -0800 (PST)
In-Reply-To: <200901191306.49979.bss@iguanasuicide.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106385>

On Mon, Jan 19, 2009 at 2:06 PM, Boyd Stephen Smith Jr.
<bss@iguanasuicide.net> wrote:
> Really?  Why have inotify then?  I thought its only purpose is "to keep track
> of the fs".  If it is never a net win, why even use/provide it?

Lots of programs want to monitor _one file_ or _one directory_. Cron
daemons monitor /etc/cron.*/ , incron monitors /etc/incron.d/ ,
programs that watch mailspool directories can be made more efficient
this way too.

You might find your system today has perhaps a dozen inotify watches.
Judiciously used, it's great.

cheers



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
