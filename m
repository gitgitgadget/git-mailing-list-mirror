From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [JGIT PATCH 2/2] Move pathOf to RepositoryTestCase and use it for locating test files
Date: Thu, 4 Sep 2008 10:16:57 +0600
Message-ID: <7bfdc29a0809032116x64448e38s55f512f261e88a62@mail.gmail.com>
References: <20080903091022.GC23406@diku.dk>
	 <20080903170904.GB28315@spearce.org> <20080903214818.GB6316@diku.dk>
	 <20080903230216.GI28315@spearce.org> <20080903235711.GA18666@diku.dk>
	 <20080904040929.GA3633@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jonas Fonseca" <fonseca@diku.dk>,
	"Imran M Yousuf" <imyousuf@smartitengineering.com>,
	"Robin Rosenberg" <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 04 06:18:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb6IP-0004Cj-N7
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 06:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbYIDERB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 00:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbYIDERA
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 00:17:00 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:51985 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbYIDEQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 00:16:59 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1806793yxm.1
        for <git@vger.kernel.org>; Wed, 03 Sep 2008 21:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=bD3t9yJqjXP05bEPfzx+pnKY9RdTxLq6HE5ruzNzZO4=;
        b=RLBq45jVaUHDCVYtfBYpduzZpODSvW6q1Tc12nQ12auaDyTEHQUBn3UK4KJ39Wvm0C
         3R4KkaJHaO9+K06a2Rn9mG0jbV4SxZT99y3GPHrW/c0cc3rNKBCMNWmnibAkm49pQKk3
         kcBtyKuqc6nVPL3hvt1K+qynd2YtA5kZlECVE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=X7lHJ2vcM7ZffmYGgEBGzjaQ2s+RiBCV/dHpE6ZXeJ51zVaSNwViIYdEnQ35tUBtdE
         5gL6Cmo81yEMZyNVlagnZwllsFvvXkI9FuXCBctB/HzgtlxslJZHOogvOAUuBF7qRv4X
         aoPpzKwPfWJnHBoVzYJnxhux7qFhRgESY//C4=
Received: by 10.151.48.15 with SMTP id a15mr13655480ybk.146.1220501817826;
        Wed, 03 Sep 2008 21:16:57 -0700 (PDT)
Received: by 10.150.54.11 with HTTP; Wed, 3 Sep 2008 21:16:57 -0700 (PDT)
In-Reply-To: <20080904040929.GA3633@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94889>

On Thu, Sep 4, 2008 at 10:09 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Jonas Fonseca <fonseca@diku.dk> wrote:
>> BTW, I have started a JGit tutorial on the EGit wiki. For now it
>> mostly consists of stub sections, but I hope to put more work into
>> it in the days to follow. "Best viewed" via:
>>
>>  - http://code.google.com/docreader/#p=egit&t=JGitTutorial
>
> This is quite nice.  I like the starting page, where you walked
> through some of the command line tools.  Well written IMHO.
>

A great and welcome initialive.

Best regards,

Imran

>> Ideas and improvements for the topics and general structure are very
>> welcome. The structure is given in the TableOfContents page.
>>
>>  - http://code.google.com/p/egit/wiki/TableOfContents
>
> This also looks good.  When I can find some time I'll try to fill
> one of these in.  I'm not sure my writing is quite as good as
> yours though.  ;-)
>
> --
> Shawn.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557
