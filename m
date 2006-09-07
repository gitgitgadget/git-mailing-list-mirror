From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: A look at some alternative PACK file encodings
Date: Wed, 6 Sep 2006 20:10:39 -0400
Message-ID: <9e4733910609061710x4fb48d86o58b9c5ec8e527135@mail.gmail.com>
References: <44FF41F4.1090906@gmail.com>
	 <9e4733910609061623k73086dbey4a600ecf2852c024@mail.gmail.com>
	 <44FF5C27.2040300@gmail.com>
	 <Pine.LNX.4.64.0609061651500.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "A Large Angry SCM" <gitzilla@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 02:10:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL7Tg-00034C-7T
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 02:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161011AbWIGAKl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 20:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161012AbWIGAKl
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 20:10:41 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:34153 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161011AbWIGAKk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 20:10:40 -0400
Received: by py-out-1112.google.com with SMTP id n25so31564pyg
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 17:10:39 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=plaLrh/cVjdo0Cx5jbT3WIk7L9driOVGWTu/KHrVubWIYwYdGOzPEQf0EaH0VOFFlIJ97TFqDzqKNVLBxJSh3jBDorVeYT2PzL4TJbYSBdnHHfKD5IizHNoTIiDzd5wKXOq9z3csMX+CLu1PlSIDaQ87SqdH1B92o4PXFSeOnko=
Received: by 10.35.121.9 with SMTP id y9mr151212pym;
        Wed, 06 Sep 2006 17:10:39 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Wed, 6 Sep 2006 17:10:39 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609061651500.27779@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26574>

On 9/6/06, Linus Torvalds <torvalds@osdl.org> wrote:
> Is there any way to get zlib to just generate a suggested dictionary from
> a given set of input?

No, I asked the author. Apparently it is a hard problem, there have
been research papers written about it.

Shawn has a Perl script that makes a guess at a dictionary. That
scripts gets 4-7% improvement. The number one thing that ended up in
the Mozilla dictionary was the five different license versions that
had each been copied into 50,000 files over time.

I think what happens in practice is that when people get to the point
of trying to optimize zlib dictionaries they switch compression
methods.

-- 
Jon Smirl
jonsmirl@gmail.com
