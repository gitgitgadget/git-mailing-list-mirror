From: Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: git status internals and line endings
Date: Fri, 13 Nov 2009 12:01:01 +0100
Message-ID: <4AFD3C6D.3010008@syntevo.com>
References: <4AFC70CE.5020106@syntevo.com>	 <20091113001547.GB28836@sigill.intra.peff.net>	 <4AFD1414.6030907@syntevo.com> <40aa078e0911130104v6acdecedxf629c5ef35a62740@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Nov 13 12:01:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8ttu-0006nf-Dy
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 12:01:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756031AbZKMLA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 06:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755993AbZKMLA6
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 06:00:58 -0500
Received: from syntevo.com ([85.214.39.145]:45084 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753835AbZKMLA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 06:00:58 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTP id 22B0C37C9B4
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <40aa078e0911130104v6acdecedxf629c5ef35a62740@mail.gmail.com>
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132833>

> In order to make changes to core.autocrlf effective, you need to
> delete .git/index and perform a hard reset:
> $ rm .git/index
> $ git reset --hard

This solved my problem. Thank you!

--
Best regards,
Marc Strapetz
=============
syntevo GmbH
http://www.syntevo.com
http://blog.syntevo.com



Erik Faye-Lund wrote:
> On Fri, Nov 13, 2009 at 9:08 AM, Marc Strapetz
> <marc.strapetz@syntevo.com> wrote:
>>> Sounds like the core.autocrlf setting (see "git help config"), which I
>>> believe is set by default on Windows.
>> I have checked both $GIT_DIR/config and ~/.gitconfig and autocrlf has
>> not been set. I have then set autocrlf = false for the Windows
>> repository and still the file didn't show up as modified. On Linux, I've
>> added autocrlf = true (resp. autocrlf = input) for the repository and
>> still the file shows up as modified. Not that I don't like this
>> behavior, but I don't understand it :) Windows Git version is 1.6.5.1,
>> Linux version is 1.6.3.3.
>>
> 
> In order to make changes to core.autocrlf effective, you need to
> delete .git/index and perform a hard reset:
> $ rm .git/index
> $ git reset --hard
> 
> Did you do this before checking if the files were modified?
> 
