From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: OT: data destruction classics (was: Re: Error converting from 1.4.4.1 to 1.5.0?)
Date: Thu, 15 Feb 2007 09:13:52 +0000
Message-ID: <200702150914.01361.andyparkins@gmail.com>
References: <17875.13564.622087.63653@lisa.zopyra.com> <17875.36879.872210.264473@lisa.zopyra.com> <45D3B4E7.8050408@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>,
	Bill Lear <rael@zopyra.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 15 10:14:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHch9-0005Fs-0l
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 10:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965294AbXBOJOJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 04:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965336AbXBOJOJ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 04:14:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:41056 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965294AbXBOJOG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 04:14:06 -0500
Received: by ug-out-1314.google.com with SMTP id 44so85673uga
        for <git@vger.kernel.org>; Thu, 15 Feb 2007 01:14:05 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=cOaqjKgBccZaLnPjzVagsnTwy6Xq+2qLmMxASlTt3dvvPkS1Emoo1NLFSPpFHT0lvHCrJP70T+2i9EKPXmHecjSJCqc3rb2K6EijuHhIlJlbtf9h7Zevpt2cGf2QUbpdMFdVR7ti9chu4DPvtzMGWifKeJEzKZ+qEP8uur6RJxk=
Received: by 10.67.92.1 with SMTP id u1mr1444509ugl.1171530845390;
        Thu, 15 Feb 2007 01:14:05 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id j33sm1871528ugc.2007.02.15.01.14.03;
        Thu, 15 Feb 2007 01:14:03 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <45D3B4E7.8050408@fs.ei.tum.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39802>

On Thursday 2007 February 15 01:18, Simon 'corecode' Schubert wrote:

> > I'm still muttering to myself that I could be that dumb...

How about this:

1) "I should like to clean up root's home directory"
2) cd /root; ls -la .
3) "Oh, there are a lot of config file in this directory that I don't need any
   more"
4) rm -rf .*

Now start crying softly to yourself, when you realise that ".." is covered 
by ".*".  Now go to every computer you work on and put

  export GLOBIGNORE=".:.."

In your .bashrc.

Boy, was my face red...



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
