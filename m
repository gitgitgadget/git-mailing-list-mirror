From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: ZSH segmentation fault while completing "git mv dir/"
Date: Mon, 11 Mar 2013 20:37:36 -0500
Message-ID: <20130312013736.GB7105@unpythonic.net>
References: <vpqd2v686fi.fsf@grenoble-inp.fr>
 <513DF4D1.6000500@gmail.com>
 <vpq8v5uueug.fsf@grenoble-inp.fr>
 <513E3190.20100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>, felipe.contreras@gmail.com
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 12 02:38:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFEAJ-0001c2-L5
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 02:38:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076Ab3CLBhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 21:37:41 -0400
Received: from dsl.unpythonic.net ([206.222.212.217]:41703 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755026Ab3CLBhk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 21:37:40 -0400
Received: by unpythonic.net (Postfix, from userid 1000)
	id 1082E200003; Mon, 11 Mar 2013 20:37:36 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <513E3190.20100@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217933>

If it's dependent on eval "`dircolors`", it suggests it might be
dependent on the size of the environment.  Maybe try with FOO=`perl -e
'print "x"x1000'` for various values of 1000...

Jeff
