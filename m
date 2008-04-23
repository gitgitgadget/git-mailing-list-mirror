From: Christoph Duelli <duelli@melosgmbh.de>
Subject: Re: history of a renamed file
Date: Wed, 23 Apr 2008 15:45:07 +0200
Message-ID: <480F3D63.1040809@melosgmbh.de>
References: <480F3369.5080203@melosgmbh.de> <m3y774putc.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 15:47:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JofJz-0001Tc-Bi
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 15:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342AbYDWNqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 09:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753340AbYDWNqx
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 09:46:53 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:44705 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbYDWNqw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 09:46:52 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: hvKqOO6Ph79JHUJJIwMxXgzUdNi1LqfccsoS0yxp1bU6IJpbRdTLsu3mhpkbx1G98iOfud8=
Received: from mail.melosgmbh.de
	(p5B07A59E.dip0.t-ipconnect.de [91.7.165.158])
	by post.webmailer.de (klopstock mo14) (RZmta 16.27)
	with ESMTP id d06319k3NCfeUd ; Wed, 23 Apr 2008 15:46:50 +0200 (MEST)
	(envelope-from: <duelli@melosgmbh.de>)
X-Spam-Status: No, hits=0.0 required=4.0
	tests=AWL: 0.035,BAYES_00: -1.665,TOTAL_SCORE: -1.630
X-Spam-Level: 
Received: from [172.27.1.229] ([172.27.1.229])
	(authenticated user duelli@melosgmbh.de)
	by mail.melosgmbh.de (Kerio MailServer 6.4.1 patch 1);
	Wed, 23 Apr 2008 15:46:48 +0200
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <m3y774putc.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80217>

Jakub Narebski schrieb:
> Christoph Duelli <duelli@melosgmbh.de> writes:
> 
>> Given a repo that contains a file x.c
>> that got renamed from
>>   some/path/x.c
>> to
>>   new/location/x.c
>>
>> Is it possible (ideally with gitk) to view the complete history of
>> what is now new/location/x.c *including* the history of changes that
>> occurred when it stil was some/path/x.c?
>> When I say "gitk new/location/x.c" I get just the changes made
>> starting with the rename.
>> When I call "gitk" and look for the changeset, the rename is detected,
>> though. Therefore I hope that it is somehow possible to obtain the
>> complete file-specific history without truncation at renames.
>>
>> Any ideas?
> 
> Try --follow option, see git-log(1), although I'm not sure if gitk
> supports it (it should).
Works, thank you!

-- 
Christoph Duelli
