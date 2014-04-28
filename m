From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [PATCH 08/12] MINGW: config.mak.uname allow using CURL for
 non-msysGit builds
Date: Mon, 28 Apr 2014 20:23:32 +0400
Message-ID: <20140428162332.GA19504@seldon>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
 <1398693097-24651-9-git-send-email-marat@slonopotamus.org>
 <CABPQNSaywg_1pdixaEz0DALCO6pvhjdMhGW09aC+LALMzZAz1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 18:23:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeoLH-0008Ko-8a
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 18:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756061AbaD1QXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 12:23:37 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:43656 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S932646AbaD1QXf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 12:23:35 -0400
Received: from marat by slonopotamus.org with local (Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WeoL6-00055M-Ko; Mon, 28 Apr 2014 20:23:32 +0400
Content-Disposition: inline
In-Reply-To: <CABPQNSaywg_1pdixaEz0DALCO6pvhjdMhGW09aC+LALMzZAz1w@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247373>

On Mon, Apr 28, 2014 at 05:26:38PM +0200, Erik Faye-Lund wrote:
> On Mon, Apr 28, 2014 at 3:51 PM, Marat Radchenko <marat@slonopotamus.org> wrote:
> > Also, fix `warning: passing argument 2 of 'mingw_main' from
> > incompatible pointer type` in http-fetch.c and remote-curl.c.
> 
> These seems completely unrelated, perhaps it should be split in two?

Okay, will split. Though there is a connection - until this patch,
http-fetch.c and remote-curl.c never built for MinGW.
