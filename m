From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Mon, 16 Feb 2009 20:52:19 +0100
Message-ID: <2c6b72b30902161152q3de61b9brad746b25bfcea025@mail.gmail.com>
References: <20090205204436.GA6072@diku.dk> <op.uo9di902a8ed4e@dellschleppa>
	 <2c6b72b30902121424o5d4ac0d7u67a7afb3b861aa19@mail.gmail.com>
	 <op.uo9hiqqqa8ed4e@dellschleppa>
	 <2c6b72b30902151547q5bf183f2q1e846f261825671c@mail.gmail.com>
	 <slrngphgk1.hul.sitaramc@sitaramc.homelinux.net>
	 <2c6b72b30902160410g25e80514q318b65ea4614cdc1@mail.gmail.com>
	 <slrngpj0md.e6h.sitaramc@sitaramc.homelinux.net>
	 <18071eea0902160725n2e918883wbc9bfc57be0b7d45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: Thomas Adam <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 20:53:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ9XK-0001Ui-Gb
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 20:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbZBPTwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 14:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbZBPTwW
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 14:52:22 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:33991 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbZBPTwW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 14:52:22 -0500
Received: by bwz5 with SMTP id 5so3362452bwz.13
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 11:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FVjvvO0CSx9CNlIoBevsKOriLvmg4uQwL6tCoXp9aXQ=;
        b=iLg7IwdvtqV/Ug9L7Y5JDASCEZk6fNaiDWDrXE72zTOwXaeirs0z5zw1hmkMQquPey
         Q1rbM/aTP/sy4UiCSY5hH6pyWRY7pzF1fUk03clCmS2cjUuHB0piFhK99VZMfWCbNuWi
         Lpyh/Zn4/Mu01UGViyEeOoZgNMrkPNCnLRnLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=m72OIyzhTImh0R0fv33UbJ7AD9ZBRK3sVLacEytLfaG8Oh53V7tcPyzBeQHCu/Z70o
         Up0/p4RLL4ZirOeTIhr+cXnBmbpS+wMBoLB22HdPmC0f84bi9aKzEajV3lwXNsjWmIVh
         P9yGY5ZtEa0LR0RfaxoiUE74ErMu1+Zivgww4=
Received: by 10.181.192.11 with SMTP id u11mr2077678bkp.50.1234813939813; Mon, 
	16 Feb 2009 11:52:19 -0800 (PST)
In-Reply-To: <18071eea0902160725n2e918883wbc9bfc57be0b7d45@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110231>

On Mon, Feb 16, 2009 at 16:25, Thomas Adam <thomas.adam22@gmail.com> wrote:
> 2009/2/16 Sitaram Chamarty <sitaramc@gmail.com>:
>> Yes I was going to ask about that, having been confused by
>> the graph once in a while.  You may want to consider using a
>> few other characters than the 4 you currently do (if indeed
>> that is the problem).
>
> I started work on this last year, but it got pushed further and
> further down my todo list.   Basically, there's extended characters
> defined as part of ncurses for just this sort of "drawing" operation.

Yes, I think we need to go for something squarish like qgit and giggle.

With this rewrite I it could also be nice to allow the graph rendering
to be more incremental by changing the commit struct to point to the
parent commits. This will also enable support for moving the cursor to
the parent commit in the main view and calculate information like the
Follows/Preceeds in gitk.

-- 
Jonas Fonseca
