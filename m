From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: [FYI][PATCH] Execute testsuite on existing Git installation
Date: Fri, 03 Oct 2008 16:50:51 +0200
Message-ID: <48E6314B.3090609@dawes.za.net>
References: <20081003131314.GS10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Oct 03 16:55:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Klm2w-0002j8-Vg
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 16:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223AbYJCOwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 10:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753520AbYJCOwm
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 10:52:42 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:58093 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528AbYJCOwl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 10:52:41 -0400
Received: from spunkymail-a8.g.dreamhost.com (sd-green-bigip-145.dreamhost.com [208.97.132.145])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 2304517C58C
	for <git@vger.kernel.org>; Fri,  3 Oct 2008 07:52:40 -0700 (PDT)
Received: from [192.168.201.101] (dsl-243-205-139.telkomadsl.co.za [41.243.205.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by spunkymail-a8.g.dreamhost.com (Postfix) with ESMTP id 3B4EA10A061;
	Fri,  3 Oct 2008 07:51:37 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <20081003131314.GS10544@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97429>

Petr Baudis wrote:
> When I joined here, one of the first tasks I had was to "verify if the
> existing system-wide Git installation works fine on the local Linux
> setup (of unknown qualities)". I couldn't think of anything better than
> to run the Git testsuite, but using the system-wide Git instead of
> locally compiled one.
> 
> This extremely dirty patch achieves this; patch testsuite of Git version
> corresponding to the system-wide installation, of course. You will still
> need to make the test helpers.
> 
> I don't have any real interest on developing this further or tidying it
> up, but I have thought that someone might find this useful to just use
> or push forward, so here it goes.
> 
> Signed-off-by: Petr Baudis <petr.baudis@novartis.com>
> 

Perhaps a stupid question, but might it not be easier to add the git 
build dir to the front of the PATH, and then remove the explicit paths?

I realise that if the build was unsuccessful, you may end up executing a 
different version of git than you expect, though.

Rogan
