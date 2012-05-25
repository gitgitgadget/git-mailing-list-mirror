From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] Possibility to choose ~/.config/git/config instead of
 ~/.gitconfig
Date: Fri, 25 May 2012 13:44:09 -0500
Message-ID: <20120525184408.GA4740@burratino>
References: <20120525181526.Horde.VibLf3wdC4BPv7AeKacSMiA@webmail.minatec.grenoble-inp.fr>
 <CAE1pOi0eY2=eNzuTUVGmHuvfGWvxoXSJUADWr0CfPpVe5ktxow@mail.gmail.com>
 <7v4nr4t9gc.fsf@alter.siamese.dyndns.org>
 <20120525182558.GC4491@burratino>
 <7vsjeortwu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	nguyenhu@minatec.inpg.fr, git@vger.kernel.org,
	matthieu.moy@grenoble-inp.fr,
	Valentin DUPERRAY <Valentin.Duperray@phelma.grenoble-inp.fr>,
	Franck JONAS <Franck.Jonas@phelma.grenoble-inp.fr>,
	Lucien KONG <Lucien.Kong@phelma.grenoble-inp.fr>,
	Thomas NGUY <Thomas.Nguy@phelma.grenoble-inp.fr>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@phelma.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 25 20:44:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXzUt-0001yn-Ab
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 20:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128Ab2EYSoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 14:44:19 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:57638 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896Ab2EYSoS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 14:44:18 -0400
Received: by gglu4 with SMTP id u4so1068779ggl.19
        for <git@vger.kernel.org>; Fri, 25 May 2012 11:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=l6bRzDHejyQBBcOEBuUgX3egsuyvw9x5vHfvz97NGr4=;
        b=jsOpl/sG4mziLnah2N5jcMId3OmhkMFD4L9aXTjkBLYKwj3IV25vyGhKUFrXqkNZ9l
         IyS2BacdhbGVK3+x1MtaKB4JdA77p/UkFfOQNtFH15lmN8gm8FkWfOMe94YxC0HWzr6Q
         Ogu2UxmILXh/3tntUiGg0q03Ehld3CWcwNru5nBNqeezmGx08Af7AzrY7KNxZNY7Nv7c
         6qSybsoN6zHHHw1MZOhcdOt5iVVFHgR9dlOr0wt45XgM/Ol0YPqMz9ggehNk1RW3KXH5
         cg6RkFlxIQjkr3c3kOcU05Dhv1wnb6Yf8eu2G+7uhODqAI8DjTuvwFEelqlAGClctsC4
         91Kw==
Received: by 10.50.187.200 with SMTP id fu8mr84079igc.6.1337971457736;
        Fri, 25 May 2012 11:44:17 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id f8sm20067437ign.0.2012.05.25.11.44.15
        (version=SSLv3 cipher=OTHER);
        Fri, 25 May 2012 11:44:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vsjeortwu.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198506>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> If I understand correctly, the proposal that started this thread was
>> to give people a chance to tidy their HOME directory by moving
>> personal git configuration under ~/.config/git/.  
>
> So it is exactly "I do not want ~/.gitconfig, I want ~/.config/git", no?
>
> That is something distro should be able to decide.

Except that there is nothing distro-specific about it.  Do you really
want the config file to have a different name depending on whether one
is using Debian, Fedora, Mac OS X, Gentoo, one of the various builds of
git on Windows, Solaris, ...?

Besides, with my distro package maintainer hat on, I can tell you that
switching the config file to ~/.config/git and not reading
~/.gitconfig would be a complete nonstarter.  That would mean that the
existing user configuration for everyone would just seem to disappear.

Once the code to read both files is written, why would one want that
to be distro-specific and not something shared?

Hoping that clarifies a little,
Jonathan
