From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2] Add details about svn-fe's dumpfile parsing
Date: Sun, 22 Jul 2012 20:37:39 -0500
Message-ID: <20120723013739.GC3390@burratino>
References: <4F8AF306.8070804@pileofstuff.org>
 <7vipgztpaf.fsf@alter.siamese.dyndns.org>
 <4F8C909B.7010507@pileofstuff.org>
 <20120416213910.GP12613@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Mon Jul 23 03:37:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St7av-0006c1-2V
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 03:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814Ab2GWBhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 21:37:47 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:50568 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796Ab2GWBhq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 21:37:46 -0400
Received: by gglu4 with SMTP id u4so5008934ggl.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 18:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fak+MGgiz0zrsUcZh8kQCn4hHkO0iCS/jMLK/MfHIvI=;
        b=nWGMx8/1MwXoZOMZSyvT8Yn1OEqWjyknwED5Zpfz72rLLhxVB+bEklOQeIHoGyitAK
         fKZZNZuTY998tMUQXcDFoYIlZepoCOVrF/dlSwW2O0AluO70ugLlqdieU8zAmT6tdZIG
         WHDl6mFVaMWeDgxtMwdpQwS841IzCw2fpjicbPEAbz0WsyYl+rstIAbFMCPMFOhbjie/
         2UZsXqIHU5yFEtoY0puIsI2zWo9KG3hjOtzIeOsRi34rzJGrBdDXyqUnlhD8hYIkMvo2
         eKlPqCwyPC8fFe1fyPXshLDB5Ugp80hj09OSTBjf1z/vPfxdcqhXYUnb2e01gvtIEItO
         +B5w==
Received: by 10.50.156.196 with SMTP id wg4mr9428039igb.54.1343007465517;
        Sun, 22 Jul 2012 18:37:45 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id bo7sm10895172igb.2.2012.07.22.18.37.43
        (version=SSLv3 cipher=OTHER);
        Sun, 22 Jul 2012 18:37:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120416213910.GP12613@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201878>

Hi Andrew,

In April, you wrote a nice patch[1] for the svn-fe(1) manpage
clarifying some of its limitations.  I was hoping to offer some
patches to squash in to polish some of its more confusing edges and
then apply it, but time for polishing ended up being scarce.

Can you remind me of the current status of the patch --- e.g., is the
version at [1] the latest version?  Do you think it's ready as-is or
would you have suggestions for a person wanting to get it ready for
inclusion?

Thanks,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/195570
