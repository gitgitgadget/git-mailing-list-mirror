From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Tests in Cygwin
Date: Fri, 08 May 2009 08:03:38 +0200
Message-ID: <4A03CB3A.4090108@viscovery.net>
References: <83prfbhasp.fsf@kalahari.s2.org>	<4A01E64C.7050703@SierraAtlantic.com>	<7vvdoet13g.fsf@alter.siamese.dyndns.org>	<4A028A0A.5070003@viscovery.net> <4A030277.2000708@SierraAtlantic.com> <7viqkccvhb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Don Slutz <Don.Slutz@SierraAtlantic.com>,
	Hannu Koivisto <azure@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 08:03:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2JBT-0001K5-0r
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 08:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857AbZEHGDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 02:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752826AbZEHGDj
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 02:03:39 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:2990 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421AbZEHGDj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 02:03:39 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M2JBK-0000wB-Sp; Fri, 08 May 2009 08:03:39 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 9E5444E4; Fri,  8 May 2009 08:03:38 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <7viqkccvhb.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118567>

Junio C Hamano schrieb:
> Don Slutz <Don.Slutz@SierraAtlantic.com> writes:
> 
>> test_have_prereq () {
>> -       save_IFS=$IFS
>> -       IFS=+
>> -       set -- $*
>> -       IFS=$save_IFS
>> -       for prerequisite
>> +       for prerequisite in $(echo $*)
> 
> Ah, that's clever.

Well, it is an extra fork() that could easily be avoided by modifying the
call site in test_skip.

-- Hannes
