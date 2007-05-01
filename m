From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 0/8] git-repack --max-pack-size
Date: Tue, 1 May 2007 10:36:57 +0100
Message-ID: <200705011037.03213.andyparkins@gmail.com>
References: <463678B7.70409@gmail.com> <200705010926.35265.andyparkins@gmail.com> <7virbc7vue.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 01 11:37:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HionM-0004cE-Fu
	for gcvg-git@gmane.org; Tue, 01 May 2007 11:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031625AbXEAJhM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 05:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031627AbXEAJhL
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 05:37:11 -0400
Received: from mu-out-0910.google.com ([209.85.134.184]:38618 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031625AbXEAJhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 05:37:09 -0400
Received: by mu-out-0910.google.com with SMTP id g7so218502muf
        for <git@vger.kernel.org>; Tue, 01 May 2007 02:37:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=DLWf6WrpefKpxhusPUKviU9Rg60wgafOHfatk0H9hXi+kAmOWmo8UCw+gFKElcg4phVewAuZ2Vkrip20k7J/c1q0wcaWuexvaNXaAyAronBlL+eLHLdd0nTU+KOn/8mLOBYCKisY8VxYvxaRzCbPH3eFnqHbwedWvktlf9Ndfn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MXobvhDLLLVTW3zGD73gC0EcTVkbGtveF8Gjca5hpHvx6VTydkCtcE52XbtDlL7BURvEvL2oWd8A+Hr1zs/DK/bqkyNp3E3bEQni/SoHSdrneNDeddgIiuDnDIJVgsrh9HFlzOnrrzb4/VrptuxuTT6IDtNX59jwUh4+GQ/kyIw=
Received: by 10.82.147.6 with SMTP id u6mr13698440bud.1178012227502;
        Tue, 01 May 2007 02:37:07 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b30sm3946337ika.2007.05.01.02.37.06;
        Tue, 01 May 2007 02:37:06 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <7virbc7vue.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45934>

On Tuesday 2007 May 01, Junio C Hamano wrote:

> But I was not talking about changing describe output because of
> the above argument.  What I was wondering was that it might be a
> good idea to loosen the promise of never rewinding 'next'.  It
> might be easier to view the history of 'next' during development
> for each cycle, if it started afresh after a feature release.

This is an interesting philosophy-of-version-control question.  If two 
identical trees fall in the forest and there is no one there to diff them, 
was a release made? :-)

It's been my experience that failed attempts and dead-end branches are often 
of equal value to the successful branches.  It's very handy when someone 
asks "why can't we do it like this", to be able to answer "look at revision 
xyz onwards".  Even just for your own reference, I've often looked back on 
abandoned paths and thought "that wasn't as bad as I thought, I just need to 
fix it here and here" - if I'd discarded that work it would be gone forever.

It's certainly true in academia, a large part of my doctoral thesis was 
about "things that don't work" :-)  Documenting failure is as important as 
documenting success.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
