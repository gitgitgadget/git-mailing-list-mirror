From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH v2 08/14] daemon: use explicit file descriptor
Date: Sat, 16 Jan 2010 22:52:54 +0100
Message-ID: <40aa078e1001161352w46f655cam3a2743ebf1d8afff@mail.gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
	 <1263591033-4992-9-git-send-email-kusmabite@gmail.com>
	 <201001152336.20662.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jan 16 22:53:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWGZn-0004V9-Vz
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 22:53:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535Ab0APVw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 16:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752520Ab0APVw4
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 16:52:56 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:49554 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496Ab0APVwz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 16:52:55 -0500
Received: by ey-out-2122.google.com with SMTP id d26so381133eyd.19
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 13:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=0cS7HuTJxVEBauG7D6Ezx5DtC4LAXJiF/cX6HMpenMw=;
        b=KxI399gecO6YdWuG3PPb+kQEPcIczUguWjOUQ0OPkJBqQNIRgvXChyL9IH7E/9f61Z
         iKkUfg5iB++iVLrbJAalnbka9e/v7KtZ3RCxeDWBrM3eetYA2lpo9ADVWzYjzRzma4Ns
         9XStgauSFnJV9ZH3wy2EJbsYrehXzxscyQe7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=m4bWr2HUb0RdB25X+fMi7pxh/7QeUHSwKpOdtxZbVczLTV5dq/mjnSlRrF5+8bLioX
         9Bft2UAJ9Eff54KRNEiDzAOrlBptB1WUa+dXXYGWYIjB1PhTNSRYx5ESmdQn8fUweNux
         9+0bEfDWfSxrgA9f1XIqqtYSO2diEHMUPW/E4=
Received: by 10.216.88.207 with SMTP id a57mr1490164wef.200.1263678774091; 
	Sat, 16 Jan 2010 13:52:54 -0800 (PST)
In-Reply-To: <201001152336.20662.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137263>

On Fri, Jan 15, 2010 at 11:36 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Freitag, 15. Januar 2010, Erik Faye-Lund wrote:
>> This patch adds support to specify an explicit file
>> descriotor for communication with the client, instead
>> of using stdin/stdout.
>>
>> This will be useful for the Windows port, because it
>> will use threads instead of fork() to serve multiple
>> clients, making it impossible to reuse stdin/stdout.
>
> This statement is a bit outdated.
>
> -- Hannes
>

Heh, yeah. I apparently missed that this patch isn't needed at all any more.

Thanks for noticing something was off :)

-- 
Erik "kusma" Faye-Lund
