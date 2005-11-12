From: Marco Costalba <mcostalba@yahoo.it>
Subject: GIT character codecs
Date: Sat, 12 Nov 2005 04:37:12 -0800 (PST)
Message-ID: <20051112123712.75182.qmail@web26301.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Nov 12 13:38:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaudH-0003bD-JY
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 13:37:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbVKLMhP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 07:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbVKLMhP
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 07:37:15 -0500
Received: from web26301.mail.ukl.yahoo.com ([217.146.176.12]:11649 "HELO
	web26301.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932376AbVKLMhO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2005 07:37:14 -0500
Received: (qmail 75185 invoked by uid 60001); 12 Nov 2005 12:37:13 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ki3NuPGJxBc8IL1Ih6v5a9WNBoBFWJWkqmFOm2foLRxZgLeZ1KwG4Ua/jJTkm3WTLobEJyTFt6ozoKJNhEK15DyhE8VopasI3WxF9yfzjhY7HkEbPJR1SfqYVv8zQjCvwELiSFcJqTkG8zpaVUuIkjSuzsfa55+XeKgb3xBKwNw=  ;
Received: from [151.44.24.119] by web26301.mail.ukl.yahoo.com via HTTP; Sat, 12 Nov 2005 04:37:12 PST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11679>

Hi all,

   this morning I pulled from git repo and tried to look at Junio japanese name with:

      git-diff-tree -p e6bd23911efd0a2bd756c77d9e7ba6576eb739a1

With my big sorry the name was erroneously shown on my box.

I modified qgit to force the use of utf-8 codec instead of the local one, 
in my case ISO-8859-15.

Now I can see Junio name in beautiful japanese characters, and also the 
correct 'Lukas Sandstrom' name.

The problem is now qgit on my local git archives no more correctly 
shows special italian characters.

So here we arrive at the points:

1) If utf8 is the 'only good one' for GIT repos why git-diff-tree uses 
the local codec, in my case ISO-8859-15.

2) If utf8 is not the 'only good one' but the commits are always saved using the
local codec, how is possible to set the correct codec to use after pulling 
from a remote repo with a different codec (in this case public git repo that 
is in utf8).

Thanks
Marco



		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
