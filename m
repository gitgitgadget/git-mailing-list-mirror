From: byrnejb <byrnejb@harte-lyne.ca>
Subject: Re: git doc build failure on OS X 10.5.6 (Leopard) during xmlto
 phase
Date: Tue, 31 Mar 2009 13:17:00 -0700 (PDT)
Message-ID: <1238530620384-2565224.post@n2.nabble.com>
References: <5e68abd90903110721o414283a4te188b58e0e4df8ad@mail.gmail.com> <76718490903110812t5e1723ebi28a84da680422d8a@mail.gmail.com> <76718490903110839m17041c7bxd7912eb09496c81a@mail.gmail.com> <76718490903110849x2ef48a89j3f17706390991eda@mail.gmail.com> <49B7E670.7060606@drmicha.warpmail.net> <gp95vf$gp1$1@ger.gmane.org> <49B8EF3E.2070208@drmicha.warpmail.net> <20090312170931.GB19175@inocybe.teonanacatl.org> <49BA356D.8050007@drmicha.warpmail.net> <76718490903130918r733e3ef4meae49311883969b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 22:18:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LokPv-0005JR-97
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 22:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475AbZCaURH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 16:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752374AbZCaURG
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 16:17:06 -0400
Received: from kuber.nabble.com ([216.139.236.158]:56825 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbZCaURF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 16:17:05 -0400
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1LokOK-0004yu-Ca
	for git@vger.kernel.org; Tue, 31 Mar 2009 13:17:00 -0700
In-Reply-To: <76718490903130918r733e3ef4meae49311883969b5@mail.gmail.com>
X-Nabble-From: byrnejb@harte-lyne.ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115307>


Hi,

I am attempting to build git-1.6.2-1 on CentOS5.3 and running into this problem:

  parser error : PCDATA invalid Char value 7

I am using asciidoc-8.4.1 and yesterday, when I first built git from the src rpm, the process completed without error.  The only thing that has happened to the build system since then is an update of perl packages from epel.  I do not see how that would affect anything, but I include the information for completeness nonetheless.  

In any case, I can live without the documentation if that will get the application built.  I have tried the suggestions with respect to setting ENV variables without success:
$ set
ASCIIDOC8=YesPlease
...
DOCBOOK_XSL_172=YesPlease

So, have I misunderstood the instructions given here?  Is there something else I should do?  Is there a way to simply skip the documentation part of the build?


-- 
View this message in context: http://n2.nabble.com/git-doc-build-failure-on-OS-X-10.5.6-%28Leopard%29-during-xmlto-phase-tp2461534p2565224.html
Sent from the git mailing list archive at Nabble.com.
