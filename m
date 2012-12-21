From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: Python version auditing followup
Date: Fri, 21 Dec 2012 19:44:10 +0100
Message-ID: <006101cddfab$2afb0cf0$80f126d0$@schmitz-digital.de>
References: <20121220143411.BEA0744105@snark.thyrsus.com> <7vobho60fs.fsf@alter.siamese.dyndns.org> <kb001v$vps$1@ger.gmane.org> <7vzk182yka.fsf@alter.siamese.dyndns.org> <000d01cddf4c$8cbf2ca0$a63d85e0$@schmitz-digital.de> <7va9t71cqa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 19:44:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm7aD-0008NO-NB
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 19:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989Ab2LUSoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 13:44:16 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:61271 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260Ab2LUSoO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 13:44:14 -0500
Received: from DualCore (dsdf-4d0a157e.pool.mediaWays.net [77.10.21.126])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0MCTBN-1Tv9z82tM1-0098VN; Fri, 21 Dec 2012 19:44:12 +0100
In-Reply-To: <7va9t71cqa.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQGJcJ0OStfQbsM1tIQ7oyx+MGbnCwL3z68DAeXO9zcB00FfDgITTBHlAfhQa3mYVpD8UA==
Content-Language: de
X-Provags-ID: V02:K0:qIy95XRsUanjTJlNOEJQDZRVi3i1xjPL6Vtbx986iUM
 GaiJCsCHxlqJiIWEu57/DtUxfjWaGLO4U30hHiGqnWQOKNGKmf
 WWMX/fwnk16BsZZKJacMAyTS2L5ShQQhnkpsxMINK3pNVIwRsP
 if+g4eHtE9e48y66HfbJnsq/NBi8GWE3oE06lYT0iVsycNx/j6
 MAtDv+X5yjfLNhrwcEMmuZ9xLYwvcDHSuskaEUsa4j9Wmzo84Y
 OsayFqtaYXIF83lz0idjlFFSpAWXijfpxSOS15g/DqCxCZJI4U
 wr3kRdiODSUxQLj9nj4aj10MZZSZRraTQAr2aO6qBGkLatvbJV
 bA4GgKmWSWtMM5p9oAqillFLPCKIPn5bs8VNO+F17nmH3+E0Ta
 pM7fB0igNDiGA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212001>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Friday, December 21, 2012 7:28 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: Python version auditing followup
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> >> > We have a working 2.4.2 for HP-NonStop and some major problems getting
> >> > 2.7.3 to work.
> >>
> >> I do not think a platform that stops at 2.4.2 instead of going to
> >> higher 2.4.X series deserves to be called "long term maintained by
> >> their vendors".  It sounds more like "attempted to supply 2.4.X and
> >> abandoned the users once one port was done" to me.
> >
> > Well, not entirely wrong, but not all true at too.
> > I guess I need to defend the vendor here: It is not really the
> > Vendor (HP) that provided Python 2.4.2 or tries to provide 2.7.3,
> > it is a volunteer and community effort. HP did sponsor the 2.4.2
> > port though (by allowing an HP employee to do the port inn his
> > regular working hours). It is not doing this any longer (since
> > 2007). Since then it is a small group doing this on a purely
> > voluntary basis in their spare time (one HP employee amongst them,
> > me).  Same goes for the git port BTW.
> 
> For the purpose of "if we draw the line at 2.6, would it hurt many
> people who have been happily using the existing release of Git that
> was happy with 2.4", it is dubious HP-NonStop counts.  It is not
> like the users on that platform have been happily using Python based
> Porcelain at the fringe of Git, and drawing the line at 2.6 will not
> give them any regression.

You asked for opions and obhections, you got mine ;-)
