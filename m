From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Why is this known by git but not by gitk
Date: Wed, 28 Nov 2012 01:19:56 +0100
Message-ID: <CAMP44s30-3BQeEU-c2vG8nonXEs=thQ704VZpyOMYVsYBsWmCw@mail.gmail.com>
References: <CAGVXcSYQprvqacDV_EjVSboiao3J8CcOoHwFeUgjJYoyos4e_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "Kevin O'Gorman" <kogorman@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 01:20:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdVNs-0001ol-Tm
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 01:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443Ab2K1AT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 19:19:58 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55515 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab2K1AT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 19:19:57 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so11524764obb.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 16:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iUOIAXNsRLjZVQpaMDRo+PNZibC3JWjw7A9rFArOwy4=;
        b=eq/oZTQ9f4Ba1xHqOuCAvD4nyNkUKWQVj4LgxZdJaeifGDRBs3KzOO/5CeO9A4o2MH
         sHlLTsVMmKgvhlDmA5sENEEFIvtBnA5MfwNSNKgk6ms+o1WPMWAbKJvGvWc2iWfKoZJJ
         Y4VifdlrKujrnKzlDyjRFTKRf5piV/BMeOnN4v+Iy828jJkuaSQLLn+hqh/RDoqKtZMs
         L3mk+Kjma6rZTh3248FcR+qtj/5/yCX+FetF6e+8nLZpw3HVWkHC3SeB0T/IDYumK7TZ
         Lnwjve3hYCbpfBPNzJjgfBatUyPg+JMNw+vB/61NTiPcInXzvw/rW5NB9wzThWs9gJcE
         e/Hg==
Received: by 10.60.4.227 with SMTP id n3mr14127652oen.136.1354061996810; Tue,
 27 Nov 2012 16:19:56 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Tue, 27 Nov 2012 16:19:56 -0800 (PST)
In-Reply-To: <CAGVXcSYQprvqacDV_EjVSboiao3J8CcOoHwFeUgjJYoyos4e_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210639>

On Tue, Nov 27, 2012 at 6:50 PM, Kevin O'Gorman <kogorman@gmail.com> wrote:
> I just converted a SourceForge CVS repo to git using cvs2svn.  One
> directory in the result is named CVSROOT and everything would be fine,
> but I wan to know why gitk does not see it.
>
> Git itself does not report it either, but it lets me "git rm -r
> CVSROOT" and stages the change.
>
> I just want to know what's up with this before I commit myself to
> using this converted repo.

Is it present in the .gitignore file?

-- 
Felipe Contreras
