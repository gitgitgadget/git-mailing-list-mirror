From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Fw: [git-users] How do I git-push to an FTP server?
Date: Sun, 7 Oct 2012 10:27:54 -0700
Message-ID: <20121007172754.GA29560@elie.Belkin>
References: <20121005173833.e96c4fcfed0cce5b78911b0b@domain007.com>
 <CAGK7Mr4L0Us3ykLUoWBdyR2zJUNa_HNguwb-=dEq_h_yXThPPA@mail.gmail.com>
 <CAEcj5uW4aw19MgNi8vJk5TWoL6SEad=s2jthS-h1jLTtuPq7AQ@mail.gmail.com>
 <7vwqz4si87.fsf@alter.siamese.dyndns.org>
 <CALkWK0kXH-U0mTeFtiMq7tqCOpNJT1A7Z==GxOphe-sGdmxRRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	git@vger.kernel.org, git-users@googlegroups.com,
	August Karlstrom <fusionfile@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 07 19:28:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKueM-0000qv-9o
	for gcvg-git-2@plane.gmane.org; Sun, 07 Oct 2012 19:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609Ab2JGR2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 13:28:11 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:58092 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335Ab2JGR2J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 13:28:09 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1148747dak.19
        for <git@vger.kernel.org>; Sun, 07 Oct 2012 10:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9FBSnYj7WaktjUOPKPwZh5W/tCvAaIBRCY9PggbkO4Q=;
        b=f2ZOnAu60694d2xWP4Wc3ScSPyDQU7b0JpZdqO8Y9ELhNFoQay10tH0R7corggdYQV
         w4s+Qk9eWjQDLxJWFrxCnrlbbHT5f5DPXVlAr6YKp5R22jV5CYjUvDRIdKodeXL9e0U7
         wH0kBYXB/1GGtVTGMis8scfLSP81SFh/wLwtjEEkItAVLGLc8cGQvy9rddl8qf3XFSCw
         p5l5kbLfZvb07dREGQvU7qWRpb1nQG5IzHHrs4jJMzXOe/Sc7kwo91T18v+NZtwRj1TD
         5S3Tlyi0X1xj2IM50KQNMZ4UJZ30L+Z6r1OVrQBVwsWKs0QFCvutgIfR80N4CA5+UxlE
         jWEQ==
Received: by 10.66.88.3 with SMTP id bc3mr36889880pab.51.1349630888710;
        Sun, 07 Oct 2012 10:28:08 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id kp3sm9352983pbc.64.2012.10.07.10.28.07
        (version=SSLv3 cipher=OTHER);
        Sun, 07 Oct 2012 10:28:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0kXH-U0mTeFtiMq7tqCOpNJT1A7Z==GxOphe-sGdmxRRg@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207185>

Ramkumar Ramachandra wrote:
>> Thomas Ferris Nicolaisen <tfnico@gmail.com> writes:

>>> At least according to the documentation[1], "Git natively supports [...] ftp".
>>>
>>> This could need some clarification if pushing over ftp is not supported.
[...]
> -Git natively supports ssh, git, http, https, ftp, ftps, and rsync
> -protocols. The following syntaxes may be used with them:
> +Git natively supports ssh, git, http, https, and rsync protocols. The
> +following syntaxes may be used with them:

Perhaps the initial list should not be exhaustive, in which case we
could say:

	Git natively supports ssh, git, http, and https protocols.  The
	following syntaxes may be used with them:

	...

	Git also has (less efficient) support for fetching and pushing
	over rsync protocol and fetching over ftp or ftps, using the
	same "protocol://host/path/to/repo.git/" syntax.
