From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: meaning of --8<--
Date: Sun, 18 Jan 2009 11:13:59 -0500
Message-ID: <76718490901180813h4c226dadi87731ef3f46086bb@mail.gmail.com>
References: <200901181656.37813.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Sun Jan 18 17:15:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOaJ4-0002C4-Np
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 17:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757805AbZARQOB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 11:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757726AbZARQOB
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 11:14:01 -0500
Received: from rv-out-0506.google.com ([209.85.198.230]:28060 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757691AbZARQOA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 11:14:00 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2275426rvb.1
        for <git@vger.kernel.org>; Sun, 18 Jan 2009 08:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=eb/SiwmdmLEMNbxPu5izumTgE0dyNlsHW8fWBKflq1k=;
        b=gXC/9UQe5K0tHSgJFd41GD/Tk32VWXATbsJQDj1p7pfDegiQppPUIMZfQK2APC/Hw5
         Fqxvu6fMtkGEM0KkTIfEHmIwySJUlpn+jnEmYr9vIGq5iQsEwG2gq9oasm39CKkBlFX+
         mFtDlJdqb82e2JIxecaGowOF+oyXIssYt9gIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=bVDhNfyMNBXBEq85I3W7KdOjSs345gG3CD3kHnOzVL0gfWw7uvfIVNd3+kHJS4ppxi
         xWNX1viJNbUrqhgq9RJx+3ZIFTUI8iQB19dDdmPrtic+bbI8Fu068F5ZEIsj9//kphM8
         MSzrYSGxLBnAbY7Tt/1J1iJPh61toT5Ivle3s=
Received: by 10.140.171.18 with SMTP id t18mr2343721rve.95.1232295239391;
        Sun, 18 Jan 2009 08:13:59 -0800 (PST)
Received: by 10.140.204.11 with HTTP; Sun, 18 Jan 2009 08:13:59 -0800 (PST)
In-Reply-To: <200901181656.37813.markus.heidelberg@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106236>

On Sun, Jan 18, 2009 at 10:56 AM, Markus Heidelberg
<markus.heidelberg@web.de> wrote:
> Hi,
>
> I've seen lines like "--8<--" several times on this list, but have no
> clue what it is about.

It is supposed to represent a pair of scissors. Sometimes it is the
other direction: >8. And I've seen folks botch it as: <8 or 8>. This
list is the first (and maybe only?) place I've seen it. Typically you
might see:

--snip--

or

--cut--

> But is this a common convention or git specific and handled by git-am?

Seems to be a convention of this list, and git-am does nothing with it afaik.

j.
