From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Suggestion for git reference page
Date: Tue, 19 Nov 2013 13:49:04 -0800
Message-ID: <20131119214904.GB4212@google.com>
References: <0C723FEB5B4E5642B25B451BA57E273041FDF07F@S1P5DAG3C.EXCHPROD.USA.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jim Garrison <jim.garrison@nwea.org>
X-From: git-owner@vger.kernel.org Tue Nov 19 22:49:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VitAi-0006R1-JT
	for gcvg-git-2@plane.gmane.org; Tue, 19 Nov 2013 22:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004Ab3KSVtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 16:49:10 -0500
Received: from mail-yh0-f41.google.com ([209.85.213.41]:50737 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939Ab3KSVtI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 16:49:08 -0500
Received: by mail-yh0-f41.google.com with SMTP id f11so1156148yha.0
        for <git@vger.kernel.org>; Tue, 19 Nov 2013 13:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=E9/hwhdqBFCTLXlpTFtHAFpvMLxxpJ5BgrfzjZ2IslM=;
        b=dwclEk8fhprkoCspsMoMxZ40Ft8AXKkeCG1ElVlzoKxG1Y4PJCCVmFh/1AIJ1OVD1s
         C9xKZ2ALkVs2FFpkEmKGYZEYrA0oNcDKkF1J3J7kRdDiHPnRUi8ToXXyn96hKYTC0xVo
         IDJYJVmyBXOWppywq+NGSUkya/5jbMDiyA1zZXWMwa5SvpXhr91bT40Q6u92WtAZmqmQ
         IxaOpI9PaBdZkgYK6BDvUK7aYqy9C3NH7Mh0UN4LvFmppNNDj8Jvkyn9nqy5+oJ6AGCk
         7/JOWkFG8dcljqwbOS5vCfWfyEA3RUUIg1O+D9BDhyeI1Y09sUzf6UyC7Jc0cRx2iex2
         A4EA==
X-Received: by 10.236.28.105 with SMTP id f69mr24738250yha.50.1384897748080;
        Tue, 19 Nov 2013 13:49:08 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id h66sm38264564yhb.7.2013.11.19.13.49.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 Nov 2013 13:49:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <0C723FEB5B4E5642B25B451BA57E273041FDF07F@S1P5DAG3C.EXCHPROD.USA.NET>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238053>

Hi,

Jim Garrison wrote:

> The master reference TOC page at http://git-scm.com/docs links to
> all the associated command reference pages, except it seems to be
> missing a link for gitrevisions(7)
> (http://git-scm.com/docs/gitrevisions.html).
>
> I've never submitted a patch and thought I would learn how... except
> the website source doesn't seem to be in the git source tree.

You might like https://github.com/github/gitscm-next, file
lib/constants.rb.  (It's the target of the 'hosted on GitHub' link at
the bottom of each page, which I admit can be hard to find.)

Hope that helps,
Jonathan
