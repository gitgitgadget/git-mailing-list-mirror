From: Sam Vilain <sam@vilain.net>
Subject: Re: Rewriting history with git-filter-branch and leaking objects
 (?)
Date: Sun, 19 Aug 2007 14:34:38 +1200
Message-ID: <46C7AC3E.5010806@vilain.net>
References: <20070817171851.GB13891@glandium.org> <86k5ruxdxz.fsf@lola.quinscape.zz> <20070817174621.GA14503@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Aug 19 04:34:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMacl-00024g-Nf
	for gcvg-git@gmane.org; Sun, 19 Aug 2007 04:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753695AbXHSCeM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Aug 2007 22:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753462AbXHSCeM
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Aug 2007 22:34:12 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:59939 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbXHSCeL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2007 22:34:11 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id F283F21CFA0; Sun, 19 Aug 2007 14:34:08 +1200 (NZST)
Received: from [192.168.1.5] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id A199921CF9D;
	Sun, 19 Aug 2007 14:34:03 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <20070817174621.GA14503@glandium.org>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56122>

Mike Hommey wrote:
> Well, with the introduction of git-filter-branch, once you have
> rewritten your history and validated that everything is okay,
> you might mean to remove the original branch...
>   

Right, but it's probably better to leave a trail.  I tend to use
refs/Attic/* for branches that I've re-written (if I published them). 
That way, nothing will send or receive them by default.  Sometimes I'll
have a "clean" repository which doesn't have any of them for faster
initial cloning.

Sam.
