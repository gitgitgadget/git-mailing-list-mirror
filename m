From: Xue Fuqiao <xfq.free@gmail.com>
Subject: Re: dead link on manual page
Date: Sun, 18 Oct 2015 10:46:12 +0800
Message-ID: <CAAF+z6GJnwp8zEuQE5QUuuUfzs8vBbdue-vHbhZuEYMofnLFKg@mail.gmail.com>
References: <562223DE.9080301@boerendroogers.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Jaap Droogers <jaap@boerendroogers.nl>
X-From: git-owner@vger.kernel.org Sun Oct 18 04:46:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZndzJ-0000v9-Cb
	for gcvg-git-2@plane.gmane.org; Sun, 18 Oct 2015 04:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754192AbbJRCqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2015 22:46:15 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:34579 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753901AbbJRCqN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2015 22:46:13 -0400
Received: by iow1 with SMTP id 1so159673410iow.1
        for <git@vger.kernel.org>; Sat, 17 Oct 2015 19:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jFsaNyHHdC7fm+G7jAWck3VxERoq9EURtnY/grRwjh4=;
        b=N2OvJqXhRnMFzuvDkOZssY9I/fF/SpcXt3pZTzf944ZpRoe0McSlyhx6vwcHi224MD
         YfGvd9dEQnFFfkueCin4cBhXgcO4VEjjm0+KxIyflnj0ghjjjfuIOvyqCJ6qbrvF8qae
         L4ruomrk6b1ukgMAxqbIbjR428EYxfhnuzzF+D3xTwRPFD1IdaSHc5T+XGSEmv+ggHsa
         8sgd3ohYJqwIWKqI7lnM4K0kIRDlAxeYpX7NSgz2LxrNDwZSq44DmKlthDjfjAriKUwL
         fe6RScqlKmaQVQCSFHdF3OyoozA0rpHPNngjXcEWO+IX0AqB2qLo+Y6SRATsa/2PMHHQ
         xJhA==
X-Received: by 10.107.12.197 with SMTP id 66mr19546859iom.145.1445136372557;
 Sat, 17 Oct 2015 19:46:12 -0700 (PDT)
Received: by 10.79.94.2 with HTTP; Sat, 17 Oct 2015 19:46:12 -0700 (PDT)
In-Reply-To: <562223DE.9080301@boerendroogers.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279798>

On Sat, Oct 17, 2015 at 6:33 PM, Jaap Droogers <jaap@boerendroogers.nl> wrote:
> Hi,

Hi Jaap,

> In the last sentence of page
> http://www.git-scm.com/book/en/v2/Git-Basics-Getting-a-Git-Repository I
> found a dead link to page
> http://www.git-scm.com/book/en/v2/1-git-server/_git_on_the_server
> (this dead link also appears on the paragraph "Cloning an Existing
> Repository", half a screen above the end)
>
> That should be replaced by:
> http://www.git-scm.com/book/en/v2/Git-on-the-Server-Getting-Git-on-a-Server

Yeah, it's a known bug. It has to do with the Atlas HTML build IIRC.

See https://github.com/git/git-scm.com/issues/588
