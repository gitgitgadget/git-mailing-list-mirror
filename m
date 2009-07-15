From: davidb@quicinc.com
Subject: Re: Dividing up a large merge.
Date: Tue, 14 Jul 2009 18:19:14 -0700
Message-ID: <20090715011914.GA17100@huya.quicinc.com>
References: <20090714233246.GA25390@huya.quicinc.com> <3e8340490907141716j77df346es1f894d6a7f6cb0aa@mail.gmail.com> <20090715002926.GA26630@huya.quicinc.com> <32541b130907141734o59d224i7e0f39aa8a85e8ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bryan Donlan <bdonlan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 15 03:19:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQt9Y-00047S-1l
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 03:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756854AbZGOBTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 21:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756849AbZGOBTQ
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 21:19:16 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:53958 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756824AbZGOBTP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 21:19:15 -0400
X-IronPort-AV: E=McAfee;i="5300,2777,5676"; a="20727821"
Received: from pdmz-ns-mip.qualcomm.com (HELO numenor.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Jul 2009 18:19:15 -0700
Received: from msgtransport02.qualcomm.com (msgtransport02.qualcomm.com [129.46.61.151])
	by numenor.qualcomm.com (8.14.2/8.14.2/1.0) with ESMTP id n6F1JF2v011742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
	Tue, 14 Jul 2009 18:19:15 -0700
Received: from huya.qualcomm.com (huya.qualcomm.com [10.46.166.122])
	by msgtransport02.qualcomm.com (8.14.2/8.14.2/1.0) with SMTP id n6F1JEET006888;
	Tue, 14 Jul 2009 18:19:14 -0700
Received: by huya.qualcomm.com (sSMTP sendmail emulation); Tue, 14 Jul 2009 18:19:14 -0700
Content-Disposition: inline
In-Reply-To: <32541b130907141734o59d224i7e0f39aa8a85e8ef@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123281>

On Tue, Jul 14, 2009 at 05:34:26PM -0700, Avery Pennarun wrote:

> How about having one person do the merge, then commit it (including
> conflict markers), then have other people just make a series of
> commits removing the conflict markers?

I guess this helps in some sense, but the intermediate result
isn't going to build, and things like mergetool aren't going to
work.  It's helpful for the individuals to have the full merge
conflict available, or at least the stages of the files in
question.

David
