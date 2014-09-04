From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH] setup.c: set workdir when gitdir is not default
Date: Thu, 4 Sep 2014 17:23:22 +0300
Message-ID: <20140904142322.GB8894@wheezy.local>
References: <1409784120-2228-1-git-send-email-max@max630.net>
 <CAPig+cQMNyurCB73CzGBLcfXqap5=kZsYq0O8nD29S8QsHtrBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 16:24:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPXx9-0005DX-RA
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 16:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbaIDOXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 10:23:55 -0400
Received: from p3plsmtpa12-06.prod.phx3.secureserver.net ([68.178.252.235]:40938
	"EHLO p3plsmtpa12-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750723AbaIDOXz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Sep 2014 10:23:55 -0400
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa12-06.prod.phx3.secureserver.net with 
	id n2Pp1o00N3gsSd6012PsPl; Thu, 04 Sep 2014 07:23:54 -0700
Content-Disposition: inline
In-Reply-To: <CAPig+cQMNyurCB73CzGBLcfXqap5=kZsYq0O8nD29S8QsHtrBA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256448>

On Thu, Sep 04, 2014 at 06:44:08AM -0400, Eric Sunshine wrote:
> > +       mkdir -p subdir &&
> > +       cd subdir &&
> > +       git testalias
> 
> If a new test is added following this one, it will be run from within
> 'subdir', which might come as a surprise as the author of the new
> test. Wrapping the 'cd' and following code in a subshell is a good way
> to avoid the problem.

Sure, my mistake. Will fix this and the other issue you
mentioned. Thank you.

-- 
Max
