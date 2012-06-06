From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] fmt-merge-msg: add a blank line after people info
Date: Wed, 6 Jun 2012 15:46:59 -0500
Message-ID: <20120606204659.GA13858@burratino>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org>
 <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com>
 <7vipii27ka.fsf@alter.siamese.dyndns.org>
 <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com>
 <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org>
 <20120312071121.GA17269@burratino>
 <7vipi9mfhx.fsf@alter.siamese.dyndns.org>
 <20120511103122.GA19573@burratino>
 <7vipg2jpzp.fsf@alter.siamese.dyndns.org>
 <20120606202703.GA13641@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 22:47:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScN8Z-000613-KO
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 22:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754989Ab2FFUrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 16:47:12 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50540 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062Ab2FFUrL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 16:47:11 -0400
Received: by yhmm54 with SMTP id m54so5279737yhm.19
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 13:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Mc+3wUZPobEEa/m/f9CiBzuCuggqSz0NCojx8oGgDG8=;
        b=TACTcSO/OY3nejjRtt/7UFLB6YyIh5ylS6twaFOILwUeF86dszhncwzIbjS6TIB9oV
         RyrcPFrhExF4T2QBmIts7pY25UJgaYnzsNd0YJ0br9FDfgUk56KHTAdxC8rF5EKTIMfw
         hnqXNlizEUvVkP/h96ldV9gL94WkUO2Me9UDMQkbu/1JaQAFK4v5yKHXe3wg+b0D9YXC
         F3v7ep65+qZI50uBgBOQjW3OYcoX8RXllEx+f4zQseXprsr4FzSHMHnrAbkUDM4ElbRZ
         o3Ul6VzNo2oFK3c9zJgY1gV24HLU49y4QtGJVtcZEWtS3I/6seotjazfVFwLcakFF42a
         ZoGA==
Received: by 10.42.130.68 with SMTP id u4mr2401758ics.17.1339015630526;
        Wed, 06 Jun 2012 13:47:10 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id gw4sm1092779igb.6.2012.06.06.13.47.05
        (version=SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 13:47:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120606202703.GA13641@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199353>

Jonathan Nieder wrote:

>  * Junio mentioned what sounds like anothing infelicity in the current
>    format: for octopus merges, there is not just one list of authors
>    and submaintiners summarizing what the merge commit does, but
>    separate By and Via lines for each branch being merged.

Sorry for the lack of clarity.  This should say

	                           ... another infelicity ...
	... submaintainers summarizing ...

In other words, I think the objection given to the patch upthread was
a real one, but that a more appropriate fix than using strange spacing
would be to combine statistics from all branches being merged.

Thanks for your thoughtfulness.
Jonathan
