From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-config --remove-section, document --rename-section
Date: Fri, 2 Mar 2007 12:23:08 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703021220420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <es66vt$jej$1@sea.gmane.org>
 <Pine.LNX.4.63.0703012344270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45E7DDB5.9060009@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Mar 02 12:23:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN5r0-0007JN-8l
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 12:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423034AbXCBLXL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 06:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423036AbXCBLXL
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 06:23:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:34354 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1423034AbXCBLXK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 06:23:10 -0500
Received: (qmail invoked by alias); 02 Mar 2007 11:23:09 -0000
X-Provags-ID: V01U2FsdGVkX1/sdQ8AYOXsbf3gOJqG0VQZUkrQfM5M1xlhjnKl2i
	A6BDyHmJnr7WHe
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45E7DDB5.9060009@lu.unisi.ch>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41194>

Hi,

On Fri, 2 Mar 2007, Paolo Bonzini wrote:

> > How about modifying rename_section() so that if new_name == NULL, it 
> > removes the section?
> 
> It's not so immediate, because rename_section has to print all the 
> non-section lines anyway, while remove_section has to remove them too.

Of course you would have to move "int removing" and the related two lines 
to rename_section(), too.

The diff would be shorter, and if you then rename the function to 
rename_or_remove_section() it becomes all clearer.

Ciao,
Dscho

> Thanks for writing the test, having an example will make my future work 
> easier.

You're welcome. Knowing how useful tests are is one of the good lessons of 
Extreme Programming...

Ciao,
Dscho
