From: Matthew L Foster <mfoster167@yahoo.com>
Subject: Re: merge time
Date: Mon, 30 Jul 2007 10:06:59 -0700 (PDT)
Message-ID: <28948.8052.qm@web51002.mail.re2.yahoo.com>
References: <46AE1100.2020005@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Mon Jul 30 19:07:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFYi3-0002aM-Kq
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 19:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965628AbXG3RHD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 13:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbXG3RHC
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 13:07:02 -0400
Received: from web51002.mail.re2.yahoo.com ([206.190.38.133]:42928 "HELO
	web51002.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1761559AbXG3RHB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2007 13:07:01 -0400
Received: (qmail 9657 invoked by uid 60001); 30 Jul 2007 17:07:00 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=D+ozj1ze79IlZaSXqSnn0RC6mVejx8PvL0GGdIFlLVejIlXWP7Iw9jUpMohJ2uaU6plsYGNZ+z/Z+V9vE8bhNqwunyDUjTN5jzjAMnPbLnZ5Ro8wJlG6CfsUtPhTrKEtxVVLu2MSWhn82W2SdZfivF2fXfzaR67BS5XCgMZoRtA=;
X-YMail-OSG: x9gmg6cVM1ndHArXGd7zuVSVznlO_f8jWI7cCAhf
Received: from [208.58.8.179] by web51002.mail.re2.yahoo.com via HTTP; Mon, 30 Jul 2007 10:06:59 PDT
In-Reply-To: <46AE1100.2020005@dawes.za.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54241>


--- Rogan Dawes <lists@dawes.za.net> wrote:

> And also keep in mind that on the command line you can invoke a lot of 
> "plumbing commands" that you certainly wouldn't expect to be exposed in 
> a web interface.

If the web interface requires logins over https why can't plumbing commands be exposed to the web?
Though I agree not everything needs to be webified. What I envision is a wikipedia style interface
front end with git remaining the backend so you can more easily browse the file system and see
history and diff the way you can on Wikipedia. But that idea is very separate from my concern that
right now gitweb.cgi effectively has a bug in it because it sorts using external/superset commit
order/time rather than local commit order which causes changes to appear as if they were made 
before they were really merged locally.

-Matt



       
____________________________________________________________________________________
Pinpoint customers who are looking for what you sell. 
http://searchmarketing.yahoo.com/
