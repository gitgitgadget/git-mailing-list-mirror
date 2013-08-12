From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: ephemeral-branches instead of detached-head?
Date: Mon, 12 Aug 2013 00:39:54 -0700
Message-ID: <20130812073942.GA18948@elie.Belkin>
References: <CA+CP9O6on2NXo6o4_0NoULnT8sgUD3pvvkFZvCTM5xKb38qOeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Jeske <davidj@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 09:40:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8mjX-0003mE-AZ
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 09:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754456Ab3HLHkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 03:40:03 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:64543 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754084Ab3HLHkB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 03:40:01 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld10so2634636pab.22
        for <git@vger.kernel.org>; Mon, 12 Aug 2013 00:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=521KaYKSPs8Rs3Fobm8IMhPvu48tF+IswzYKG1RQfKM=;
        b=yZoheqnGfjvJsWuBpykG0gCNmsUdfZ+W5eZC43wSkdFKMqjlQ7MqrukicFwM8OoTmK
         FyKWpScg+ryCYuvetC3otMAN+SRdwHwS9Df60LcqJlWGv+bGRDDQzyf65hJjzQ0GYp7S
         b09I9WPi2wB5JORVRct8ygmaGQnNMoDkCqC2t8rgTbecUsc1V2VhvNbpnicoTIsGdkWU
         a6OjAaGdnAzIfCwwxEyWoNkSZUMsnxl+/Jcq8PWzHDeWci3QSYPhC9D8aQunKVfG2WO8
         0ezTzK6lKG54h1yhrOJjVWkOsLhNPpRXtP0nmjaZsKXWQoOx0rBr9TTDSj/fGRSXSfQD
         14dQ==
X-Received: by 10.66.37.43 with SMTP id v11mr12361458paj.108.1376293201233;
        Mon, 12 Aug 2013 00:40:01 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id r7sm38170339pao.18.2013.08.12.00.39.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 12 Aug 2013 00:40:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+CP9O6on2NXo6o4_0NoULnT8sgUD3pvvkFZvCTM5xKb38qOeA@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232166>

David Jeske wrote:

>                                  Ephemeral branch names would be
> local-only and would never be pushed.

That's how normal branch names behave (local branch names and remote
branch names live in different namespaces).  How would the proposed
detached HEAD replacement compare to them?  Would the temporary branch
created by checking out a random commit be automatically deleted when
checking out another branch, or would it be garbage-collected at some
point later?

Curious,
Jonathan
