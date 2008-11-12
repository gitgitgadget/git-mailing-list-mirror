From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: Newbie questions regarding jgit
Date: Wed, 12 Nov 2008 19:30:39 +0100
Message-ID: <2c6b72b30811121030k73ed42d4q5bea76e2f8198656@mail.gmail.com>
References: <4919EECB.7070408@wellfleetsoftware.com>
	 <2c6b72b30811111337v2fe23c75v25251838f721a007@mail.gmail.com>
	 <491AE2BD.7080103@wellfleetsoftware.com>
	 <491AE91C.4020402@wellfleetsoftware.com>
	 <491B18C4.2070000@wellfleetsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Farrukh Najmi" <farrukh@wellfleetsoftware.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 19:32:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0KVh-0007FB-Jd
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 19:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470AbYKLSa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 13:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752375AbYKLSa4
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 13:30:56 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:3976 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417AbYKLSaz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 13:30:55 -0500
Received: by ey-out-2122.google.com with SMTP id 6so224613eyi.37
        for <git@vger.kernel.org>; Wed, 12 Nov 2008 10:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=nmMc3mL45XcSe6CiSOx0tQbx39cBMv9hqGjHbaKYoa4=;
        b=a7afV25+/UHLgvtsazrkD0hdDap/o+MrNX4g7ZTkoCs9ygy9GHkRGaBd0r8Oxvhg4P
         npWK4DleJ69yIuHoL3Kwsc0zq0PAs0mJmItrfSyI3kqLszONmcrAL8m83OXsKCfOSR33
         AyXsH1CMK3Uy4alOY32fohqsuP2RJWOmFeF/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=CA9Gv4J7l06YaarekURBQE0CWOaNL2Vh6TAZwuxnild7R+7QZjqb0xNi7pZlTxBSVt
         HNmtptZcgXp0FUWYVbsB7i0jtKVlcQiLlZoh2MKL8vMpCVjPP6Vv2xR1shl/qpNZBI6v
         oBs0v2Ttwjocm8gndGxGGDB3mAys2inBUUy9U=
Received: by 10.181.201.13 with SMTP id d13mr1292728bkq.105.1226514640058;
        Wed, 12 Nov 2008 10:30:40 -0800 (PST)
Received: by 10.181.157.5 with HTTP; Wed, 12 Nov 2008 10:30:39 -0800 (PST)
In-Reply-To: <491B18C4.2070000@wellfleetsoftware.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100801>

On Wed, Nov 12, 2008 at 18:56, Farrukh Najmi
<farrukh@wellfleetsoftware.com> wrote:
> So far I have figured out how to get the treeWalk for the path filter as
> shown below.
> Now I am lost as to how to get the blob associated with the treeWalk. TIA
> for your help.

For ideas take a look at how the NetBeans git plugin accomplishes some
of the most common git tasks take a look at the GitCommand.java file.
It contains code for adding and removing files, committing updates to
the index. There is also some code trying to get "git-status"
information, but it is not very smart or clean. Something equivalent
to "git cat-file" (getting the blob data) can be seen at line 120:

 - http://github.com/myabc/nbgit/tree/master/src/org/nbgit/util/GitCommand.java#L120

Sorry, I should have suggested this earlier.

-- 
Jonas Fonseca
