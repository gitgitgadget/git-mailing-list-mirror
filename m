From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Merge commit before branch tip
Date: Mon, 26 Jul 2010 11:06:20 -0500
Message-ID: <20100726160620.GA4399@burratino>
References: <AANLkTikp5dHz97qp3pf+DE-wABNVYTGAQ+h30D9Fa04c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bradley Wagner <bradley.wagner@hannonhill.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 18:07:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdQDR-0003Fb-Je
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 18:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678Ab0GZQHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 12:07:37 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:65184 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933Ab0GZQHh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 12:07:37 -0400
Received: by wwj40 with SMTP id 40so329287wwj.1
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 09:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=4baxlryh742BRCR0XnDEsLjm8lFWzgosr+sRhD/GsG0=;
        b=BkUUhtriH0KQxLm4CbM0oeQ59XSvbkCZ7Mf9x2GIR53S8jd/84/KQ1kZxy6b0csRbq
         Sv+tPDBpC6O4s/X0eB1XvnM3pGs6TCxjDawofOOe4Xznkn0tnKy+l4cO5cvfM1kqDEqO
         0hIMdh6QFA18j46bZFuZuPs+mOG0yHDKV50xM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fmqa40JNkDBJ52MOXYva0VQbrHBGm4oXjBqmzVojhImCVW6D5cRyvFp/AvkhP5mq+s
         bSm7mTHX6MV9gIaVPn6PBX4S35eDtHME6bakHX94klnEmdprcbUcHWf1RMfYUbu+YeNO
         EXbF6sgDqajfmXh6/2OEea+UeicOAnAatUuXE=
Received: by 10.227.156.11 with SMTP id u11mr7534422wbw.146.1280160455806;
        Mon, 26 Jul 2010 09:07:35 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id l55sm2028072weq.17.2010.07.26.09.07.33
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 09:07:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikp5dHz97qp3pf+DE-wABNVYTGAQ+h30D9Fa04c@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151851>

Hi Bradley,

Bradley Wagner wrote:

> I realize this is not a best practice but is it possible to merge a
> branch but at a point before the branch tip?

I do not even think it is not a best practice.  You can do

  $ git fetch --all
  $ git merge origin/master~1

and git will happily create a merge with message

  Merge remote branch 'origin/master' (early part)

(See the "SPECIFYING REVISIONS" section of git-rev-parse(1)
for more examples.)

Hope that helps,
Jonathan
