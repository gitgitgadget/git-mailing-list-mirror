From: David Brown <git@davidb.org>
Subject: Re: [PATCH] [git-p4] Detect exec bit in more cases.
Date: Wed, 19 Sep 2007 12:49:44 -0700
Message-ID: <20070919194944.GA11271@old.davidb.org>
References: <119022570352-git-send-email-git@davidb.org> <200709192103.53526.simon@lst.de> <20070919191412.GA6475@old.davidb.org> <56b7f5510709191231g22385e32y9c34d711d65b3bb7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Simon Hausmann <simon@lst.de>, git@vger.kernel.org
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 22:01:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IY5Z0-0001Ar-M9
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 21:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbXISTtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 15:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752592AbXISTtx
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 15:49:53 -0400
Received: from mail.davidb.org ([66.93.32.219]:59567 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752413AbXISTtv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 15:49:51 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.67 #1 (Debian))
	id 1IY5YO-0002xA-Vl; Wed, 19 Sep 2007 12:49:44 -0700
Mail-Followup-To: Dana How <danahow@gmail.com>,
	Simon Hausmann <simon@lst.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <56b7f5510709191231g22385e32y9c34d711d65b3bb7@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 19, 2007 at 12:31:52PM -0700, Dana How wrote:
>On 9/19/07, David Brown <git@davidb.org> wrote:
>> On Wed, Sep 19, 2007 at 09:03:50PM +0200, Simon Hausmann wrote:
>> >On Wednesday 19 September 2007 20:15:03 David Brown wrote:
>> >> git-p4 was missing the execute bit setting if the file had other attribute
>> >> bits set.
>> >
>> >I'm fine with this, so unless you find a better way:
>>
>> Well, I just tested it, and it still doesn't work, so I need to take some
>> time and try to figure out what is happening.
>>
>> I'm sometimes getting back 'xtext', and sometimes things like 'text+mx'
>> back from perforce, so I need to read up, and really figure out what to
>> look for.
>
>The output of "git p4 filetypes" was enough for me
>when I wrote my p4 front-end to fast-import;
>I never did read the p4 manual.

I have a patch based on what 'p4 help filetypes'.  I'm running it now on a
large test repository, and I'll compare the results when it is done.
Provided it works, I'll send a new patch in a little bit.

David
