From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: Install issues
Date: Tue, 11 Nov 2008 16:03:50 -0700
Message-ID: <alpine.LNX.2.00.0811111554530.19159@suse104.zenez.com>
References: <20081110121739.15f77a01@pc09.procura.nl> <20081110113924.GR24201@genesis.frugalware.org> <20081110173101.3d76613b@pc09.procura.nl> <20081110175123.GV24201@genesis.frugalware.org> <7vhc6e17fv.fsf@gitster.siamese.dyndns.org>
 <20081111190243.7044d6cb@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Nov 12 00:05:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L02Iy-000711-OJ
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 00:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbYKKXDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 18:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbYKKXDx
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 18:03:53 -0500
Received: from suse104.zenez.com ([198.60.105.164]:7710 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbYKKXDw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 18:03:52 -0500
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id B4891A7C9D4; Tue, 11 Nov 2008 16:03:50 -0700 (MST)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id A8E5FA7C9D3;
	Tue, 11 Nov 2008 16:03:50 -0700 (MST)
In-Reply-To: <20081111190243.7044d6cb@pc09.procura.nl>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100689>

On Tue, 11 Nov 2008, H.Merijn Brand wrote:
> On Tue, 11 Nov 2008 09:47:00 -0800, Junio C Hamano <gitster@pobox.com>
> wrote:
>> Miklos Vajna <vmiklos@frugalware.org> writes:
>>> On Mon, Nov 10, 2008 at 05:31:01PM +0100, "H.Merijn Brand" <h.m.brand@xs4all.nl> wrote:
>>>> --- Makefile.org	2008-11-10 17:29:53.000000000 +0100
>>>> +++ Makefile	2008-11-10 17:29:39.000000000 +0100
>>>> @@ -1329,6 +1329,10 @@ check-sha1:: test-sha1$X
>>>>  	./test-sha1.sh
>>>>
>>>>  check: common-cmds.h
>>>> +	@`sparse </dev/null 2>/dev/null` || (\
>>>> +	    echo "The 'sparse' command is not available, so I cannot make the 'check' target" ;\
>>>> +	    echo "Did you mean 'make test' instead?" ;\
>>>> +	    exit 1 )
>>>>  	for i in *.c; do sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i || exit; done
>>>
>>> Please read Documentation/SubmittingPatches, your patch lacks a signoff
>>> and a commit message.

Here is a check list I use to make sure my patches are OK.

http://repo.or.cz/w/git.git?a=blob_plain;f=Documentation/SubmittingPatches;hb=HEAD

...
> I'm by now way offended or scared away if you reject these kind of
> patches

The crowed here may seem harsh but they really are not.  They just have a 
lot to do and getting things to them in a format that is easy to follow 
and uses the above URL guildlines assists them in looking at the patches, 
commit messages and sign-off.  Git requires a sign-off in order for them 
to use the patches.  It is a way to make sure everything is kept above 
board and proper.  This allow ever line of code to have a resource as to 
where and whence it ...

Do not give up.  Just try to do things in a manner that is easy to allow 
your patches into Git.

Good Luck,

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
