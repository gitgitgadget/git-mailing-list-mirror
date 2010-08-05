From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2 0/2] Submodules: Add the new config option "ignore"
Date: Fri, 06 Aug 2010 01:51:28 +0200
Message-ID: <4C5B4E80.1070102@web.de>
References: <4C4DD33F.4020104@web.de> <4C4DD3CF.9070906@web.de> <7vhbjjware.fsf@alter.siamese.dyndns.org> <4C5B3D36.1060902@web.de> <7vvd7obpy5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 01:51:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhADq-00060D-Sk
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 01:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759248Ab0HEXvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 19:51:31 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:36658 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758862Ab0HEXva (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 19:51:30 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate03.web.de (Postfix) with ESMTP id 35EEB15CFDDE2;
	Fri,  6 Aug 2010 01:51:29 +0200 (CEST)
Received: from [80.128.118.249] (helo=[192.168.178.29])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #24)
	id 1OhADh-0002wu-00; Fri, 06 Aug 2010 01:51:29 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.7) Gecko/20100713 Thunderbird/3.1.1
In-Reply-To: <7vvd7obpy5.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/YK2GghrfHTG8rI4RullpLKxL5zQEvFbMwNUZ2
	2KwjUbq+VJ5YSF3k7W5FPl8COlSKGhn0jg40xYvx+f4Nb2u0Jv
	CxvYPeqxCPjxlVVssHqg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152741>

Am 06.08.2010 01:27, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Am 28.07.2010 23:35, schrieb Junio C Hamano:
>>> The value of "submodule.<name>.path" does not have to be "<name>".  There
>>> seems to be a bit of confusion here.
>>
>> Thanks for clearing up my confusion, this is v2 of this patch using the
>> path configured for the submodule instead of its name.
> 
> Hmph, I thought that it would make more sense to use <name> so that once
> the user configures ignore in .git/config, it will persist across moving
> of the submodule in the superproject tree.  I wonder what others would
> think.

I think that is just what this patch does, it uses the
"config_name_for_path" string_list to get the submodules <name> for the
path to then look up what is configured for the "ignore" option under
that <name>. So the "ignore" option should survive renames, no? Or did
I manage to confuse myself again?
