From: Sam Vilain <sam@vilain.net>
Subject: Re: I don't want the .git directory next to my code.
Date: Thu, 17 Jan 2008 14:42:52 +1300
Message-ID: <478EB29C.9080908@vilain.net>
References: <478D79BD.7060006@talkingspider.com> <ee77f5c20801152006w11307ce0j17463f1c6536543f@mail.gmail.com> <478D85A9.6050807@talkingspider.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mike <fromlists@talkingspider.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 02:43:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFJn3-0006y8-RW
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 02:43:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509AbYAQBnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 20:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752450AbYAQBnD
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 20:43:03 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:43534 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752099AbYAQBnB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 20:43:01 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id 44D7321D1B8; Thu, 17 Jan 2008 14:42:59 +1300 (NZDT)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id BD59521D1AA;
	Thu, 17 Jan 2008 14:42:52 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <478D85A9.6050807@talkingspider.com>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70806>

Mike wrote:
> Thanks but this isn't sufficient. If we have one directory of our web 
> root in a git repository, say docroot/php, and we tar up docroot, it 
> will include php/.git.  We don't want that.  We would have to go out of 
> our way to avoid the .git directory.  The point is, we don't want 
> anything in docroot that shouldn't be made live.

It sounds like you want a tool more like Capistrano, which can use git,
rather than just pushing files around with git.

Sam.
