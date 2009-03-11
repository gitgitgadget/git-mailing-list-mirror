From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git doc build failure on OS X 10.5.6 (Leopard) during xmlto phase
Date: Wed, 11 Mar 2009 15:43:06 +0100
Message-ID: <49B7CDFA.30006@drmicha.warpmail.net>
References: <5e68abd90903110721o414283a4te188b58e0e4df8ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tom Holaday <tlholaday@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 15:45:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhPfv-0004oI-9E
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 15:44:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195AbZCKOnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 10:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbZCKOnU
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 10:43:20 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44110 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751497AbZCKOnU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2009 10:43:20 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 356E82EE1A4;
	Wed, 11 Mar 2009 10:43:18 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 11 Mar 2009 10:43:18 -0400
X-Sasl-enc: vC8RaeNSBO0rbPGqiofz4MWbUXJF++89udJQ6Jwn21MP 1236782597
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 938276D0C;
	Wed, 11 Mar 2009 10:43:17 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090311 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <5e68abd90903110721o414283a4te188b58e0e4df8ad@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112933>

Tom Holaday venit, vidit, dixit 11.03.2009 15:21:
> Hello,
> 
> On OS X 10.5.6 (Leopard), the command ...
> 
>    xmlto -m callouts.xsl man git-filter-branch.xml
> 
> ... terminates with these errors:
> 
> xmlto: input does not validate (status 1)
> /git-1.6.2/Documentation/git-filter-branch.xml:431: parser error :
> PCDATA invalid Char value 7
> Clone it with <literal>git clone +++0+++</literal>.  The clone
>                                     ^
> /git-1.6.2/Documentation/git-filter-branch.xml:431: parser error :
> PCDATA invalid Char value 7
> Clone it with <literal>git clone +++0+++</literal>.  The clone

That means that the xml file is incorrect already, which means it's an
asciidoc problem. What's your asciidoc version?

>                                       ^
> make[1]: *** [git-filter-branch.1] Error 1
> make: *** [doc] Error 2
> 
> What issue-tracker, if any, would be appropriate for this?

You should send a note to the mailing list ;)

Michael
