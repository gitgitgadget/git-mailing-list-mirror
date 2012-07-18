From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Extract Git classes from git-svn (3/10) (was Re: Fix git-svn
 tests for SVN 1.7.5.)
Date: Tue, 17 Jul 2012 19:12:01 -0500
Message-ID: <20120718001201.GI25325@burratino>
References: <5004B772.3090806@pobox.com>
 <20120717174446.GA14244@burratino>
 <5005F188.1090203@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 02:12:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrHsK-0004YT-0d
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 02:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757456Ab2GRAMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 20:12:14 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:53241 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757351Ab2GRAMG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 20:12:06 -0400
Received: by gglu4 with SMTP id u4so1038810ggl.19
        for <git@vger.kernel.org>; Tue, 17 Jul 2012 17:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5ND2KrxznW6XJecQA/ysq/f4dveAMarJ3Fp9bQlvrsg=;
        b=nNQ73uPVn7u6v5oVraHguqlix1JFL7SZiCtmsvkZvrGqVM2mKA752MbA9eXNW2hZcC
         R9+xkN+C8CpDGfZve5dRzse1+TaLM/3vV886Gm0pxQIm4aJlFgMPF3lxH+IDcAvU4jfm
         haUz+NNBwKuXJ0dGgfIWbhirXjcOJ2hgA1oJRBaRN+3TwnRk0LpYv6w+583eo647njYu
         ftXicnDk+Eux4ig2U75HyEtk3uCEuU+qRyN1gN8leiwmKqPtHUHjLQEDWk8mQWNUJmfC
         JxMA4JTe0zDhTxJ87HwXERsl52sSmkbADufzmNCOOUdoH9z4bXTB8qhx9wuqOjMoVanc
         koAQ==
Received: by 10.43.85.69 with SMTP id an5mr2588372icc.37.1342570325784;
        Tue, 17 Jul 2012 17:12:05 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id z3sm12938595igc.7.2012.07.17.17.12.04
        (version=SSLv3 cipher=OTHER);
        Tue, 17 Jul 2012 17:12:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5005F188.1090203@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201639>

Michael G Schwern wrote:

> This is a straight cut & paste.  Next commit will make it work.

As mentioned in reply to patch 3, we can't take this, but by swapping
the order of the two patches it should be possible to make it work.

Jonathan
