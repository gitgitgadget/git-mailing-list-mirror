From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git files data formats documentation
Date: Sat, 05 Aug 2006 20:41:32 +0200
Organization: At home
Message-ID: <eb2onf$7up$1@sea.gmane.org>
References: <44D42F0D.3040707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Aug 05 20:41:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9R5K-0001bX-Fn
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 20:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWHESlM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 5 Aug 2006 14:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWHESlM
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 14:41:12 -0400
Received: from main.gmane.org ([80.91.229.2]:21222 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751466AbWHESlL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Aug 2006 14:41:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G9R5B-0001Yu-UR
	for git@vger.kernel.org; Sat, 05 Aug 2006 20:41:09 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 20:41:09 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 20:41:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24924>

A Large Angry SCM wrote:

> <TREE_ENTRY>
> =A0=A0=A0=A0=A0=A0=A0=A0# The type of the object referenced MUST be a=
ppropriate for
> =A0=A0=A0=A0=A0=A0=A0=A0# the mode. Regular files and symbolic links =
reference a BLOB
> =A0=A0=A0=A0=A0=A0=A0=A0# and directories reference a TREE.
> =A0=A0=A0=A0=A0=A0=A0=A0:=A0=A0=A0=A0=A0=A0=A0<OCTAL_MODE> <SP> <NAME=
> <NUL> <BINARY_OBJ_ID>
> =A0=A0=A0=A0=A0=A0=A0=A0;
[...]
> <OCTAL_MODE>
> =A0=A0=A0=A0=A0=A0=A0=A0# Octal encoding, without prefix, of the file=
 system object
> =A0=A0=A0=A0=A0=A0=A0=A0# type and permission bits. The bit layout is=
 according to the
> =A0=A0=A0=A0=A0=A0=A0=A0# POSIX standard, with only regular files, di=
rectories, and
> =A0=A0=A0=A0=A0=A0=A0=A0# symbolic links permitted. The actual permis=
sion bits are
> =A0=A0=A0=A0=A0=A0=A0=A0# all zero except for regular files. The only=
 permission bit
> =A0=A0=A0=A0=A0=A0=A0=A0# of any consequence to Git is the owner exec=
utable bit. By
> =A0=A0=A0=A0=A0=A0=A0=A0# default, the permission bits for files will=
 be either 0644
> =A0=A0=A0=A0=A0=A0=A0=A0# or 0755, depending on the owner executable =
bit.
> =A0=A0=A0=A0=A0=A0=A0=A0;

I do wonder why there is <OCTAL_MODE> (and not <BINARY_OCTAL_MODE>)=20
but <BINARY_OBJ_ID> (and not <HEX_OBJ_ID>).

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
