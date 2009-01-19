From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] bash: offer to show (un)staged changes
Date: Mon, 19 Jan 2009 13:42:28 -0500
Message-ID: <46a038f90901191042o6e47c9f7p188542f78f138317@mail.gmail.com>
References: <1232240184-10906-1-git-send-email-trast@student.ethz.ch>
	 <7vwsct2xd1.fsf@gitster.siamese.dyndns.org>
	 <20090119172939.GA14053@spearce.org>
	 <46a038f90901191000i250326e7k2184c149b70fcc8d@mail.gmail.com>
	 <20090119181158.GH14053@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Thomas Rast" <trast@student.ethz.ch>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 19 20:24:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOz6J-0007NG-31
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 19:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752404AbZASSma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 13:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752252AbZASSma
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 13:42:30 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:50538 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404AbZASSm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 13:42:29 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1310752yxm.1
        for <git@vger.kernel.org>; Mon, 19 Jan 2009 10:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=4Z8zEVzNH4mybtIYdZddJBAxaZTt6RuBrHSDkY9uYJE=;
        b=gi+AMpMTh/GmNPxPn1EW8U49WdAFdXB0/+/g/QQV8GSigZEpNGPr/xCWGkmUU/06ZY
         lY4PTkcm1XzpxNi6VuWAxhOhk94Ta9/x5NiF8HiR+ipILJCexERYE6q861WgLDmOFHHj
         f3t1AGX3RAjpOOPwa2vLEttwsiOSZwuRhCzVU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=v4jjQLU/9MGEndPOwnVMMcpY/DLb9dUDcpt9i/Nn4+bzvZ496APUD+AH4UHKgX/PfE
         tVcQSULoQqkeWeJftGrbqAstOjk44KlgWexN5ozOcjfnbYwXEupNYElVJ5HyXheIKxxR
         mpWRWEximgb1uQ8lNZuyvQ5bcR6SX4I6KSZlM=
Received: by 10.100.214.15 with SMTP id m15mr4148433ang.81.1232390548594;
        Mon, 19 Jan 2009 10:42:28 -0800 (PST)
Received: by 10.100.8.5 with HTTP; Mon, 19 Jan 2009 10:42:28 -0800 (PST)
In-Reply-To: <20090119181158.GH14053@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106383>

On Mon, Jan 19, 2009 at 1:11 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> *sigh*
>
> I was hoping it would work well for the really huge repository case,
> like WebKit, where the stats against the work tree just kill the
> user space application.

Even hot-cache? My perception is that in hot-cache conditions the perf is good.

If it is cold-cache, what in the end you are hoping for is "pegging"
some stuff in the cache. Perhaps there's a way to tell the kernel to
skew the cache eviction scheme. Still, if the kernel's algorythms are
good, the kernel knows more about your fs usage patterns than you
do...

cheers,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
