From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: 0 bot for Git
Date: Mon, 11 Apr 2016 23:41:11 -0700
Message-ID: <20160412064111.GA22157@kroah.com>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com>
 <CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 08:41:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aps0i-0001Ul-Um
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 08:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755945AbcDLGlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 02:41:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40537 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbcDLGlM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 02:41:12 -0400
Received: from localhost (unknown [67.51.76.21])
	by mail.linuxfoundation.org (Postfix) with ESMTPSA id A8F29E60;
	Tue, 12 Apr 2016 06:41:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291246>

On Mon, Apr 11, 2016 at 09:29:59PM -0700, Stefan Beller wrote:
> Resending as plain text. (I need to tame my mobile)
> 
> On Mon, Apr 11, 2016 at 7:51 AM, Stefan Beller <sbeller@google.com> wrote:
> > Hi Greg,
> >
> > Thanks for your talk at the Git Merge 2016!
> > The Git community uses the same workflow as the kernel. So we may be
> > interested in the 0 bot which could compile and test each patch on the list.
> > Could you put us in touch with the authors/maintainers of said tool?
> >
> > Unlike the kernel we would not need hardware testing and we're low traffic
> > compared to the kernel, which would make it easier to set it up.

We don't get much, if any, real hardware testing from the 0-day bot,
it's just lots and lots of builds and static testing tools.

You can reach the developers of it at:
	kbuild test robot <lkp@intel.com>

Hope this helps,

greg k-h
