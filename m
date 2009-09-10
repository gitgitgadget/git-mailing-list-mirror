From: Tim Potter <tpot@hp.com>
Subject: Re: [git-svn] always prompted for passphrase with subversion 1.6
Date: Thu, 10 Sep 2009 10:58:46 +1000
Message-ID: <4AA84F46.6010706@hp.com>
References: <4A95D58C.1070409@hp.com> <20090905064649.GD22272@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Sep 10 02:59:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlY02-0004oj-1Z
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 02:58:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956AbZIJA6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 20:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752897AbZIJA6r
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 20:58:47 -0400
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:15254 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbZIJA6r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 20:58:47 -0400
Received: from g5t0012.atlanta.hp.com (unknown [15.192.0.16])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g5t0009.atlanta.hp.com (Postfix) with ESMTPS id 5A114302DD;
	Thu, 10 Sep 2009 00:58:50 +0000 (UTC)
Received: from [16.176.26.157] (tigerella.asiapacific.hpqcorp.net [16.176.26.157])
	by g5t0012.atlanta.hp.com (Postfix) with ESMTPSA id 1E89810012;
	Thu, 10 Sep 2009 00:58:48 +0000 (UTC)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <20090905064649.GD22272@dcvr.yhbt.net>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128093>

Eric Wong wrote:
> Tim Potter <tpot@hp.com> wrote:
>> Hi everyone.  I am using git-svn with the Subversion 1.6 client compiled
>> with GNOME Keyring support.  This neat features allows a SSL client
>> certificate password to be cached inside GNOME Keyring instead of being
>> prompted to enter it every time.  However the git-svn script doesn't
>> appear to know about this and always prompts for a password.
>>
>> Obviously there's some tweak required in the _auth_providers()
>> subroutine but I don't know enough about the Subversion Perl client to
>> figure out a fix.
>>
>> Has anyone else run in to this problem?  I did a quick search on the
>> list but didn't find anything relevant.
> 
> Hi Tim,
> 
> I think one user wanted to get SSL certificate authentication going but
> my SSL knowledge was too weak at the time[1] and I think we both forgot
> about it or lost interest.

Hi Eric.  Thanks for the reply.

It's probably just a matter of adding another entry to the
_auth_providers() function in git-svn.  My thought was that there might
be a new auth provider in the Subversion 1.6 client library for GNOME
Keyring support that could be used for this.

I'll have a search through and see what I can find.


Regards,

Tim.
