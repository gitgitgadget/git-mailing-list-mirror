From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4] Documentation/notes: nitpicks
Date: Tue, 4 May 2010 02:23:17 -0500
Message-ID: <20100504072317.GA8410@progeny.tock>
References: <20100503233604.GA27451@progeny.tock>
 <20100503234720.GD27483@progeny.tock>
 <201005040909.43247.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue May 04 09:23:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9CTJ-0004Ah-Ro
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 09:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755626Ab0EDHXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 03:23:09 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:39683 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696Ab0EDHXH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 03:23:07 -0400
Received: by gxk9 with SMTP id 9so2014580gxk.8
        for <git@vger.kernel.org>; Tue, 04 May 2010 00:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=JSRCppAXHEYyrmxXjoXuwmctH7qEehF2Tr0C4YFZNAY=;
        b=JMX+gvKc6/OSD7yEQ+YTKHWBIwjiaxkTH8RFbzRPyhsrVIcNpa5+oiQxvafqS7g2O9
         /tH2z/ZYcZdyzv//1F9NIebC6dU0tPaOHbL93SNeywswQ5E8LoQjwdli83NsywuT13K2
         NGXGF1aC/LaRm+GBNnwJdKudXvDL1M2zqp7Wk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GTeaHr9szTwjvDicbHbBpKxv+hDp8VSr5AmWJ0+KMQ6rxXcED65MjGtM7dtzA65TDj
         NqIfTOKjdFHUV7LdoAFOAFPxQe15U4iREt69IlupVPwci8lT5z1n3sXiq8A5/IOJz4Pq
         lQGS9Mpf66/8F9u50DjgULoRu4yY3AB1Yk6nY=
Received: by 10.150.66.18 with SMTP id o18mr10899501yba.242.1272957783642;
        Tue, 04 May 2010 00:23:03 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm5114826iwn.3.2010.05.04.00.23.01
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 04 May 2010 00:23:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201005040909.43247.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146300>

Thomas Rast wrote:
> Jonathan Nieder wrote:

>> -A typical use of notes is to extend a commit message without having
>> -to change the commit itself. Such commit notes can be shown by `git log`
>> -along with the original commit message. To discern these notes from the
>> +A typical use of notes is to supplement a commit message without
>> +changing the commit itself. Notes can be shown by 'git log' along with
>> +the original commit message. To distinguish these notes from the
>>  message stored in the commit object, the notes are indented like the
>>  message, after an unindented line saying "Notes (<refname>):" (or
>> -"Notes:" for the default setting).
>> +"Notes:" for the main notes ref).
[...]
> The user might infer that "main" means core.notesRef, but the omission
> of (<refname>) is actually hardcoded to only happen for
> refs/notes/commits, so that's not correct.

Oh!  I had no inkling.

I guess the simplest way to document this is to just say it:

	           ... unindented line saying "Notes (<refname>):' (or
	"Notes:" for refs/notes/commits).

Thanks for the explanation.

Cheers,
Jonathan
