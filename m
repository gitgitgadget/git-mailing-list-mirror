From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 08/17] trailer: add interpret-trailers command
Date: Thu, 06 Feb 2014 21:12:28 +0100 (CET)
Message-ID: <20140206.211228.1189883848366712745.chriscool@tuxfamily.org>
References: <20140130064217.7504.473.chriscool@tuxfamily.org>
	<20140130064921.7504.75845.chriscool@tuxfamily.org>
	<CAPig+cRMBDr1D+3ad6y95ucxynO1qbRnsbUAfjtLkoR3+mjxZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, johan@herland.net,
	josh@joshtriplett.org, tr@thomasrast.ch, mhagger@alum.mit.edu,
	dan.carpenter@oracle.com, greg@kroah.com, peff@peff.net
To: sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Thu Feb 06 21:12:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBVJN-0004Sj-5W
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 21:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753898AbaBFUMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 15:12:33 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:41154 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751929AbaBFUMc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 15:12:32 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id E71B663;
	Thu,  6 Feb 2014 21:12:28 +0100 (CET)
In-Reply-To: <CAPig+cRMBDr1D+3ad6y95ucxynO1qbRnsbUAfjtLkoR3+mjxZg@mail.gmail.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241723>

From: Eric Sunshine <sunshine@sunshineco.com>
>
> On Thu, Jan 30, 2014 at 1:49 AM, Christian Couder
> <chriscool@tuxfamily.org> wrote:
>> diff --git a/trailer.h b/trailer.h
>> new file mode 100644
>> index 0000000..9db4459
>> --- /dev/null
>> +++ b/trailer.h
>> @@ -0,0 +1,6 @@
>> +#ifndef TRAILER_H
>> +#define TRAILER_H
>> +
>> +void process_trailers(const char *infile, int trim_empty, int argc, const char **argv);
>> +
>> +#endif /* TRAILER_H */
> 
> One might reasonably expect trailer.h and the process_trailers()
> declaration to be introduced by patch 7/17 ("trailer: put all the
> processing together and print") in which process_trailers() is defined
> in trailer.c.

On the other hand, I think that it is not so nice to add a header file
like trailer.h unless it is included at least once.

Maybe I can squash this patch with the previous one, but then the
series might be a little bit more difficult to understand.

Thanks,
Christian.
