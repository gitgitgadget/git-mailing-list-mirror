X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] merge-recursive: configurable 'merge' program
Date: Tue, 5 Dec 2006 16:01:50 +0100
Message-ID: <200612051601.50784.jnareb@gmail.com>
References: <20061204235647.9BA8B139B0E@magnus.utsl.gen.nz> <200612051526.12636.jnareb@gmail.com> <Pine.LNX.4.63.0612051540230.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 5 Dec 2006 15:00:03 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=q5IuKgAVcZFhwL0YawJM/aC64VJ7VJGgn1YCz3NOVvPcX9tQ6pvFLLo5w/htJLu0DRF3s0ogV68wHHgn1WtCVUYldENPZTf0WcMDaQNtHV1jM9MJgCXUcJn19j3qtTOeaewXLqUaFeuCZBLpJYIWMSf3/dyU5US4vqxM0GXmQhc=
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0612051540230.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33347>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grbm2-0002zh-Cx for gcvg-git@gmane.org; Tue, 05 Dec
 2006 15:59:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759830AbWLEO7t convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006 09:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759846AbWLEO7t
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 09:59:49 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:42609 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1759636AbWLEO7s (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec
 2006 09:59:48 -0500
Received: by ug-out-1314.google.com with SMTP id 44so3351299uga for
 <git@vger.kernel.org>; Tue, 05 Dec 2006 06:59:47 -0800 (PST)
Received: by 10.66.221.6 with SMTP id t6mr13798868ugg.1165330786942; Tue, 05
 Dec 2006 06:59:46 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id 54sm31948711ugp.2006.12.05.06.59.45; Tue, 05 Dec
 2006 06:59:46 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Dnia wtorek 5. grudnia 2006 15:48, Johannes Schindelin napisa=B3:
>=20
> On Tue, 5 Dec 2006, Jakub Narebski wrote:
>
>> Hmmm... would it be possible to use xdl_merge() for recursion, and=20
>> graphical merge tool for result? <Checks out earlier discussion>. I=20
>> think yes, because of exposing xdl_merge() in git-merge-onefile...
>=20
> In "next", only git-merge-recursive is converted to use xdl_merge(), =
and=20
> it did not use git-merge-one-file to begin with. Since this is a shel=
l=20
> script (with a different syntax than merge), it would have to be conv=
erted=20
> to a C builtin first. But feasible: git-merge-one-file takes 7 parame=
ters,=20
> the first 3 being SHA1s or empty strings. "merge" takes 3 filenames, =
with=20
> possibly up to three "-L <name>" pairs before them.

I thought that Junio implemented (but perhaps not published) some scrip=
t,
I thought that was git-merge-onefile with some non-standard options,
to function as replacement for RCS' merge, or Diffutils diff3.=20

Guess I was wrong (at least there is nothing I can find in pu about thi=
s).
--=20
Jakub Narebski
