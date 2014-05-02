From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Pull is Mostly Evil
Date: Fri, 2 May 2014 15:53:42 -0700
Message-ID: <20140502225342.GQ9218@google.com>
References: <5363BB9F.40102@xiplink.com>
 <87k3a4xjzg.fsf@fencepost.gnu.org>
 <C439C0C76DA44AB5AAC91E7C0D2991BA@PhilipOakley>
 <5363ec734572a_70ef0f30cdc@nysa.notmuch>
 <2F8B2EEED0594446A6FCF771BBEDFB56@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	David Kastrup <dak@gnu.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sat May 03 00:53:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgML2-0000OG-TI
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 00:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481AbaEBWxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 18:53:46 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:52516 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbaEBWxp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 18:53:45 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so774082pab.8
        for <git@vger.kernel.org>; Fri, 02 May 2014 15:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=XuRtHclGs5Uk+H5rx6kB73pDM6q8cNx0iQYhN1Bb9Io=;
        b=SkRyNVh5YHsfY1jO7U8cKz5JTLVMXtwly3hKMP5LGXacLR8pF0d3FjUGayBHE4BALa
         B/ZmfgRGCH19EQ+U577FnwwRhQxVhV+2puFf0wFjrO1clPldMPdfBfAKCuEbz4RxRMhO
         02fzzw1hDO0VEp5l9wWkkLv1QlG8VSvVTy9fpmWrw/6YIo0B7WwPjNuk3RfOcSdJ+hkI
         XV5c1VP2lVnsBb1smm2iQfQ7454ONimZcS9G6/gVpnoo8JRLy0a+uYmBUeRi9GoaDZJ3
         OASsGe2IQp2AafJATXGCDMDzKf18iIyfJz5wPjT9mrl9OLBiBMT9WkmbTp0wx+PtPxzT
         qTug==
X-Received: by 10.66.164.201 with SMTP id ys9mr40042233pab.40.1399071225121;
        Fri, 02 May 2014 15:53:45 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ss2sm2547733pab.8.2014.05.02.15.53.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 02 May 2014 15:53:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2F8B2EEED0594446A6FCF771BBEDFB56@PhilipOakley>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248003>

Hi,

Philip Oakley wrote:

> That assumes that [git pull] doing something is better than doing nothing,
> which is appropriate when the costs on either side are roughly
> similar.

I think the conversation's going around in circles.

Potential next steps:

 a. Documentation or test patch illustrating desired behavior

 b. More traditional formal design doc explaining desired behavior and
    the thinking behind it ("problem", "overview of solution",
    "alternatives rejected", "complications", "example", "open
    questions").

 c. Implementation patch

 d. Someone takes an existing patch and figures out the next step
    toward getting it ready for application.

My preference is for (a), I guess.

The point being that something more concrete (code or a design doc)
makes it easier to avoid talking past each other.  And having
something concrete to edit makes the stakes clearer so people can make
it incrementally better without being distracted by unimportant parts.

Thanks and hope that helps,
Jonathan
