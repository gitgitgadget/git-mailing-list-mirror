From: Sebastian Pipping <webmaster@hartwork.org>
Subject: Re: "git clone --depth <depth>" producing history with <depth + 1>
 commits?
Date: Thu, 02 Apr 2009 03:19:09 +0200
Message-ID: <49D4128D.7000803@hartwork.org>
References: <49CBB490.8040908@hartwork.org> <49D3C300.1040303@hartwork.org> <alpine.DEB.1.00.0904020303320.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 02 03:27:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpBi7-00038L-9y
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 03:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757021AbZDBBZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 21:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753638AbZDBBZn
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 21:25:43 -0400
Received: from smtprelay07.ispgateway.de ([80.67.29.7]:50548 "EHLO
	smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199AbZDBBZm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 21:25:42 -0400
X-Greylist: delayed 390 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Apr 2009 21:25:42 EDT
Received: from [85.179.30.75] (helo=[192.168.0.3])
	by smtprelay07.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <webmaster@hartwork.org>)
	id 1LpBaH-0001F7-Oh; Thu, 02 Apr 2009 03:19:09 +0200
User-Agent: Thunderbird 2.0.0.19 (X11/20090216)
In-Reply-To: <alpine.DEB.1.00.0904020303320.10279@pacific.mpi-cbg.de>
X-Df-Sender: 874396
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115429>

Johannes Schindelin wrote:
>> Anyone?  Is "git clone --depth 1 <ropository>" really supposed to 
>> produce a history holding _two_ commits?  Why so?
> 
> Because storing _no_ commit (according to you, that should happen with 
> --depth=0) would make no sense?
> 
> After all, if you want to clone, you want to clone at least _something_.

I'm aware you need one commit at least.

I didn't think of several branches before.
I guess that's resolving the core of my question.




Sebastian
