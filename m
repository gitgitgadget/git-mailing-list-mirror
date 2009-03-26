From: Raman Gupta <rocketraman@fastmail.fm>
Subject: Re: Reference for git.git release process
Date: Thu, 26 Mar 2009 10:29:45 -0400
Message-ID: <49CB9159.6030606@fastmail.fm>
References: <49CA78BF.2020101@fastmail.fm> <7viqlxz9go.fsf@gitster.siamese.dyndns.org> <49CB3766.5090109@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Mar 26 15:31:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmqcE-0004S7-8B
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 15:31:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757271AbZCZO34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 10:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757136AbZCZO3z
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 10:29:55 -0400
Received: from smtp123.rog.mail.re2.yahoo.com ([206.190.53.28]:34693 "HELO
	smtp123.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756863AbZCZO3z (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 10:29:55 -0400
Received: (qmail 49316 invoked from network); 26 Mar 2009 14:29:52 -0000
Received: from unknown (HELO apollo.rocketraman.com) (rocketraman@99.224.155.40 with login)
  by smtp123.rog.mail.re2.yahoo.com with SMTP; 26 Mar 2009 14:29:52 -0000
X-YMail-OSG: P0bMIuEVM1nX.Ks.PXVvqmvhexBOO4xbcbTe2j3udvOvcHLcFkIwsiHXUHt_PlDQjA--
X-Yahoo-Newman-Property: ymail-3
Received: from localhost (localhost.localdomain [127.0.0.1])
	by apollo.rocketraman.com (Postfix) with ESMTP id 9D82621C051B;
	Thu, 26 Mar 2009 10:29:51 -0400 (EDT)
X-Virus-Scanned: amavisd-new at rocketraman.com
Received: from apollo.rocketraman.com ([127.0.0.1])
	by localhost (apollo.rocketraman.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VLXMLkYVQ7ML; Thu, 26 Mar 2009 10:29:45 -0400 (EDT)
Received: from [192.168.1.5] (zeus.rocketraman.com [192.168.1.5])
	by apollo.rocketraman.com (Postfix) with ESMTP id AA00721C051A;
	Thu, 26 Mar 2009 10:29:45 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <49CB3766.5090109@op5.se>
X-Enigmail-Version: 0.95.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114782>

Andreas Ericsson wrote:
> Junio C Hamano wrote:
>>
>> In addition, you can keep older maintenance track around, i.e.
>>
>>     git branch maint-X.Y.(Z-1) maint
>>         git checkout maint
>>         git merge master
>>
>> so that maintenance releases for even older codebase _could_ be issued
>> _if_ necessary.
>>
> 
> Assuming one tags ones releases (which one should, and git.git does),
> creating maint-X.Y.Z when it's actually needed is a far better approach.

This is only correct if the current tip of the maint branch is in fact
the last tagged release i.e. that there is nothing pending on the
maint branch that is intended for a maintenance release on the older
codebase.

Cheers,
Raman
