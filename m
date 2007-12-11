From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 6/5] Move fetch_ref from http-push.c and http-walker.c
 to http.c
Date: Tue, 11 Dec 2007 08:22:08 +0100
Message-ID: <475E3AA0.5010901@op5.se>
References: <1197322571-25023-5-git-send-email-mh@glandium.org> <1197328105-4843-1-git-send-email-mh@glandium.org> <7vve75hl72.fsf@gitster.siamese.dyndns.org> <20071211062129.GA8372@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 08:22:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1zRq-00026Z-Nz
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 08:22:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbXLKHWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 02:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbXLKHWM
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 02:22:12 -0500
Received: from mail.op5.se ([193.201.96.20]:60675 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750847AbXLKHWL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 02:22:11 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 382AC1F08037;
	Tue, 11 Dec 2007 08:22:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QjzcchpUgriH; Tue, 11 Dec 2007 08:22:09 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 0E9B41F08035;
	Tue, 11 Dec 2007 08:22:09 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <20071211062129.GA8372@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67817>

Mike Hommey wrote:
> On Mon, Dec 10, 2007 at 09:09:05PM -0800, Junio C Hamano wrote:
>> Mike Hommey <mh@glandium.org> writes:
>>
>>> Make the necessary changes to be ok with their difference, and rename the
>>> function http_fetch_ref.
>> Sorry, but I cannot parse "ok with their difference" part...
> 
> What about "to fit with their difference" ?
> 

Define "their" and "difference". Implicitly referring to another commit
message won't help cursory glances much (and I have no idea what you're
talking about since I didn't read the rest of your series very carefully).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
