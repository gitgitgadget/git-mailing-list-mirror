From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Git for collaborative web development
Date: Thu, 26 Mar 2009 20:44:12 +0100
Message-ID: <fabb9a1e0903261244n15d31b1dw4990e31aafca64f3@mail.gmail.com>
References: <loom.20090326T184207-345@post.gmane.org> <fabb9a1e0903261218y329562f6uf18613f3f9e15836@mail.gmail.com> 
	<8f67b6f80903261241s7bbb179bwf5e9fa64f657ca1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Mr.SpOOn" <mr.spoon21@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 20:46:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmvXT-00072T-RN
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 20:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761503AbZCZToc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 15:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761482AbZCZTob
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 15:44:31 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:60670 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760988AbZCZToa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 15:44:30 -0400
Received: by bwz17 with SMTP id 17so711127bwz.37
        for <git@vger.kernel.org>; Thu, 26 Mar 2009 12:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QUDt4PDFKqb51CXtIX88xb/VR7Yv4kKRTP66mhMQwkw=;
        b=CPaR1Iw8r2jd7iF7jrNq9C1lmzDLXvIWa3F+jyBlzuzlyJzXaTTKFLMaMRietj4QDn
         Vu6n56kB0Qd9nNBW6ZdCd87OKjw0NXQV2izTj6eJSugXHBxercd4erMXeqirj9yIhZ/H
         y9YuffsBPjHr0u6XJZfU/WkCq2XwqJh3NWUYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=r/RHjqNA95cCLlIg+0lZRkCxYgkQNLsCJxKo6aqSy2ILINYmgFUa0EBNmPuVH+GAEw
         6vwb9W1AqvSgkcbDM6BomiqnxHdSs4FWxsJfz/+AbwIvWfzV3DuddUJnuRUAG9csDPpm
         vi6wbQQXMZHvUnK7Z5p6/W2GqcJtYg42IvMmE=
In-Reply-To: <8f67b6f80903261241s7bbb179bwf5e9fa64f657ca1d@mail.gmail.com>
Received: by 10.103.245.18 with SMTP id x18mr34081mur.62.1238096667417; Thu, 
	26 Mar 2009 12:44:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114813>

Heya,

On Thu, Mar 26, 2009 at 20:41, Mr.SpOOn <mr.spoon21@gmail.com> wrote:
> That seems cool. I'll take a look to some documentation to understand it :D

There's probably some typo's and thinko's in there, but you get the
idea. You can use aliases in git to define your own commands. If you
do not prefix the command with a bang it is interpreted as git
command, I use this one to review the changes I made with respect to
origin:

$ git config alias.new "log -C -M --reverse -p origin/master.."

-- 
Cheers,

Sverre Rabbelier
