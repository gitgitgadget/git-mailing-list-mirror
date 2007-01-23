From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: MinGW port - initial work uploaded
Date: Tue, 23 Jan 2007 09:31:14 +0100
Message-ID: <46d6db660701230031w606b1c91qd93d19a1c00aff19@mail.gmail.com>
References: <200701192148.20206.johannes.sixt@telecom.at>
	 <46d6db660701220506t20214d3bi4d0e1e93abd01aad@mail.gmail.com>
	 <200701222127.09601.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 09:31:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9H3q-0001Z6-9y
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 09:31:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbXAWIbQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 03:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbXAWIbQ
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 03:31:16 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:29575 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932091AbXAWIbP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 03:31:15 -0500
Received: by an-out-0708.google.com with SMTP id b33so528624ana
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 00:31:15 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Uu0EH8+c/pUKCCaPTohmSM2LGUc7+PCPCcle2KUj+I5Ap+dvX/MOjv4qyIxnW3EuCLqtqcdRVGVd8O8PSCtlQlCoIa8fdKqHgfHmPjvuWk1i84leAs6ux+d4TyqQLjEGwbRwU1Z8Ye+JnK5OhZoovYFFL7WKHK0L16X84CL3YUU=
Received: by 10.78.133.10 with SMTP id g10mr190550hud.1169541074222;
        Tue, 23 Jan 2007 00:31:14 -0800 (PST)
Received: by 10.78.175.18 with HTTP; Tue, 23 Jan 2007 00:31:14 -0800 (PST)
To: "Johannes Sixt" <johannes.sixt@telecom.at>
In-Reply-To: <200701222127.09601.johannes.sixt@telecom.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37490>

On 1/22/07, Johannes Sixt <johannes.sixt@telecom.at> wrote:
> Also, t/t5500-fetch-pack.sh passes now all tests.
>
> OTOH, git log, git diff, etc, which run the pager by default, are broken. It
> seems that the pipe is not correctly flushed by the writer, which the MinGW
> port closes in an atexit() routine, so that the last part of the piped data
> is missing. I have no clue how to fix this except by disabling the pager.
>

another good news: gitk is working too on windoze :)
good work! thanks!

--
Christian
