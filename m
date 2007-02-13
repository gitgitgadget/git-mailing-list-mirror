From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Tue, 13 Feb 2007 18:16:27 +0600
Message-ID: <200702131816.27705.litvinov2004@gmail.com>
References: <45CFA30C.6030202@verizon.net> <200702130932.51601.litvinov2004@gmail.com> <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 13 13:16:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGwaQ-0006Ym-G8
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 13:16:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbXBMMQj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 13 Feb 2007 07:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbXBMMQj
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 07:16:39 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:51180 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbXBMMQi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Feb 2007 07:16:38 -0500
Received: by nf-out-0910.google.com with SMTP id o25so256930nfa
        for <git@vger.kernel.org>; Tue, 13 Feb 2007 04:16:36 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jVLrDuvbl1kzM11kczQxtklsp3Mi+9l2jGkLnlVmDaTIcrfI6BoW9rZSPCLBuK/plzI3x/tcSs0tVv++dCiv2BP9VzY5fz3rqjzLU9pBJgaNa1l5mgueR4PzPUVyzAcdmab39EHKyNoXfeL61QAO8Fv1QrHvh6VQV3aJWSkTmcU=
Received: by 10.82.153.5 with SMTP id a5mr12492870bue.1171368996623;
        Tue, 13 Feb 2007 04:16:36 -0800 (PST)
Received: from lan.ac-sw.lcl ( [81.1.223.2])
        by mx.google.com with ESMTP id 13sm10109283ugb.2007.02.13.04.16.34;
        Tue, 13 Feb 2007 04:16:35 -0800 (PST)
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39519>

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 Tuesday 13 February 2007 16:06 Johannes Schindelin =D0=BD=D0=B0=D0=BF=
=D0=B8=D1=81=D0=B0=D0=BB(a):
> Hi,
>
> On Tue, 13 Feb 2007, Alexander Litvinov wrote:
> > When I have file that was converted from dos to unix format (or fro=
m
> > unix to dos) git genereta big diff. But anyway, c++ compiler works =
well
> > with both formats and in this case I simply convert file to dos for=
mat
> > and git shows again nice diff. If unix format was commited to git I
> > simply change the format and commit that file again.
>
> That's awful!
If you are tring to build history that looks good - you are right this =
is a=20
terrible workflow.

> > The only trouble is the rebase, it does not like \r\n ending and ot=
hen
> > produce unexpected merge conflict. But I don't use rebse to othen t=
o
> > realy investigate and try to solve the problem.
>
> Well, if everybody thinks like you, maybe we do not have to change
> anything for Windows after all?
I still wish to have working rebase so if git will hanle somehow \r\n i=
t would=20
be nice. But please do not produce the same behavior as cvs does: under=
=20
cygwin it still use \n !

By the way, most windows programmers I work with says 'git is cool but =
is=20
there gui like tortoise or wincvs ?' :-)
