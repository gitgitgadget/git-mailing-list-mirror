From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 04/14] trailer: process command line trailer
 arguments
Date: Sun, 09 Feb 2014 15:06:55 +0100 (CET)
Message-ID: <20140209.150655.1495985026469658708.chriscool@tuxfamily.org>
References: <20140206194123.325.99451.chriscool@tuxfamily.org>
	<20140206202004.325.93876.chriscool@tuxfamily.org>
	<xmqqmwi3wzrb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, johan@herland.net, josh@joshtriplett.org,
	tr@thomasrast.ch, mhagger@alum.mit.edu, sunshine@sunshineco.com,
	dan.carpenter@oracle.com, greg@kroah.com, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Feb 09 15:07:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCV2H-00034p-5C
	for gcvg-git-2@plane.gmane.org; Sun, 09 Feb 2014 15:07:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbaBIOG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Feb 2014 09:06:58 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:36292 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751360AbaBIOG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Feb 2014 09:06:57 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 2198D54;
	Sun,  9 Feb 2014 15:06:56 +0100 (CET)
In-Reply-To: <xmqqmwi3wzrb.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241878>

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 04/14] trailer: process command line trailer arguments
Date: Thu, 06 Feb 2014 16:08:24 -0800

> Christian Couder <chriscool@tuxfamily.org> writes:
> 
>> This patch parses the trailer command line arguments
>> and put the result into an arg_tok doubly linked
>> list.
> 
> No the patch doesn't parse anything ;-).
> 
> "Parse the command line arguments and ...".
> 
>> +static void parse_trailer(struct strbuf *tok, struct strbuf *val, const char *trailer)
>> +{
>> +	const char *end = strchr(trailer, '=');
>> +	if (!end)
>> +		end = strchr(trailer, ':');
> 
> How would you explain the behaviour of the above code for this
> input?
> 
> 	frotz: nitfol=xyzzy
> 
> Perhaps strcspn()?

Ok to use strcspn().

Thanks,
Christian.
