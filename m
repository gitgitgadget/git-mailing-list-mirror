From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG?] push to mirrior interferes with parallel operations
Date: Fri, 19 Nov 2010 15:32:56 -0600
Message-ID: <20101119213256.GA579@burratino>
References: <e355bb33c6192a6a29de56c7be93278e.squirrel@artax.karlin.mff.cuni.cz>
 <20101118175007.GA26505@sigill.intra.peff.net>
 <20101118184241.GN3693@efreet.light.src>
 <20101118190414.GA30438@sigill.intra.peff.net>
 <m2ipzt14rh.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jan Hudec <bulb@ucw.cz>,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Nov 19 22:33:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJYaf-0001WB-4S
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 22:33:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755442Ab0KSVds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 16:33:48 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46670 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755373Ab0KSVdr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 16:33:47 -0500
Received: by qwd6 with SMTP id 6so475066qwd.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 13:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=5j2unCQHnhQfF0g+qyUy1Yb1RmT2NVhN8fhgBlYjkfQ=;
        b=gKITLOJaXAnaUCfEc41/z1s0cZWWYhIIhVK1d4uG8oJj1H2vWJ8xjMbG7Hxkq7ZaAt
         6s2crJ+GMN+2Ng5DVELoy//ifQ2w+7hrH7k+8uAKDZxWfXET1Pq4ynMWx4hwfU5BwUF/
         QghjIdBxOQ4C7v9ruhSpOFj+S3Ch4zCsYrlzo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=p/oqwOxoV2qT9Q/T+9DC96JfR9TEHnktLKJQ0HzEFQfpN4UBsgbWieJ78WycEk1iB5
         FKU99EYZ1qg4Td/g5QC7O/eFYXtTAqA1HVqiD5AFfg/JqGHxTsb0eGCPHu0q3lBKNT0P
         jdSpEPSiFdDzsMROeeR0duOwcPc/1Oq7JOlXA=
Received: by 10.224.74.18 with SMTP id s18mr474394qaj.327.1290202426588;
        Fri, 19 Nov 2010 13:33:46 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id l14sm1243322qck.29.2010.11.19.13.33.44
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 13:33:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m2ipzt14rh.fsf@igel.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161791>

Andreas Schwab wrote:
> Jeff King <peff@peff.net> writes:

>> it really only makes sense to push from a non-bare repo,
>
> Why?  The repo could itself be a mirror.

Jeff seems to have meant

	When in a non-bare repo, it only makes sense to push.

which is to say, push --mirror makes sense from a bare repo but fetch
--mirror does not.  However, I think you read

	When pushing, it only makes sense to use a non-bare repo

to which a reasonable response is to point out that no, push --mirror
makes sense from a bare repo after all.

I see no disagreement here. :)
