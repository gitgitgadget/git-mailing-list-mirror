From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Fw: [git-users] How do I git-push to an FTP server?
Date: Mon, 8 Oct 2012 12:53:18 +0530
Message-ID: <CALkWK0nSxBsiE5_BZ67dPrwDRQSipL0LBR9Pf252iqL21HwZBA@mail.gmail.com>
References: <20121005173833.e96c4fcfed0cce5b78911b0b@domain007.com>
 <CAGK7Mr4L0Us3ykLUoWBdyR2zJUNa_HNguwb-=dEq_h_yXThPPA@mail.gmail.com>
 <CAEcj5uW4aw19MgNi8vJk5TWoL6SEad=s2jthS-h1jLTtuPq7AQ@mail.gmail.com>
 <7vwqz4si87.fsf@alter.siamese.dyndns.org> <CALkWK0kXH-U0mTeFtiMq7tqCOpNJT1A7Z==GxOphe-sGdmxRRg@mail.gmail.com>
 <20121007172754.GA29560@elie.Belkin> <7vvcemovrh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	git@vger.kernel.org, git-users@googlegroups.com,
	August Karlstrom <fusionfile@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 09:23:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TL7gs-00035l-I7
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 09:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683Ab2JHHXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 03:23:41 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:49731 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545Ab2JHHXj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 03:23:39 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so1867833qad.19
        for <git@vger.kernel.org>; Mon, 08 Oct 2012 00:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bt91QsfPqRldBKN5YTVrHw/p+e2xqJDizfLURkiCTXE=;
        b=OFWBqMID9w3oOt+wSoSCBeSmlaYCxLt97ug0jDKUvij/KaemgI+BY8Gg0zUvsKj9Jj
         PpiG11d2Sx93Tj6t8UMTaya9DnZ6GB8/XNlrt+Z+KRd4pheuW8DKZiVA8MFsQbfrDY+5
         ssO0jgdVDOdZlp2UUuceFN3c7z0NJBGz6LH9R1vOwsLJW3TpUjf95ffK5MczNu45R3cB
         vyfKGOHuo00hPcTizk+yceIITOFzjYbT25OWVos3zzBxRYpFzklH5A1dvjJlPqiowKLq
         yqGQ/GN8SXLYiDsAAXDZpexea23pEADMokJRneYHw5Y+Eb/h7IKq7RikmnMHROe5JWmV
         Fh9g==
Received: by 10.49.14.193 with SMTP id r1mr40629188qec.50.1349681018739; Mon,
 08 Oct 2012 00:23:38 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Mon, 8 Oct 2012 00:23:18 -0700 (PDT)
In-Reply-To: <7vvcemovrh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207222>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Ramkumar Ramachandra wrote:
>>>> Thomas Ferris Nicolaisen <tfnico@gmail.com> writes:
>>
>>>>> At least according to the documentation[1], "Git natively supports [...] ftp".
>>>>>
>>>>> This could need some clarification if pushing over ftp is not supported.
>> [...]
>>> -Git natively supports ssh, git, http, https, ftp, ftps, and rsync
>>> -protocols. The following syntaxes may be used with them:
>>> +Git natively supports ssh, git, http, https, and rsync protocols. The
>>> +following syntaxes may be used with them:
>>
>> Perhaps the initial list should not be exhaustive, in which case we
>> could say:
>>
>>       Git natively supports ssh, git, http, and https protocols.  The
>>       following syntaxes may be used with them:
>>
>>       ...
>>
>>       Git also has (less efficient) support for fetching and pushing
>>       over rsync protocol and fetching over ftp or ftps, using the
>>       same "protocol://host/path/to/repo.git/" syntax.
>
> Yeah, that, possibly with "These are deprecated; do not use them.",
> would be a better way forward.  As we deprecated "rsync" long time
> ago, perhaps we should remove it at Git 2.0 or somewhere around
> that.

I see.  Will we remove ftp[s] support too?  I hope this is in order.

-- 8< --
From: Ramkumar Ramachandra <artagnon@gmail.com>
Date: Sun, 7 Oct 2012 20:57:15 +0530
Subject: [PATCH] Documentation/urls: mark rsync and ftp[s] as deprecated

Fetching and pushing over rsync, and fetching over ftp or ftps are
deprecated, and will soon be removed.  Add a note saying this.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/urls.txt | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 2890194..653b61c 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -6,14 +6,12 @@ address of the remote server, and the path to the repository.
 Depending on the transport protocol, some of this information may be
 absent.

-Git natively supports ssh, git, http, https, ftp, ftps, and rsync
-protocols. The following syntaxes may be used with them:
+Git natively supports ssh, git, http, and https protocols. The
+following syntaxes may be used with them:

 - ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/path/to/repo.git/
 - git://host.xz{startsb}:port{endsb}/path/to/repo.git/
 - http{startsb}s{endsb}://host.xz{startsb}:port{endsb}/path/to/repo.git/
-- ftp{startsb}s{endsb}://host.xz{startsb}:port{endsb}/path/to/repo.git/
-- rsync://host.xz/path/to/repo.git/

 An alternative scp-like syntax may also be used with the ssh protocol:

@@ -31,6 +29,11 @@ syntaxes may be used:
 - /path/to/repo.git/
 - file:///path/to/repo.git/

+ Git also has (less efficient) support for fetching and pushing over
+ rsync protocol and fetching over ftp or ftps, using the same
+ "protocol://host/path/to/repo.git/" syntax.  However, these are
+ deprecated, and will soon be removed.
+
 ifndef::git-clone[]
 These two syntaxes are mostly equivalent, except when cloning, when
 the former implies --local option. See linkgit:git-clone[1] for
-- 
1.7.12.1.428.g652398a.dirty
