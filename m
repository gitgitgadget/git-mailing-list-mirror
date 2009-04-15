From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: integrating make and git
Date: Wed, 15 Apr 2009 19:30:32 +0200
Message-ID: <200904151930.32816.robin.rosenberg.lists@dewire.com>
References: <3a69fa7c0904150819x7598dea5ic43bf0991c35ae45@mail.gmail.com> <alpine.LNX.1.00.0904151148030.19665@iabervon.org> <3a69fa7c0904150947w25783199n6e304d7b4efcd051@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: E R <pc88mxer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 19:32:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu8y7-0007rW-Ck
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 19:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753065AbZDORal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 13:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752410AbZDORal
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 13:30:41 -0400
Received: from mail.dewire.com ([83.140.172.130]:6305 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752264AbZDORak (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 13:30:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id CC2CF149163F;
	Wed, 15 Apr 2009 19:30:34 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sMs0XbVAbUAV; Wed, 15 Apr 2009 19:30:34 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.9])
	by dewire.com (Postfix) with ESMTP id 437221491629;
	Wed, 15 Apr 2009 19:30:34 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.27-14-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <3a69fa7c0904150947w25783199n6e304d7b4efcd051@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116634>

onsdag 15 april 2009 18:47:52 skrev E R <pc88mxer@gmail.com>:
> Ok - I was wrong about the timestamps not getting updated. Thanks for
> that correction.
> 
> However, what about the idea of associating the result of a build with
> the hash of the source files used by the build, and using git to
> compute the hash?

Take a look at ccache. It doesn't use Git, but it uses hashes of source, and
compiler flags and associates that with the resulting object files, so it
can avoid compiling. If you are building largs C/C++ (especially C++)
projects you want it. 

-- robin
