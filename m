X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC (take 2)] gitweb: New improved patchset view
Date: Mon, 30 Oct 2006 02:21:58 +0100
Message-ID: <200610300221.58782.jnareb@gmail.com>
References: <200610291122.30852.jnareb@gmail.com> <200610300134.53668.jnareb@gmail.com> <7vr6wqy5cb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 30 Oct 2006 01:22:10 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=phCxIiLiax1JlCr2Y/nfFMD2I+5LKnwzICUHrfqjFPosSHNA20AP9tk/4SkBns7BUfZN+8MMSZJ7G6uWSykSmsIlxLEDHIVFLYw0DgYZXQHU5MTliZa3UD4db6ee5Y/F2dTpDycq0vlviizVfv3XALw79IuS/L+novF1iYNa1/M=
User-Agent: KMail/1.9.3
In-Reply-To: <7vr6wqy5cb.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30478>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeLqk-0004HG-8x for gcvg-git@gmane.org; Mon, 30 Oct
 2006 02:22:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965465AbWJ3BV7 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006 20:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965466AbWJ3BV7
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 20:21:59 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:63220 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S965465AbWJ3BV6
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 20:21:58 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1034844ugm for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 17:21:57 -0800 (PST)
Received: by 10.67.21.11 with SMTP id y11mr3331602ugi; Sun, 29 Oct 2006
 17:21:57 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id e1sm2649331ugf.2006.10.29.17.21.56; Sun, 29 Oct
 2006 17:21:56 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> 3. Should we make from-range/to-range in chunk header hyperlink to t=
he=20
>> start of given bunch of lines in appropriate file? Or perhaps to the=
=20
>> middle of the bunch of lines? Or to first changed line (omitting=20
>> context)?
>=20
> I do not see what usage pattern this link would help. =A0Care to
> explain a bit better?

=46or example for the following header

diff --git _a/gitweb/gitweb.perl_ _b/gitweb/gitweb.perl_
index _cbab3c9_.._a5a140c_ 100755
--- a/_gitweb/gitweb.perl_
+++ b/_gitweb/gitweb.perl_
@@ _-1255,9_ _+1255,12_ @@ sub parse_difftree_raw_line {

The '-1255,9' would be link to older version of gitweb/gitweb.perl file=
,
directly to the line #1255 (or to first changed line, or to the middle
of the chunk i.e. 1255+9/2 line).

The '+1255,12' would be link to newer version of file, to line 1255.
--=20
Jakub Narebski
