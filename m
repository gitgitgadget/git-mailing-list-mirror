From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: BUG or FEATURE? Use of '/' in branch names
Date: Fri, 2 May 2014 15:43:12 -0700
Message-ID: <20140502224312.GP9218@google.com>
References: <5363D1B4.1000503@lge.com>
 <AAC0CF0A2CCEC34CBE983015FD81C4F7392A504B61@AICEXMBXCL02.LGE.NET>
 <20140502221617.GO9218@google.com>
 <53641E0B.5000706@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"simon.busch@lge.com" <simon.busch@lge.com>
To: Keith Derrick <keith.derrick@lge.com>
X-From: git-owner@vger.kernel.org Sat May 03 00:43:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgMAq-00038U-3K
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 00:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593AbaEBWnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 18:43:16 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:49089 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366AbaEBWnP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 18:43:15 -0400
Received: by mail-pa0-f53.google.com with SMTP id kp14so1629896pab.26
        for <git@vger.kernel.org>; Fri, 02 May 2014 15:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jP+OBnGKbUTEYEQKIl/mQLnN+ULHA/Enn0DvvTeFjpg=;
        b=tlQqdJKXv8oFOXprL/xJOvbhDxYu16iW5C29YzDdVzfUP5Q6JxTrl/l0CSFliTYAXi
         KfoPOdNmi52udhpnB6lJg6dY8CwzP8XYPuhvtNGTwO1cRsb4uVR0Qifq6WltL+o1SzK+
         xvZwJKk+WorqIswyl94IosJFqkGrlXEZWpNTRpXIch6jIMemX01UsbrtQTGeth3oaPmn
         QOjZ9BWLbKsyCr1u88Wp50N8BF2uO9HY9Fdqcyw0iE5UKCFuAk6uwCu9mCp0bQs7WU+o
         uOG0bqHxMZr64PXijVycOFuyc2ebTiP3hwNIh9XiueSln662dZYQrRuvG8bVUz51Hech
         keiw==
X-Received: by 10.67.4.169 with SMTP id cf9mr39893683pad.45.1399070595178;
        Fri, 02 May 2014 15:43:15 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id nx12sm2392428pab.6.2014.05.02.15.43.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 02 May 2014 15:43:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <53641E0B.5000706@lge.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248002>

Hi,

Keith Derrick wrote:

> Yes, I've since found some discussion on this, and had already changed 
> to use '-' to append the classifier.
>
> But the other problem is that I can't easily find this restriction 
> documented anywhere - which means it comes as a suprise to people.

That sounds like another serious bug (the first one was the lousy
error message).  The current behavior is intended, and it sounds like
the documentation is lagging.

Where did you expect to find information about this?  Knowing that
would help a lot in fixing it.

(The nicest way to indicate where you expected to read about this
is with a patch against the relevant file in Documentation/*.txt,
of course.)

Thanks again,
Jonathan
