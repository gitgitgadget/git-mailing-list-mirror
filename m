From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: Git graph with branch labels for all paths in text environment
Date: Sat, 21 Nov 2009 12:50:34 -0500
Message-ID: <2c6b72b30911210950m7f90f210saf3c32c1a3cbdebe@mail.gmail.com>
References: <1258373038892-4011651.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: rhlee <richard@webdezign.co.uk>
X-From: git-owner@vger.kernel.org Sat Nov 21 21:53:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBwrw-00041R-F9
	for gcvg-git-2@lo.gmane.org; Sat, 21 Nov 2009 21:47:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756602AbZKURut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2009 12:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756590AbZKURus
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Nov 2009 12:50:48 -0500
Received: from mail-iw0-f178.google.com ([209.85.223.178]:33675 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756582AbZKURus (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2009 12:50:48 -0500
Received: by iwn8 with SMTP id 8so3217823iwn.33
        for <git@vger.kernel.org>; Sat, 21 Nov 2009 09:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=NoY5u7U9jnYA9RJ1N6exezXPg3JfzGYGRc2BN9M+GBY=;
        b=JNvy6Rwhb8eZYJOLisGmLn6NJUBKpL5z7y4ZG/l9PFksUJxH+RV13EnVpCkAsmvYfw
         Mf0J6L/r+CP0rfFjmpnEstuA//5ICLh8JnwhiZgjN0yJYw4gZml/v9ri9kKAlNxKamKW
         WdvoShNApXUW0v959WMj9WBp67YnWutgexJY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=rtKBntO/Qk6JFgj8Od5FyBpanIYwWE8iCuC73/ihZPB7BHkqHNyYMBosMXiJKqYJYj
         eOvzsABmklou0HYKbRO1qNeEzZK2Pr23OqCZ9GKf8B22LdFjDO4QheKGZMXMyxJp+k3l
         GKqnQcaJsitsXa28KlJw4GVblhmT7yyt8xbBg=
Received: by 10.231.6.79 with SMTP id 15mr6389586iby.36.1258825854090; Sat, 21 
	Nov 2009 09:50:54 -0800 (PST)
In-Reply-To: <1258373038892-4011651.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133406>

On Mon, Nov 16, 2009 at 07:03, rhlee <richard@webdezign.co.uk> wrote:
> Is there anyway to to view a text based git grah that shows all paths with
> the branch labels? Like a on gitk but ncurses based?
>
> [...]
> I can get all branch labels in tig, but only for the current branch.

You can browse all branches by using: tig --all
However, the graph drawing is rather poor for complex git histories.

-- 
Jonas Fonseca
