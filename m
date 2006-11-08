X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in git.git
Date: Wed, 08 Nov 2006 08:40:07 +0100
Organization: At home
Message-ID: <eis1j6$vug$2@sea.gmane.org>
References: <7v8ximwrm3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 8 Nov 2006 07:39:54 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 24
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31126>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ghi2D-0002vk-BO for gcvg-git@gmane.org; Wed, 08 Nov
 2006 08:39:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752768AbWKHHjk convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006 02:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753189AbWKHHjk
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 02:39:40 -0500
Received: from main.gmane.org ([80.91.229.2]:46292 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1752768AbWKHHjj (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 02:39:39 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Ghi1v-0002tD-TV for git@vger.kernel.org; Wed, 08 Nov 2006 08:39:27 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 08 Nov 2006 08:39:27 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 08 Nov 2006
 08:39:27 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> =A0 =A0Jakub Narebski (4):
[...]
> =A0 =A0 =A0 gitweb: Output also empty patches in "commitdiff" view

I think that this patch is a bit premature. Without "new improved patch=
set
view" the empty patches are just that: totally empty. It is new header =
and
especially outputting extended header information which makes outputtin=
g
"empty" patches (with no diff) in "commitdiff" view usefull. By "empty"
patches I mean pure type change, pure rename, pure copy and type change=
 and
rename.

The "new improved patchset view" is prepared to send in two stages: upd=
ated
filename quoting/unquoting series (two patches: unescape + minimal
esc_path; esc_path with span.cntrl and backslash sequence quoting), and
"new improved patchset view" (three patches originally, two remains: us=
ing
"git diff" header and extended git diff headers; output and link also t=
o
patches with empty diff; improved formatting of chunk header).
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

