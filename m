From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2] Add details about svn-fe's dumpfile parsing
Date: Mon, 16 Apr 2012 16:39:10 -0500
Message-ID: <20120416213910.GP12613@burratino>
References: <4F8AF306.8070804@pileofstuff.org>
 <7vipgztpaf.fsf@alter.siamese.dyndns.org>
 <4F8C909B.7010507@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Mon Apr 16 23:39:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJtdt-0002p7-Gv
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 23:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262Ab2DPVjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 17:39:21 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63013 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757Ab2DPVjU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 17:39:20 -0400
Received: by gghe5 with SMTP id e5so2777541ggh.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 14:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=d1PKLPlLPbLH2YKjjYSPUNDep2hjgIorpT9bgYBtrhE=;
        b=OpbE5rVEBYsq8OlEubJAI31HXisYimMbnK0yVlSLYeunmWr3PtRpQz2Tw2wKoYLbLz
         4LbirAVvuyxW6lZQFImiipSBjcxfOuvQn9QwpuRpFgPJaUV/n8HFMnXsB3f66FXsNZAH
         NlQAu1Pgh1n4LtPF3XYfjGPDTaVJjpO6eRkHjcEcarZDjpZWSrgMmJrKE40GM05ghrNi
         G0CJvCLuwhkzkblCkhuzf32PnHYvy2pHIFjuRvCLdvMIJ0wLMgbTBIez1HCcFnr/BVVC
         QO00J6kAFYhEjePmjsqJWuMn7OnrxEStGRrbF0V7Bg2Z7v1aEwcBfabF9VDNWNkURHMp
         b9/g==
Received: by 10.50.47.162 with SMTP id e2mr7351126ign.0.1334612359578;
        Mon, 16 Apr 2012 14:39:19 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id us6sm12384517igc.9.2012.04.16.14.39.18
        (version=SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 14:39:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F8C909B.7010507@pileofstuff.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195699>

Andrew Sayers wrote:

> The dumpfile documentation says that "... property key/value pairs may
> be interpreted as binary data in any encoding by client tools"[1], but
> SVN itself interprets the data as UTF-8

Yes, I suspect most of the changes you proposed for the INPUT FORMAT
section would actually be better as changes for the
dump-load-format.txt document.  I imagine that folks on the dev@ list
might be able to clarify a few details (e.g., what one is expected to
do with historical repositories with non-UTF-8 property data), too.
What do you think?

The patch for svn-fe(1) already looks pretty good.  I was planning on
applying it after finding a moment to clarify the patch description.

Thanks again,
Jonathan
