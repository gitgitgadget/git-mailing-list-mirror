From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Documentation: do not misinterpret refspecs as bold text
 (Re: Git fast-import : Warning duplicated ref: refs/remotes/origin/master)
Date: Mon, 30 May 2011 10:52:56 -0500
Message-ID: <20110530155256.GC10879@elie>
References: <BANLkTinTuEppMGO16z2sMkjV8FveCbrwEQ@mail.gmail.com>
 <20110529232405.GA8369@elie>
 <BANLkTinhH7ksP8EZV+Sd4ryCT1_bhVhgaw@mail.gmail.com>
 <20110530145203.GA10879@elie>
 <BANLkTinRscvPLHbob55pxhXSTKqm+eSF6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Mike Hommey <mh@glandium.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?SsOpcsOpbWll?= NIKAES <jeremie.nikaes@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 17:53:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR4mJ-0003dc-4b
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 17:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757009Ab1E3PxE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2011 11:53:04 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49819 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359Ab1E3PxC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2011 11:53:02 -0400
Received: by gwaa18 with SMTP id a18so1452315gwa.19
        for <git@vger.kernel.org>; Mon, 30 May 2011 08:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=dNWr53+dYCntE/329N9N9HcLrP+4mD2pj4NebjIcm2w=;
        b=elQnLs1hYGyDYv1shqPJYV5qHAB48shyehs0Q0ebTxx3c6s+nt3hLsKIeBZCReJdVZ
         R3PW+H4sjep95M5qTT2k294XuSRyey4jcXcctTOSezRVaGc+HeTI4xPuAmGwDmlWCVMV
         23n5ngDzPLnJ+q0IGjgH2ba44s298SiOtTk3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=vDNcnXj3wnrmzEo9osxnAzdMJQZ2Py3t2esM0N53xIc3qhUjaFkK93AEE7AkU6EtCi
         7B5GQTJ9EG0al3LYWKIRoInq1gX1pdIq67Y4FxijbkdXfAD5hvtafr30uqXAeGgRiWuA
         ZHfffRIFJcjAjkN/VxRLXDewA7SwT8zMSAWCI=
Received: by 10.236.184.225 with SMTP id s61mr6431986yhm.485.1306770781345;
        Mon, 30 May 2011 08:53:01 -0700 (PDT)
Received: from elie (adsl-69-209-65-98.dsl.chcgil.sbcglobal.net [69.209.65.98])
        by mx.google.com with ESMTPS id e48sm2572922yhk.56.2011.05.30.08.52.59
        (version=SSLv3 cipher=OTHER);
        Mon, 30 May 2011 08:53:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTinRscvPLHbob55pxhXSTKqm+eSF6g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174756>

J=C3=A9r=C3=A9mie NIKAES wrote:

> Ok I just committed my changes to the master branch, feel free to pul=
l
> and try it out.

Nice.  Now I get

| $ git fetch --all
[...]
| Fetching & writing export data...
| 1/2: Revision n=C2=B07 of New_page
| 2/2: Revision n=C2=B08 of New_page
|=20
| error: Ref refs/remotes/origin/master is at d94a46270250454f1fc6c1fb4=
7abfde31a2196c9 but expected dfb79bbc658333d5c9b0427b71f6b1bc48629949
| From mediawiki::http://localhost/mediawiki
|  ! dfb79bb...c57c15b master     -> origin/master  (unable to update l=
ocal ref)
| error: Could not fetch origin

which means that the transport machinery thought the helper was going
to be fetching directly to "master".  I suspect you will want a
'refspec' capability like

	refspec refs/heads/*:refs/mediawiki/${remotename}/*

to fix this.

Cc-ing Daniel who invented v1.7.0-rc0~62^2~19 (Allow helper to map
private ref names into normal names, 2009-11-18).  What namespace
should a helper use when asked to fetch to FETCH_HEAD without a remote
name, like

	git fetch mediawiki::testwiki

?

-- >8 --
Subject: Documentation: do not misinterpret refspecs as bold text

In v1.7.3.3~2 (Documentation: do not misinterpret pull refspec as bold
text, 2010-12-03) many uses of asterisks in expressions like
"refs/heads/*:refs/svn/origin/branches/*" were escaped as {asterisk}
to avoid being treated as delimiters for bold text, but these two were
missed.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-remote-helpers.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-r=
emote-helpers.txt
index 87cd11f..58f6ad4 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -181,11 +181,11 @@ CAPABILITIES
 	When using the import command, expect the source ref to have
 	been written to the destination ref. The earliest applicable
 	refspec takes precedence. For example
-	"refs/heads/*:refs/svn/origin/branches/*" means that, after an
-	"import refs/heads/name", the script has written to
+	"refs/heads/{asterisk}:refs/svn/origin/branches/{asterisk}" means
+	that, after an "import refs/heads/name", the script has written to
 	refs/svn/origin/branches/name. If this capability is used at
 	all, it must cover all refs reported by the list command; if
-	it is not used, it is effectively "*:*"
+	it is not used, it is effectively "{asterisk}:{asterisk}"
=20
 REF LIST ATTRIBUTES
 -------------------
--=20
1.7.5.3
