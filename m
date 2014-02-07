From: Andrew Keller <andrew@kellerfarm.com>
Subject: Re: [PATCH] gitweb: Avoid overflowing page body frame with large images
Date: Fri, 7 Feb 2014 09:32:55 -0500
Message-ID: <85BCA9A4-5EC3-4488-A4E4-4F86739B6450@kellerfarm.com>
References: <2452A253-A926-4A40-9F08-6E28EFF229F3@kellerfarm.com> <CAAH6HY92SGAjMMcrw_HwA_Uh_3=AWFFF9K9WAnNAPcyUpDkbwQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>, Tony Finch <dot@dotat.at>,
	Krzesimir Nowak <krzesimir@endocode.com>,
	=?iso-8859-1?Q?J=FCrgen_Kreileder?= <jk@blackdown.de>
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Fri Feb 07 15:33:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBmUL-0006pK-6p
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 15:33:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbaBGOdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 09:33:00 -0500
Received: from atl4mhob15.myregisteredsite.com ([209.17.115.53]:57905 "EHLO
	atl4mhob15.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751439AbaBGOc7 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 7 Feb 2014 09:32:59 -0500
Received: from mailpod.hostingplatform.com ([10.30.71.211])
	by atl4mhob15.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id s17EWvWf006574
	for <git@vger.kernel.org>; Fri, 7 Feb 2014 09:32:57 -0500
Received: (qmail 20307 invoked by uid 0); 7 Feb 2014 14:32:57 -0000
X-TCPREMOTEIP: 69.41.14.217
X-Authenticated-UID: andrew@kellerfarm.com
Received: from unknown (HELO devnet.ces.cvnt.net) (andrew@kellerfarm.com@69.41.14.217)
  by 0 with ESMTPA; 7 Feb 2014 14:32:57 -0000
In-Reply-To: <CAAH6HY92SGAjMMcrw_HwA_Uh_3=AWFFF9K9WAnNAPcyUpDkbwQ@mail.gmail.com>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241772>

On Feb 7, 2014, at 7:35 AM, Vincent van Ravesteijn <vfr@lyx.org> wrote:

> On Fri, Feb 7, 2014 at 4:31 AM, Andrew Keller <andrew@kellerfarm.com> wrote:
>> I recently used Git to archive a set of scanned photos, and I used gitweb to provide access to them.  Overall, everything worked well, but I found it undesirable that I had to zoom out in my browser on every photo to see the whole photo.  In the spirit of making the default behavior the most likely correct behavior, this patch seems to be a good idea.
>> 
>> However, I'm not an expert on the use cases of gitweb.  In order for the maximum size constraints to take effect, the image would have to be at least the size of the web browser window (minus a handful of pixels), so the affected images are usually going to be pretty big.  Are there any common use cases for displaying a large image without scaling (and hence, with scrolling)?
>> 
>> Thanks,
>> Andrew
>> 
> 
> It sounds like your usecase is exactly what camlistore.org tries to achieve.

Yes.

With that said, I don't think it's unreasonable for a software project to contain images larger than a browser window.  And, when that happens, I'm pretty confident that the default behavior should be to scale the image down so the user can see the whole thing.

 - Andrew
