From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: git-svn stubbornly re-creating branch "master"
Date: Fri, 3 Apr 2009 12:57:52 +0200
Message-ID: <237967ef0904030357u15ef77f2rb3299b6f6c651404@mail.gmail.com>
References: <20090329171347.GA26866@beczulka>
	 <37fcd2780903291252i19bba8ccx9dfb73e763d95b15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Marcin Owsiany <porridge@debian.org>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 12:59:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lph7Q-00028e-CY
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 12:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759664AbZDCK54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 06:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758968AbZDCK5z
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 06:57:55 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:34977 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758912AbZDCK5z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 06:57:55 -0400
Received: by ey-out-2122.google.com with SMTP id 4so250031eyf.37
        for <git@vger.kernel.org>; Fri, 03 Apr 2009 03:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qa1shrWycasORFvYBjBMnH6r4Gfo4K8kSGlZ+q8iZwc=;
        b=DzKm1vjLqowznZBeeaKqUBv+aaF7lyloPGa1t+8pXlYKe/tv8hwxc6331ddK8GnzAN
         8KsWKSgov/U5tojYdfJWmAYjCx7k5i+gCMlALP4O8s5LfRO7fLA0m9CpUPu7jEO3ONl7
         XKgWIzBeAD49qByZpbhTEwTB3hYyRXrim8wrw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MsIyDtIexVD+YhB//ch0+W6Si6v2PvKrb4qilC/84TutDrd0M9IedpEkIuWVGBpixm
         +Ic81U9G8OQ5HP9Pm1nSZ2llkiHv34RF99F9kLcQRHfZojpUC4IFgDwbLECOmluLkZ6b
         8sgqLw+G9x4dgVefvZmwOcjk2bdRyqLcl7SGY=
Received: by 10.210.89.4 with SMTP id m4mr817595ebb.65.1238756272194; Fri, 03 
	Apr 2009 03:57:52 -0700 (PDT)
In-Reply-To: <37fcd2780903291252i19bba8ccx9dfb73e763d95b15@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115525>

2009/3/29 Dmitry Potapov <dpotapov@gmail.com>:
> On Sun, Mar 29, 2009 at 18:13:47 +0100, Marcin Owsiany
> <porridge@debian.org> wrote:
>>
>> As you can see, "master" sprang back to life after the last command.
>
> It looks like git-svn does not like a repo without 'master'. It seems
> the problem was caused by this patch:
> http://git.kernel.org/?p=git/git.git;a=commit;h=1e889ef36c45b5554f7e317493ed3f4f901f8d9f
>
> I have added Eric to CC...

Why not just check if HEAD points to a valid commit, rather than
master? It should do the same
in the newly created repo case, and stop annoying people on updates.

-- 
Mikael Magnusson
