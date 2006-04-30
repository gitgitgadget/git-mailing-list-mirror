From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [RFC] 'Download' stat
Date: Sun, 30 Apr 2006 06:59:56 +0200
Message-ID: <e5bfff550604292159t5fac5436q73aecd5dbd56f516@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sun Apr 30 07:00:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fa42p-0001nU-Qx
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 07:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWD3E75 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 00:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbWD3E75
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 00:59:57 -0400
Received: from wproxy.gmail.com ([64.233.184.234]:40878 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750956AbWD3E75 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Apr 2006 00:59:57 -0400
Received: by wproxy.gmail.com with SMTP id i11so405045wra
        for <git@vger.kernel.org>; Sat, 29 Apr 2006 21:59:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cW8GbZ7y6hKmWCQOlnKh6ju5WNBCpJG0Vye3X363lshE88tAruRvUK7PuZyEWesNJFuRJ0awK9f6KdkQ9m8+IgM1RrQeDF3nn/kO5xJDh8RhwRiVYVlC395vDfAtzO5oUNXQR+tH8oDXPdtNDwISujM8IsnVVQUJZEVd4JZxAr0=
Received: by 10.65.23.20 with SMTP id a20mr1224765qbj;
        Sat, 29 Apr 2006 21:59:56 -0700 (PDT)
Received: by 10.65.163.11 with HTTP; Sat, 29 Apr 2006 21:59:56 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19327>

Hi all,

     none is interested in (writing ;-)  ) a kind of 'download' summary stat?

If git-daemon after a connection could save a record with fields like:

- date
- command requested (clone, pull, etc..)
- current HEAD

Perhaps would be possible to show nice stat/graph about repository
activity and most downloaded repository content tags.

Something like to know how many people has cloned/pulled  v2.6.17-rc2 
in date  2006/4/19

Perhaps is totally useless, just an idea.

    Marco
