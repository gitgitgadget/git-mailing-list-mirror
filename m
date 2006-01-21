From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: [PATCH] AsciiDoc fixes for the git-svnimport manpage
Date: Sat, 21 Jan 2006 20:31:09 +0100
Message-ID: <8764od8jk2.fsf@mid.deneb.enyo.de>
References: <E1F0O43-0002pn-7O@mid.deneb.enyo.de>
	<7vslrho038.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 20:31:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0OSC-0003Ud-6n
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 20:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWAUTbN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 14:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWAUTbN
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 14:31:13 -0500
Received: from mail.enyo.de ([212.9.189.167]:18856 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S932276AbWAUTbL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2006 14:31:11 -0500
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1F0OS6-00038k-Hu; Sat, 21 Jan 2006 20:31:10 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.60)
	(envelope-from <fw@deneb.enyo.de>)
	id 1F0OS5-00036I-4O; Sat, 21 Jan 2006 20:31:09 +0100
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslrho038.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 21 Jan 2006 11:24:59 -0800")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15007>

* Junio C. Hamano:

> Florian Weimer <fw@deneb.enyo.de> writes:
>
>> Change "SVN:: Perl" to "SVN::Perl", wrap a long line, and clean up the
>> description of positional arguments.
>
> Thanks.  Is this the part you mean by "positional arguments"?

Uhm, "positional arguments" are non-option arguments.

>> -<SVN_repository_URL>::
>> -	The URL of the SVN module you want to import. For local
>> -	repositories, use "file:///absolute/path".
>> -
>> -<path>
>> +<path>::
>>  	The path to the module you want to check out.
>
> This looks to me as if we do not allow non file:/// URL like
> svn:// anymore, or we never supported it but the documentation
> pretended we did.  Is that what you intended to fix?

No, there was a :: missing, and the SVN_repository_URL part was
duplicated.  The documentation tries to remind the reader that the
"/absolute/path" syntax does not work and you have to use a real URL.

(I haven't got git-svnimport to work so far, but the Subversion RA
layer is transport-agnostic, so if it works for file://, it will also
work for svn:// or http://).
