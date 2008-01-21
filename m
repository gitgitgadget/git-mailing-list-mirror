From: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>
Subject: Re: =?ISO-8859-15?Q?=5BANNOUNCE=5D?= GIT 1.5.4-rc4
Date: Mon, 21 Jan 2008 14:16:40 +0100
Message-ID: <1JGwW0-0NMsgy0@fwd27.aul.t-online.de>
References: <1JGuDL-2AugiG0@fwd26.aul.t-online.de>
 <7vy7ajxvji.fsf@gitster.siamese.dyndns.org>
Reply-To: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 14:19:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGwYL-0004Gy-ES
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 14:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbYAUNSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 08:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751981AbYAUNSf
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 08:18:35 -0500
Received: from mailout07.sul.t-online.de ([194.25.134.83]:40350 "EHLO
	mailout07.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751504AbYAUNSf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 08:18:35 -0500
Received: from fwd27.aul.t-online.de 
	by mailout07.sul.t-online.com with smtp 
	id 1JGwWK-0001Xn-00; Mon, 21 Jan 2008 14:17:00 +0100
Received: from localhost (bpsG94ZOrhbtbwz5owAi9DutXsMRvKJfG9hfnIgTs6PS55YTAHjOpIOR0E65KAhgPC@[172.20.101.250]) by fwd27.aul.t-online.de
	with esmtp id 1JGwW0-0NMsgy0; Mon, 21 Jan 2008 14:16:40 +0100
In-Reply-To: <7vy7ajxvji.fsf@gitster.siamese.dyndns.org>
X-UMS: email
X-Mailer: TOI Kommunikationscenter V9-1-3
X-ID: bpsG94ZOrhbtbwz5owAi9DutXsMRvKJfG9hfnIgTs6PS55YTAHjOpIOR0E65KAhgPC@t-dialin.net
X-TOI-MSGID: 2d0713e3-ff13-46a2-bc7d-1fb4b7bffce4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71280>



From: Junio C Hamano 
 
>Michael Dressel writes:

>> Concerning RPM specs.
>>
>> I created rpm packages on a x86_64 SuSE 10.3 system.
>>
>> There were two complains about unmatched dependencies for expat-devel
>> and perl(Error)
>> I could not get rid off.
>
>Thanks.
>
>perl-error and expat-devel are both packaged outside git.
>Aren't they listed in dependencies?  At least I think
>expat-devel is on the build dependency.

>Our Makefile tries to install our own copy of perl::Error if the
>build platform does not have one, which we do not want to do
>when building a binary package.  Perhaps perl-error needs to be
>on the build dependency to deal with this issue?  I dunno, as I
>am not an RPM person.

The packages are in the dependency list. Only that they are
not installed (under the name given in the dependency list)
on my system. Nevertheless the build and install
and some simple tests work well.

For perl(Error) you have explained why it works. For openssh-client
I guess that things may be provided by packages
named differently. This is probably only an issue with SuSE.

Cheers,
Michael
