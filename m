From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: serving git with both "git:" and "http:" and submodules
Date: Wed, 14 Jul 2010 11:12:54 -0500
Message-ID: <20100714161254.GA2265@burratino>
References: <4C3DD7EF.6010805@panasas.com>
 <20100714153900.GB1583@burratino>
 <4C3DDEBA.8010509@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Boaz Harrosh <bharrosh@panasas.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 18:22:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ4ir-0000Tc-2L
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 18:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755503Ab0GNQWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 12:22:07 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45333 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757045Ab0GNQWE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 12:22:04 -0400
Received: by wyb42 with SMTP id 42so1645wyb.19
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 09:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=SIEgXY6MdNsbpg7VeVIgTiyBQLyMxSVtpNpDT0gHHas=;
        b=sDcrKiaLqLLNZBazAA0t/UJa6hOV4bQM/syZcFzOFwpT++lqf/EJWEphjl/j9AQlQc
         FskjZqr+hb2NqLTv9u47UY94a1mPoGrHtRDF5LI6VPEs9nIJgZEdNUU5X8s4QGmgqhf3
         DmxAttcS4UDa2Y8qx2iQxnTJqls5MxY42YZKA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sw4NAs3KK+SOGY6XZ7nLfXXhF43ly/64te+x730N4MwfyEaS8kffL6KtrjDNhh2RJW
         wjyd9j3ZjtcwNE9QvV9fwPqaWzASHJxuHzfvO1mdN+I9w695pg7AIEpKdyEbCfjMv3Eb
         MrH/SsMgPSvtE2LipyP9TeRgTv/2XFif1ZG1o=
Received: by 10.227.154.202 with SMTP id p10mr16306943wbw.168.1279124024909;
        Wed, 14 Jul 2010 09:13:44 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id p24sm3226523wej.39.2010.07.14.09.13.42
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 14 Jul 2010 09:13:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C3DDEBA.8010509@panasas.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151004>

Boaz Harrosh wrote:

> Ok I'll dive into "git-http-backend" (any pointers).

The reference manual[1] is all I know of.  Googling reveals a
nice overview[2] by Scott Chacon.

>                                              Are you suggesting to
> just drop the "git:" protocol? (Since "git-http-backend" is just as
> good, through http?)

Exactly[3].

> Thanks that actually helped

Glad to be useful. :)

Good luck,
Jonathan

[1] http://www.kernel.org/pub/software/scm/git/docs/git-http-backend.html
[2] http://progit.org/2010/03/04/smart-http.html
[3] Well, the protocol overhead is a little higher, but that is nothing
compared to the difference between git: and traditional static http:.
