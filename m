From: "mike zheng" <mail4mz@gmail.com>
Subject: Error in compile Git 1.6.0.rc1
Date: Tue, 29 Jul 2008 13:50:31 -0400
Message-ID: <5c9cd53b0807291050i752f91b9yc1da4afb7096ab61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 19:51:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNtMF-0004d7-HC
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 19:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753019AbYG2Ruf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 13:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752866AbYG2Rue
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 13:50:34 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:34433 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658AbYG2Rud (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 13:50:33 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1576684ywe.1
        for <git@vger.kernel.org>; Tue, 29 Jul 2008 10:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=xiLKaXyRp+MsXqsFToURghFCufvc6ZDokn+Okv6NMS4=;
        b=Ik83YpAODocwYOwIHAfY4f6INBGO4yNzROtQtgi3vBIcdGyGK42Pm66N8hxrPPeAKz
         FuF8t6LzTwr7MwKXsgBpTw9BDq1howrZe+5798gjQ/LC/hfX5+RKzNP7KM061z5ctCOg
         y0by9L1A8Bf35U1iuRJnQQuCLukFJnXh+30IA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=onVKhAepf/wkiOBOvi7NXZenirPeb7h9PzSZv9ouxfcEfLv1vV1Y++1SaFtDM7SQ83
         M/fS/2+OIhPCP7VXe+t9vHqe0h23f4vgQBQsozZEj5evNVObMmJYjurEnjyj12HfOsu/
         sjbu432afW0Bo+lUnjSkjMeDBvwxCHJh40zbg=
Received: by 10.141.97.5 with SMTP id z5mr3442891rvl.197.1217353831908;
        Tue, 29 Jul 2008 10:50:31 -0700 (PDT)
Received: by 10.141.70.9 with HTTP; Tue, 29 Jul 2008 10:50:31 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90662>

Hello,

I download the git-1.6.0.rc.tar.gz from
http://www.kernel.org/pub/software/scm/git/. When I try to compile it
on RH linux, I have following errors. Any idea?

Thanks,

Mike

/localdisk/work/git-1.6.0.rc1-> make
/bin/sh: curl-config: command not found
GIT_VERSION = 1.6.0.rc1
/bin/sh: curl-config: command not found
    * new build flags or prefix
    CC fast-import.o
    CC abspath.o
    CC alias.o
    CC alloc.o
    CC archive.o
    CC archive-tar.o
    CC archive-zip.o
    CC attr.o
    CC base85.o
    CC blob.o
    CC branch.o
    CC bundle.o
    CC cache-tree.o
    CC color.o
    CC combine-diff.o
    CC commit.o
    CC config.o
    CC connect.o
    CC convert.o
    CC copy.o
    CC csum-file.o
    CC ctype.o
    CC date.o
    CC decorate.o
    CC diffcore-break.o
    CC diffcore-delta.o
    CC diffcore-order.o
    CC diffcore-pickaxe.o
    CC diffcore-rename.o
    CC diff-delta.o
    CC diff-no-index.o
    CC diff-lib.o
    CC diff.o
    CC dir.o
    CC editor.o
    CC entry.o
    CC environment.o
    CC exec_cmd.o
    CC fsck.o
    CC graph.o
    CC grep.o
    CC hash.o
    GEN common-cmds.h
    CC help.o
    CC ident.o
    CC interpolate.o
    CC list-objects.o
    CC ll-merge.o
    CC lockfile.o
    CC log-tree.o
    CC mailmap.o
    CC match-trees.o
    CC merge-file.o
    CC name-hash.o
    CC object.o
    CC pack-check.o
    CC pack-refs.o
    CC pack-revindex.o
    CC pack-write.o
    CC pager.o
    CC parse-options.o
    CC patch-delta.o
    CC patch-ids.o
    CC string-list.o
    CC path.o
    CC pkt-line.o
    CC pretty.o
    CC progress.o
    CC quote.o
    CC reachable.o
    CC read-cache.o
    CC reflog-walk.o
    CC refs.o
    CC remote.o
    CC rerere.o
    CC revision.o
    CC run-command.o
    CC server-info.o
    CC setup.o
    CC sha1_file.o
    CC sha1-lookup.o
    CC sha1_name.o
    CC shallow.o
    CC sideband.o
    CC strbuf.o
    CC symlinks.o
    CC tag.o
    CC trace.o
    CC transport.o
In file included from transport.c:5:
http.h:6:23: curl/curl.h: No such file or directory
http.h:7:23: curl/easy.h: No such file or directory
In file included from transport.c:5:
http.h:42: error: syntax error before "CURLcode"
http.h:42: warning: no semicolon at end of struct or union
http.h:44: error: syntax error before '}' token
http.h:48: error: syntax error before "CURL"
http.h:48: warning: no semicolon at end of struct or union
http.h:51: error: syntax error before "curl_result"
http.h:51: warning: type defaults to `int' in declaration of `curl_result'
http.h:51: warning: data definition has no type or storage class
http.h:58: error: syntax error before '}' token
http.h:90: error: `CURL_ERROR_SIZE' undeclared here (not in a function)
http.h: In function `missing__target':
http.h:95: error: `CURLE_FILE_COULDNT_READ_FILE' undeclared (first use
in this function)
http.h:95: error: (Each undeclared identifier is reported only once
http.h:95: error: for each function it appears in.)
http.h:97: error: `CURLE_HTTP_NOT_FOUND' undeclared (first use in this function)
http.h:99: error: `CURLE_FTP_COULDNT_RETR_FILE' undeclared (first use
in this function)
transport.c: In function `get_refs_via_curl':
transport.c:438: error: storage size of 'results' isn't known
transport.c:456: error: dereferencing pointer to incomplete type
transport.c:457: warning: implicit declaration of function `curl_easy_setopt'
transport.c:457: error: dereferencing pointer to incomplete type
transport.c:457: error: `CURLOPT_FILE' undeclared (first use in this function)
transport.c:458: error: dereferencing pointer to incomplete type
transport.c:458: error: `CURLOPT_WRITEFUNCTION' undeclared (first use
in this function)
transport.c:459: error: dereferencing pointer to incomplete type
transport.c:459: error: `CURLOPT_URL' undeclared (first use in this function)
transport.c:460: error: dereferencing pointer to incomplete type
transport.c:460: error: `CURLOPT_HTTPHEADER' undeclared (first use in
this function)
transport.c:464: error: `CURLE_OK' undeclared (first use in this function)
transport.c:438: warning: unused variable `results'
make: *** [transport.o] Error 1
