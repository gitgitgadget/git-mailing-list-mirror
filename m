From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Tonight's pushout
Date: Thu, 9 Dec 2010 14:01:43 -0600
Message-ID: <20101209200143.GC6884@burratino>
References: <7v8w01m27t.fsf@alter.siamese.dyndns.org>
 <idotn7$9o7$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 21:02:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQmgr-0002p4-3W
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 21:02:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757003Ab0LIUCC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 15:02:02 -0500
Received: from mail-ww0-f66.google.com ([74.125.82.66]:62733 "EHLO
	mail-ww0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756632Ab0LIUCB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 15:02:01 -0500
Received: by wwb24 with SMTP id 24so1021505wwb.1
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 12:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Kf1MfvkOom2VDum2w2nniFdxUXckApT2ijATwdhvNDY=;
        b=d5QdpXdtTQ9kOnCjL7a8jHknI0P9ZZ7pEPZclvozhAVEN09+vppFx1Qv8/izHpakgI
         hP2KGAWO2fSySoQyyDdQPL1+UNfTCTw8PbkCU2wh3n2Y7Y8Ail24e2hDejsNYcyBuE5L
         WJKwGjpFwEnjwHBjIY9Fc02+Wv82LZrJuGz4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UFqg6TVcdK5G/hZI94gIpf/XACuvtQcKDnTe7JwLHDcf2cd3Oq3WAR0bQGV6SgRjK4
         dfz3tWzyxdEUjwyQFmf7x+Cqz2U/PycLK2dme8oo/X1uLrtucnUe3+jkSK6r4WijaF64
         kMaGjYykDhlERaTZ6BWX7YI8ak9ldmzBroBwg=
Received: by 10.227.144.9 with SMTP id x9mr11003820wbu.76.1291924919416;
        Thu, 09 Dec 2010 12:01:59 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.sbcglobal.net [69.209.58.175])
        by mx.google.com with ESMTPS id 7sm1081638wet.0.2010.12.09.12.01.57
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 12:01:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <idotn7$9o7$1@dough.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163309>

Neal Kreitzinger wrote:

> "prerelease freeze" is not in the git-workflows manpage.  I'm interested in 
> how you-all do this because I use the git-workflows mangpage to help me 
> figure out my workflows.  Can someone explain?

See http://en.wikipedia.org/wiki/Freeze_(software_engineering)

In git's incarnation of it, presumably the idea is that new features
do not get merged to 'master' (while they still would be merged to
'pu' and perhaps 'next').

See also <http://sites.google.com/site/maintnotes/> for some direct
discussion of the branches used by git.git.

Hope that helps,
Jonathan [1]

[1] Unrelated note: please try to preserve the cc list in replies
(i.e., "reply-to-all-by-mail" rather than "followup").
