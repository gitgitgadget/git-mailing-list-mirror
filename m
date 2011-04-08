From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: GSoC proposal for svn remote helper
Date: Fri, 8 Apr 2011 02:11:53 -0500
Message-ID: <20110408071153.GA23051@elie>
References: <BANLkTinYyxxkZpmEF2PYXMb_BjCVcbTkYw@mail.gmail.com>
 <BANLkTinHE-E5_mK8aKYv2f7yExVvfOFVRw@mail.gmail.com>
 <20110408052126.GA22256@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, artagnon@gmail.com, david.barr@cordelta.com,
	srabbelier@gmail.com, Eric Wong <normalperson@yhbt.net>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 09:12:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q85rT-00039C-8U
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 09:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754868Ab1DHHMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 03:12:01 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59033 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754740Ab1DHHMA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 03:12:00 -0400
Received: by iwn34 with SMTP id 34so3205211iwn.19
        for <git@vger.kernel.org>; Fri, 08 Apr 2011 00:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=qq2swG57nRTC8y169N/k9NlH+Q10+oJw8yhVVOH18TI=;
        b=hn+9l3qvskeT0HhoNNy+yNLJlZGG2ANnd9Uw/ktvUq9apgdcPtiJUHTGAgAYGAiO8t
         u73KrcGgJt+iLiaeSulhBrMUBYzUYYpdTi1N+hVhidsQkF915Hdc4GtzxEfBRwgTRfHL
         fvSSicS+1/757miL3JxQh0uZJpadUsYxHJjSc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jChuBgE3FSuRV2orMCG7tXdRsotQxrBpdfj0yaGeriOKJ2tzFaOLfWFGX/5Juv2NTL
         iwj4ZCU/CCWYKdrSPS6m65cVWPh3gNDgYvubUaqJicqjsSvmPgbEtkdlqopeOrWgBdQk
         R7GVVQiWJhdIx7BjIQG1xIsD3zstXObTrkpHY=
Received: by 10.42.159.201 with SMTP id m9mr2945921icx.244.1302246719596;
        Fri, 08 Apr 2011 00:11:59 -0700 (PDT)
Received: from elie ([69.209.53.77])
        by mx.google.com with ESMTPS id d9sm1682890ibb.36.2011.04.08.00.11.57
        (version=SSLv3 cipher=OTHER);
        Fri, 08 Apr 2011 00:11:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110408052126.GA22256@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171111>

Hi again,

A small clarification.

Jonathan Nieder wrote:

> As mentioned before, this sounds very ambitious.  Once we have a
> timeline showing how this breaks down into small steps it should
> hopefully be clearer way.

Agh, that sentence doesn't even parse.  I ought to have have said:
"Breaking the task into concrete steps will make it easier to see what
is realistic."
