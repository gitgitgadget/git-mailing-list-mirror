From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: How to clone git repository with git-svn meta-data included?
Date: Sun, 7 Dec 2008 18:51:24 -0500
Message-ID: <eaa105840812071551w2106eb72k54ec68938628d51@mail.gmail.com>
References: <493A6CEC.4060601@tuffmail.com>
	 <eaa105840812070857i27f8e920keaba3f92f5260b38@mail.gmail.com>
	 <493C1F36.7050504@tuffmail.com>
	 <eaa105840812071230l5e8d54bcg21b36019711bc3cd@mail.gmail.com>
	 <493C47FD.4080302@tuffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Grzegorz Kossakowski" <grek@tuffmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 00:52:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9TQg-00056m-01
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 00:52:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbYLGXv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 18:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752230AbYLGXv1
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 18:51:27 -0500
Received: from rn-out-0910.google.com ([64.233.170.188]:48078 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbYLGXv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 18:51:26 -0500
Received: by rn-out-0910.google.com with SMTP id k40so733384rnd.17
        for <git@vger.kernel.org>; Sun, 07 Dec 2008 15:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=18ugMBJtZTnr9TyA8WzBowoH8LJbGmg/5EvbGRn+OvQ=;
        b=kOxHy4GMjeh8W3W6MMwLMT71FJkWUO+/uy1XNoVNmTquXheuCfWIzPBbZKo03fezl6
         cnW7X4QtRoIzerkesDIT65kuoqGbavbNLEBLtf+/pzKUm446NzCy+GmXDjNjeWRC6n+V
         0h/vAwGj3NuEF6IerCRPleCUMod0b04F3ZSmw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=qkTEe6pMDD+qkhavqPlNYcR5SjJtO6GukBaXz19jPU0Ei0fIUAwGhIpoLlTYNKQRgY
         YDDk9oq/cbFyf/XsD0SolBxd3uSsRHobYjJCJV4w58qFHypzWJEDVxbkO/hwwHNybFCs
         YtoUAaqhoAOktSOdCetN48owwXxPywHXEU0kI=
Received: by 10.64.10.2 with SMTP id 2mr2249312qbj.76.1228693884097;
        Sun, 07 Dec 2008 15:51:24 -0800 (PST)
Received: by 10.65.230.19 with HTTP; Sun, 7 Dec 2008 15:51:24 -0800 (PST)
In-Reply-To: <493C47FD.4080302@tuffmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: e060d82182d5fea8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102512>

On Sun, Dec 7, 2008 at 5:02 PM, Grzegorz Kossakowski wrote:
> Peter Harris pisze:
>> After the git clone, I do the following:
>> git svn init -s svn://repo/sitory
>> git svn rebase
>>
>> No data is transferred[1], although 'git svn rebase' does spend a
>> minute or so reading the commit messages to rebuild its index.
>
> I've tried this method with Cocoon repository
> (http://jukka.zitting.name/git/?p=cocoon.git;a=summary) and got this error:
>
> git clone git://jukka.zitting.name/cocoon.git
> git svn init -s https://svn.eu.apache.org/repos/asf/cocoon/
> git svn rebase
> Unable to determine upstream SVN information from working tree history

Odd. Usually that indicates a lack of metadata, but that repo appears
to contain the right stuff. Beats me.

Peter Harris
