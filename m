From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Deleting remote branches with git-branch and reflog questions
Date: Tue, 23 Jan 2007 15:29:38 +0000
Message-ID: <200701231529.40362.andyparkins@gmail.com>
References: <200701231259.27719.andyparkins@gmail.com> <200701231432.24225.andyparkins@gmail.com> <Pine.LNX.4.63.0701231558080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 23 16:29:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9Nao-0005ns-H4
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 16:29:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996AbXAWP3r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 10:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751997AbXAWP3r
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 10:29:47 -0500
Received: from wr-out-0506.google.com ([64.233.184.227]:58388 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbXAWP3r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 10:29:47 -0500
Received: by wr-out-0506.google.com with SMTP id i12so961330wra
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 07:29:46 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kcpz6qK+w8hr9MdhceTOBCzBBrFDodJ3u/Vso9dQ3Ql2VER3Y523C/Wp4kbSgLANZ/iNGq3WqXAbxtBQR6Uo5BwiRNjWlI8lyAAXbGAcrUl6cta6RR3WnlP7jiQA2uetV6PdtiJQNMssAMYVdeeDA6jdmbui93P5mG3FQB6WLQw=
Received: by 10.49.65.15 with SMTP id s15mr1188128nfk.1169566185287;
        Tue, 23 Jan 2007 07:29:45 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id m15sm2917468nfc.2007.01.23.07.29.43;
        Tue, 23 Jan 2007 07:29:44 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.63.0701231558080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37533>

On Tuesday 2007 January 23 14:59, Johannes Schindelin wrote:

> You mean, kind of like a waste bin? Where you delete stuff, but come back
> and whine that you did not meant to delete it after all?

No, no; I'm whining that the reflog was deleted, not the branch.  I think 
that "ref deleted" is just as valid for logging as anything else, and 
deleting the log makes it impossible to view that operation.

Given how powerful the reflog is; it doesn't seem unreasonable to want to be 
able to do

$ git branch -D some-branch
$ git show some-branch@{2 days ago}




Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
