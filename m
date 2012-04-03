From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Tue, 3 Apr 2012 17:21:00 -0500
Message-ID: <20120403222100.GA20252@burratino>
References: <11292500.AVmZFUUvNi@flobuntu>
 <CALkWK0nW91PE2810qrZUbL0x-_YTTA_2tLFVhvXBJ2NFGvVxog@mail.gmail.com>
 <2148933.pnpYo0xMAP@flomedio>
 <2487557.B8qfnaixh3@flomedio>
 <4F7A258C.5000200@pileofstuff.org>
 <20120402222958.GD13969@burratino>
 <4F7A3450.7000302@pileofstuff.org>
 <20120403000945.GA15075@burratino>
 <4F7B7169.4050507@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Florian Achleitner <florian.achleitner@student.tugraz.at>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Wed Apr 04 00:21:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFC6P-0004gP-4P
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 00:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953Ab2DCWVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 18:21:20 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47698 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754133Ab2DCWVT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 18:21:19 -0400
Received: by yenl12 with SMTP id l12so136379yen.19
        for <git@vger.kernel.org>; Tue, 03 Apr 2012 15:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=3PeFlEN1sr0jqxDNXowrAe9KgMNFG6r0FXAFZN6j1SY=;
        b=RDoe+qS4QD6MI3QdH7c5utzsvVxSFjMvmXSApBCnWvtptjI72SQ59bQ4MtX0ErCAYB
         wIZtWHTZ/CCg1AhuVQTFkRje+QLmZkGRIHpZ0onwDq1B5H6EBNhhPWMsYiu0KzDxLzRC
         fJJE4Lyowyb1CmLA5Dab+NNsR04lexqsO9epk6DMH6AzEmSUag/Z/q74fkPLOJURXmmw
         1j4yBO3XixiPU1oH4fQjCCoyNAsncNvNjh5denRGQIxssdllcDSXlLUMj3Ye/00YTLvd
         mQTFLfXsm6YLflSHcKPxCTIY/lNrEQBjpSzYHV3YtQWB/hniWoj3P7z3ygMsSbazdAX4
         VcfQ==
Received: by 10.50.187.233 with SMTP id fv9mr3376076igc.34.1333491679225;
        Tue, 03 Apr 2012 15:21:19 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id gh8sm12284497igb.16.2012.04.03.15.21.17
        (version=SSLv3 cipher=OTHER);
        Tue, 03 Apr 2012 15:21:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F7B7169.4050507@pileofstuff.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194657>

Andrew Sayers wrote:

> This is a pretty solid heuristic for detecting branches copied from an
> existing branch even in scheme (2) or (3), but does absolutely nothing
> for trunk detection.  Although trunk detection is trivial in the sane
> case (the "trunk" directory is the one and only trunk, end of story),
> here's a contrived example for why it's hard in the general case:

For the remote helper in its default configuration, I think it's ok to
assume the standard layout (trunk/, branches/*, tags/*).

Thanks for some useful examples.

Sincerely,
Jonathan
