From: Anthony Youngman <anthony@youngman.org.uk>
Subject: Re: What's cooking extra
Date: Tue, 25 May 2010 09:27:00 +0100
Message-ID: <4BFB89D4.5070308@youngman.org.uk>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org> <20100519170656.GA30161@pvv.org> <20100522130916.GA28452@localhost> <50199F1F-3513-43A6-8990-957F3D0AF58C@gmail.com> <20100522222746.GA2694@localhost> <CDD31343-2352-434B-B875-2013DAF49CE7@gmail.com> <20100523115127.GA20443@localhost> <744D05D2-FC47-45E5-92A1-CD93B0901E0C@gmail.com> <20100524094905.GA10811@localhost> <986EE696-5997-40AD-929C-D82D40D7242E@gmail.com> <20100524221128.GA29588@localhost> <246B0C3F-EBD3-41EC-B0FD-300BD1DBF43E@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Clemens Buchacher <drizzd@aon.at>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 25 10:28:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGpVD-0000Fv-Lb
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 10:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754415Ab0EYI2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 04:28:38 -0400
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:62448 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754082Ab0EYI2h (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 May 2010 04:28:37 -0400
Received: from dyn-62-56-66-208.dslaccess.co.uk ([62.56.66.208] helo=[192.168.2.2])
	by lon1-post-1.mail.demon.net with esmtpa (AUTH thewolery)
	(Exim 4.69)
	id 1OGpV6-0001jU-X2; Tue, 25 May 2010 08:28:36 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100418 Thunderbird/3.0.4
In-Reply-To: <246B0C3F-EBD3-41EC-B0FD-300BD1DBF43E@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147682>

On 05/25/10 07:41, Eyvind Bernhardsen wrote:
> The "safe autocrlf" patch fixes this by not trying to normalize any files that are not already normalized in the index.  This is what you noticed: the files do not show up as dirty and will not have their line endings converted.  The tradeoff is that setting "core.autocrlf" no longer normalizes all text files, only new ones and ones that are already normalized.
>
> You (rightly) expected line endings to be normalized to LF when core.eol=lf, and I do need to fix that in the documentation.  Safe autocrlf _only_ works if you want CRLF line endings in your working directory.
>   
Just a suggestion ...
For core.autocrlf (or somewhere else more appropriate) could we add to
false and true the option "force"?

Bearing in mind "force" is always considered "a bit dangerous", that
merely means "I don't care if it has crlf in the repository, change all
commits to lf" (and checkouts to crlf if appropriate).

Yep, things are likely to break, but I'm thinking this is the sort of
situation where a lead dev could say to themselves "I know what I'm
doing, we need to clean up, and if I set that as my options, then I know
I can fix any resulting mess".

Cheers,
Wol
