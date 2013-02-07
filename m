From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Proposal: branch.<name>.remotepush
Date: Thu, 7 Feb 2013 15:30:17 -0800
Message-ID: <20130207233017.GD19397@google.com>
References: <CALkWK0nA4hQ0VWivk3AVVVq8Rbb-9CpQ9xFsSOsTQtvo4w08rw@mail.gmail.com>
 <5113E849.8000602@elegosoft.com>
 <CALkWK0=53riU3xKbKkyAVS8--9VoAU5P6h88MQ9-geW=H5+a-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Schubert <mschub@elegosoft.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 00:30:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3avd-0002jM-Tv
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 00:30:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759531Ab3BGXa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 18:30:28 -0500
Received: from mail-da0-f48.google.com ([209.85.210.48]:44667 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759479Ab3BGXa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 18:30:27 -0500
Received: by mail-da0-f48.google.com with SMTP id v40so1445783dad.35
        for <git@vger.kernel.org>; Thu, 07 Feb 2013 15:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Zb4/Teqc+4F2+VP7nR2XJ/NgCiKXYTelMiKbn8wrSok=;
        b=kwkkmPMSfbrqx9/qB7GpTk94jQb5nD5sjJnZCVuX4b2D4sd22Wxq+LVvuJG2l+uGPA
         Qi6ia2kpZjIlhmf8zuTaHD/1yXfhLq2Da38m2RYMWP0HJRnkn7rxtMHyoOrTrrbSDG8s
         eZGAHTjXdZyCr7ag5KYOLnOf/Mh4PxeyAXGKEt1OowgeVHjVMhiBXIg3wJ/n3kf5snaD
         fcMRFlR0pzghrQbTCTD7scJdFScYr5HpW5qRCT7euI+TnvfYmAoYdPqJq1IqAluebhwx
         mCHi+IWSyvuKO2m4q89bgNXrxV60ekLD/Jur7Id3PEfjNjo7XQQDpV9aKfUZvB7BzPkL
         0CWg==
X-Received: by 10.66.82.198 with SMTP id k6mr10604964pay.53.1360279826906;
        Thu, 07 Feb 2013 15:30:26 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id w2sm44002577pax.22.2013.02.07.15.30.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 07 Feb 2013 15:30:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0=53riU3xKbKkyAVS8--9VoAU5P6h88MQ9-geW=H5+a-w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215734>

Hi Ram,

Ramkumar Ramachandra wrote:

> And yes, a regular `git push origin refs/for/master` is just retarded.

The usual incantation is "git push gerrit HEAD:refs/for/master".  Is
the code review creation push that uses a different branchname from
the branch the integrator pulls what seems backward, or is it the need
to specify a refname at all on the command line?

I agree that a "[branch "master"] pushremote" configuration would be
handy.  pushremote instead of remotepush to be less surprising to
people who have already seen pushurl.

Good luck,
Jonathan
