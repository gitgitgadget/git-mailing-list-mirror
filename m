From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFD PATCH 00/32] subtree clone v2
Date: Tue, 24 Aug 2010 18:09:07 -0500
Message-ID: <20100824230907.GD2376@burratino>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
 <20100824223741.GB2376@burratino>
 <AANLkTikipryFVf_XvvbHopWSo5Ey_mvgTevY2NAvhygQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 01:11:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo2eV-0007yT-2X
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 01:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933626Ab0HXXLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 19:11:08 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:36434 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756690Ab0HXXKv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 19:10:51 -0400
Received: by qyk33 with SMTP id 33so7001996qyk.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 16:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=AcjruSrrjYUhUmQ0xkaT3D7Fgz9o0RZxT/8ffkMVJkI=;
        b=rvd2at+8pOYdiqnZqCzZi6jPPTACcsIDu64XxMvoR5lqaR2v6Nj1u33kEbho6IGzuG
         RWj4aaKm8xchSKDu2Dgd5v6sE6PvJ57RESuVXbERDpC1PsL3raxfe5j939qZn8zvGMJ2
         /GheGcLoCNyu8oBw3VQGc5aCkYjLeBHMNjVzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=H+mjBjNge8JB06S7yXEJyf83mgXSYhrsqFzoP0EEAJMvDUpXtDqIV2QhLX1IIN53RX
         4UNlMCVahuvvdM6fH1Kq8u8aazhOdUjkixxEFpO6TTxxJZ9jkAk8fUVmDHIZY5Uii90A
         VIrJkGxSN48VT086o355x3RDO1XfiQQo6ngwY=
Received: by 10.224.119.18 with SMTP id x18mr4913636qaq.302.1282691449702;
        Tue, 24 Aug 2010 16:10:49 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r38sm721015qcs.38.2010.08.24.16.10.48
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 16:10:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikipryFVf_XvvbHopWSo5Ey_mvgTevY2NAvhygQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154380>

Nguyen Thai Ngoc Duy wrote:
> On Wed, Aug 25, 2010 at 8:37 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> is it possible to
>> merge without remote contact in the boring case, when no changes have
>> occured outside the narrow tree?
>
> That's possible (and is implemented in my series). But I guess as soon
> as you do "git pull", the boring case is likely not applicable
> anymore.

Makes sense.

One slightly less boring case.  Is it possible to merge when the
simplified history, looking only at changes outside the narrow tree,
would have permitted a fast-forward?

If so, a git contributor who is only interested in Documentation/
could work on "next" between releases and keep up with "maint" and
"master" longer term, without the help of a full-tree-merging machine.

More realistically, a linux-2.6 contributor only interested in one
subsystem could always keep up with "master".  Which would be nice.
