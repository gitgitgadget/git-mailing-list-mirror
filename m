From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] allow git-svn fetching to work using serf
Date: Sat, 6 Jul 2013 17:28:04 -0700
Message-ID: <20130707002804.GF30132@google.com>
References: <CB53C901-3643-46AE-AA80-CED5E20AC3B7@gmail.com>
 <51D7C47D.5070700@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Rothenberger <daveroth@acm.org>
X-From: git-owner@vger.kernel.org Sun Jul 07 02:28:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvcpq-0007WR-9d
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 02:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168Ab3GGA2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jul 2013 20:28:10 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:60575 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749Ab3GGA2I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jul 2013 20:28:08 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp12so3205537pab.7
        for <git@vger.kernel.org>; Sat, 06 Jul 2013 17:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1ulQbHA2sTuR5raxjf2oQ+Cdm4/N9FQP4QDO/Z15zic=;
        b=C+75lIzfoEUO8Rvi9E+DBavZnzfb7v59rLerY9pnRNzE+vqKphrebSWQFoCPid8xm0
         KtXECi53bGItC/IvK2RgKjPJ+cTtoUjNr4a2KsNN24Sc4Pm/R+1HOlSBROgsclThxQh1
         0QM5hvK/LAJd5pjnRnMF5DJ2p/ZHqkvJ21THzSRYyjSVNGr0TrNDzCa9l4I784KGqiQf
         R3rhIoyht9CBcdgBew0W8DzVLDg552Bk4O7GEOOdx68g+SVdEWPFcfN5rOLbTg5uFLtd
         FLWX3p3+NpSzA3KI3MSrBEc0OS9Eh/HIg/7o21tFfcWNQYb967DeTpZFZTLNDDHAOtQ+
         yjvQ==
X-Received: by 10.68.132.101 with SMTP id ot5mr15301103pbb.11.1373156888170;
        Sat, 06 Jul 2013 17:28:08 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id y9sm14359341pbb.46.2013.07.06.17.28.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 06 Jul 2013 17:28:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51D7C47D.5070700@acm.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229708>

David Rothenberger wrote:
> On 7/5/2013 8:41 PM, Kyle McKay wrote:

>> Daniel Shahaf has suggested also setting
>> "servers:global:http-bulk-updates=on".
>
> I have a patch that does this, but since turning on bulk updates has
> a possible performance penalty, I prefer your approach. 

I assume that's because http-bulk-updates defeats caching.  If so,
makes sense.

Please forgive my ignorance: is there a bug filed about ra_serf's
misbehavior here?  Is it eventually going to be fixed and this is
just a workaround, or is the growth in temp file use something we'd
live with permanently?

Thanks,
Jonathan
