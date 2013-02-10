From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Feature request: Allow extracting revisions into directories
Date: Sat, 9 Feb 2013 20:19:12 -0800
Message-ID: <20130210041912.GB8584@elie.Belkin>
References: <510E8F82.9050306@gmail.com>
 <1359915086.24730.19.camel@t520>
 <510F03FC.6080501@gmail.com>
 <CABURp0rMk-W8VMRhXoR9YYQSwjWTfPbXz5mhPX3-HKsBSu5_mw@mail.gmail.com>
 <1360425499.3369.10.camel@t520>
 <7vehgpum7n.fsf@alter.siamese.dyndns.org>
 <7vpq08u903.fsf@alter.siamese.dyndns.org>
 <1360468628.6610.5.camel@t520>
 <20130210040621.GA8584@elie.Belkin>
 <1360469440.6610.8.camel@t520>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Clausecker <fuzxxl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 05:19:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4OOE-00057b-8r
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 05:19:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761089Ab3BJETS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 23:19:18 -0500
Received: from mail-pb0-f44.google.com ([209.85.160.44]:64977 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761048Ab3BJETR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 23:19:17 -0500
Received: by mail-pb0-f44.google.com with SMTP id wz12so278356pbc.3
        for <git@vger.kernel.org>; Sat, 09 Feb 2013 20:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=CEy987CH8EHDjIesbFI9z+3p4hazUeIAIFWU8sNMUOk=;
        b=0goPwZCapz7mjgfYsiQpb8hTtjTuwHNFUxZ5jKpkt0ha8y68mrfRxrZIVnWDJGQNQn
         291i7QdRAcVf5H/04B24rdUZg44xhjmwfEsEl3hGy8ht6L9o80mOssz6m7FR7UVqzd6G
         B0Wpz+wD2MTPjHGOpQpLoSlVm7c4seaomu+WaxFKrfmVH65BBcpO8qSinI8enmAEbu/C
         lF/oc5XQYcpHirQkHD14/2y2hcXFBHMMsRhYAwFQWOtiBVT6TftixbaSJLl/xFIEalPQ
         o6swRVd3xs8W5WUpssg1HvdbIyRDlUKKAcpzGeKhD2PTjYUtyH4HN6tc7TblxXtvMThp
         WBRQ==
X-Received: by 10.68.216.232 with SMTP id ot8mr8164502pbc.9.1360469957022;
        Sat, 09 Feb 2013 20:19:17 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id uo14sm3350203pbc.37.2013.02.09.20.19.15
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 09 Feb 2013 20:19:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1360469440.6610.8.camel@t520>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215896>

Robert Clausecker wrote:

> That is actually a pretty interesting approach. I can use a different
> index file for different deployments. How does this cooperate with bare
> repositories? Aren't they supposed to have no index file at all?

It should work fine in a bare repo.

If you can think of a good place to sneak hints about this into the
documentation (maybe as an example in git-archive(1) or a new
gitenvironment(7) page), that would be very welcome.

Thanks,
Jonathan
