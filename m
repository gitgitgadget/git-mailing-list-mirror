From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Marking abandoned branches
Date: Wed, 13 Sep 2006 09:40:48 -0700
Message-ID: <45083490.9020203@gmail.com>
References: <9e4733910609130817r39bbf8a8x2e05461816d9d2a1@mail.gmail.com> <20060913152451.GH23891@pasky.or.cz> <9e4733910609130859v347a7a9ew5c3ebc982bf9b07b@mail.gmail.com> <ee9akc$d62$1@sea.gmane.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 13 18:42:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNXnw-000089-7p
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 18:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWIMQlH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 12:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWIMQlH
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 12:41:07 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:64642 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750741AbWIMQk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 12:40:59 -0400
Received: by wx-out-0506.google.com with SMTP id s14so2434662wxc
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 09:40:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=sVdOYPcfUMnBZGJoXcSzDtHU5D3lQ2Cse+MP33WIcTDD8bkI6ViAFhuofMDzEYmmMrwMObupl/T7P+1DgGDBZrwtoq2nIrKK0leRBRjUcRTa5eO1jwcU4V8BGoZ0nGBk+BMj57pNWaSZC2/4AWtVo+5c2CAKzD23XoH/YnDPihY=
Received: by 10.90.117.15 with SMTP id p15mr2826679agc;
        Wed, 13 Sep 2006 09:40:58 -0700 (PDT)
Received: from ?10.0.0.6? ( [24.55.157.69])
        by mx.gmail.com with ESMTP id 14sm1229122wrl.2006.09.13.09.40.50;
        Wed, 13 Sep 2006 09:40:51 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ee9akc$d62$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26921>

Jakub Narebski wrote:
...
> As it was said somewhere in this thread, you can use tags (tag objects) for
> that, i.e. tag each of the abandoned branches, explaining why branch wa
> abandoned for example, remove head refs, and move tag refs to
> refs/abandoned or refs/tags-abandoned/ or refs/Attic/ or in refs-abandoned/
> (the last has the advantage to not be included by default in any command,
> even when --all is given)

Using $GIT_DIR/refs-abandoned/ means changing a number of core parts;
think fsck and friends. Better to decide on a name in $GIT_DIR/refs/ and
teach the various visualizers to ignore that prefix by default. Maybe
even make the name a config item. *ducks*
