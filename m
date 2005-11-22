From: Alex Riesen <raa.lkml@gmail.com>
Subject: Question about handling of heterogeneous repositories
Date: Tue, 22 Nov 2005 17:50:24 +0100
Message-ID: <81b0412b0511220850w429d2f36lafe9de7ce19ce8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Nov 22 17:50:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EebLi-0007J0-5P
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 17:50:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbVKVQu1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 11:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965001AbVKVQu1
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 11:50:27 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:43125 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965000AbVKVQu0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 11:50:26 -0500
Received: by nproxy.gmail.com with SMTP id n28so147757nfc
        for <git@vger.kernel.org>; Tue, 22 Nov 2005 08:50:24 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=l9sNhF7G+xf6dNzgrkP9XsbZmNMLH8JVwEInFeLMcGRyU35Ii5XDfcaPdHuksezW1QTsVvXdNsDKtslOi0uYbYoZUWGhtTl+TxFQbz4lO5mC7Cw3ggOUZnwobRlADyWaa8sJ6bjsLQDaGSUhce1PJlN+qYa8M4o4uSmoZT56g98=
Received: by 10.49.41.2 with SMTP id t2mr400243nfj;
        Tue, 22 Nov 2005 08:50:24 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Tue, 22 Nov 2005 08:50:24 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12553>

Hi,

it is sometimes the case that a project consists of parts which are
unrelated to each other, and only thing in common between them is that
they all are used in that particular project. For example a program
uses some library and the developer(s) of that program would like to
have the source of that library somewhere close. Well, for this simple
example one could just use two repositories, laid close to each other
in a directory, like project/lib and project/prog.
Now, if I make the example a bit more complex and say, that the
developers of the program are the developers in that project and
change everything under project/ directory, including
project/library/. They are also good people and ready to give the
changes to the library upstream.

How do they achieve that, without sending project/ and project/program/?

For everyone who have an experience with ClearCase or Perforce (I'm
sorry for mentioning it) it is what the "mappings" are often used for:
a project is build together from different parts, which can be worked
on separately.

I'm trying to introduce git at work, but have to prepare myself for
possible questions first, and this is one of them :)

Greetings,
Alex Riesen
