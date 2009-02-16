From: Thomas Adam <thomas.adam22@gmail.com>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Mon, 16 Feb 2009 15:25:23 +0000
Message-ID: <18071eea0902160725n2e918883wbc9bfc57be0b7d45@mail.gmail.com>
References: <20090205204436.GA6072@diku.dk> <op.uo9di902a8ed4e@dellschleppa>
	 <2c6b72b30902121424o5d4ac0d7u67a7afb3b861aa19@mail.gmail.com>
	 <op.uo9hiqqqa8ed4e@dellschleppa>
	 <2c6b72b30902151547q5bf183f2q1e846f261825671c@mail.gmail.com>
	 <slrngphgk1.hul.sitaramc@sitaramc.homelinux.net>
	 <2c6b72b30902160410g25e80514q318b65ea4614cdc1@mail.gmail.com>
	 <slrngpj0md.e6h.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 16:26:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ5N2-000599-T4
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 16:26:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbZBPPZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 10:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbZBPPZ1
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 10:25:27 -0500
Received: from qb-out-0506.google.com ([72.14.204.229]:51610 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbZBPPZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 10:25:26 -0500
Received: by qb-out-0506.google.com with SMTP id q18so1870066qba.17
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 07:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=glEkgUMEBdPtMYYBqaBXGipxTbMIwa9BCc6hHsQxCmM=;
        b=iCEaMUXeTuRomSJng4xiWcx4jNBbvU+40T1HiolvaIxUEFJz4xyHQyWZdLzF0Xzz5h
         iTAGxBFLE4fn2j5y6dgRgELK5SlVIozrzRqODPoZAmVZlFV5j1ersrjOMWJHo3u6q4uW
         1lnlSayCCwZATlscqJ87gb+rAAch9tn9U8+8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lodgsDKngyhcD7pA4cA8bnrHRy26YmlUjswkN96Cglg1D+hRp1dFUWnEb1i8Y58NaG
         USLMmLldCTV2yeRWQgtSLXomz36ktV0P6Yn5UDagT/uGCwqUipeu4gzB4B4dX4os+sbd
         40y2CpvWCZXJe/nedz6n4LVAFba9FPi8MFNDg=
Received: by 10.143.32.7 with SMTP id k7mr471767wfj.162.1234797923678; Mon, 16 
	Feb 2009 07:25:23 -0800 (PST)
In-Reply-To: <slrngpj0md.e6h.sitaramc@sitaramc.homelinux.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110190>

2009/2/16 Sitaram Chamarty <sitaramc@gmail.com>:
> Yes I was going to ask about that, having been confused by
> the graph once in a while.  You may want to consider using a
> few other characters than the 4 you currently do (if indeed
> that is the problem).
>
> I'm interested in this too, and I do sometimes have complex
> branch relationships in my work.  I'm no longer much of a C
> programmer but I can certainly help test.

I started work on this last year, but it got pushed further and
further down my todo list.   Basically, there's extended characters
defined as part of ncurses for just this sort of "drawing" operation.

-- Thomas Adam
