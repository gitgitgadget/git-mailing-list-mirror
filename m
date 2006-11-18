X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Possible but in gitweb
Date: Sat, 18 Nov 2006 17:58:51 +0100
Message-ID: <4d8e3fd30611180858xf28e958g8511f2eb68d53848@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 18 Nov 2006 16:59:24 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FzvBwamwXX7N95C5Pwb3jS8nDR1muPZ5Q2rY7/i7dwWEqhHnpgPpRoJfmGUEndirdZrdueyARBUCGV5rasevzcWbr7ZLlIRyntKQ53Sx3kBX8Jnpr8TJ8hJrrU3p1YHDZJJ4HQwCytSFvm+pBao7KnjdBfCalFb0bCe1W8QFZf4=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31778>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlTXD-000589-KK for gcvg-git@gmane.org; Sat, 18 Nov
 2006 17:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754641AbWKRQ6y convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006 11:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755189AbWKRQ6y
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 11:58:54 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:29723 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1754641AbWKRQ6x
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006
 11:58:53 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1736939nfa for
 <git@vger.kernel.org>; Sat, 18 Nov 2006 08:58:52 -0800 (PST)
Received: by 10.78.193.19 with SMTP id q19mr3362586huf.1163869131787; Sat, 18
 Nov 2006 08:58:51 -0800 (PST)
Received: by 10.78.165.3 with HTTP; Sat, 18 Nov 2006 08:58:51 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

Hi all,
I'm playing with a repo hosted by repos.os.cz and I think I faced a
bug (Pasky confirmed that this should be reported here as a bug).

My repo has two branches,
master
html

Master contains a text file while html contains his conversion in html
done via asciidoc.

I need to URLs that point to the top of the branches in order to have
an easy way for lnkind the documentation to external portals.

This link points to HEAD, so top of master:
http://repo.or.cz/w/LinuxKernelDevelopmentProcess.git?a=3Dblob_plain;f=3D=
LinuxKernelDevelopmentProcess;hb=3DHEAD

Browsing the repo I reach the following URL
http://repo.or.cz/w/LinuxKernelDevelopmentProcess.git?a=3Dblob;f=3DLinu=
xKernelDevelopmentProcess.html;hb=3DHEAD
that is not accessible.

Looks like is not possible to obtain a link to the top of a branch
different from master.

Regards,
--=20
Paolo
http://docs.google.com/View?docid=3Ddhbdhs7d_4hsxqc8
http://www.linkedin.com/pub/0/132/9a3
Non credo nelle otto del mattino. Per=F2 esistono. Le otto del mattino
sono l'incontrovertibile prova della presenza del male nel mondo.
