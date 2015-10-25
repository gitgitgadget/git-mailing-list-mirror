From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] sh-setup: explicitly mark CR as a field separator
Date: Sun, 25 Oct 2015 14:26:56 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1510251426150.31610@s15462909.onlinehome-server.info>
References: <cover.1445777347.git.johannes.schindelin@gmx.de> <214d877df18f3189b1809946817aab9765450ea9.1445777347.git.johannes.schindelin@gmx.de> <36EB0AFDC58D44F3B48BFA044EA15547@PhilipOakley>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Chad Boles <chadbo@microsoft.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Oct 25 14:27:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqLKL-0001lA-43
	for gcvg-git-2@plane.gmane.org; Sun, 25 Oct 2015 14:27:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbbJYN1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2015 09:27:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:62148 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092AbbJYN1F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2015 09:27:05 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0MDzGN-1ZjU6A2jVP-00HKSW;
 Sun, 25 Oct 2015 14:26:57 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <36EB0AFDC58D44F3B48BFA044EA15547@PhilipOakley>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:b5+N6/jVTcQqS7wkLrKBpM3sj2XkcN+7R0OiCJns3QwR0qiHaQL
 6nrERXeFQR2AFkXQL+s1piQGp8JASFg1K3BVEV17Y/E77XD6lnbqgsZa02CX8ivSJzCdWOD
 3lEIiAPP4pI9KXNDf+SfAqHkX0rKsV8hYtGwaRGKK5kuvofj0YPK4skTvclm20uLj+TFNAn
 /Q5TjbPajgXvlEHP385jw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SSQD/7kUpWQ=:zTN3qmwiglDhVJasvqp53E
 VsqDfOnDcTxY5Wkf7wP+ZHeo3I0SigxhD0Rp1X+GJT7P4g2JQPx67/Eis+KZ1/5utawyMMrHT
 GLHdDuPYUNtq1DkOgb71vOqDlnCj8H5v3sZxAxklwleLRy88wSfs34nc97yOgR5tve6ZBbcfn
 BoFHe69Djn5/wCdykLQqQcrx1RpRQW0LSDDS9bDO+qJq5eSyPhv7dcQ65UJCkVYADjWn4FtZy
 gcdyVK+Upm8SEZzY+Noj3WNzMwX0GZmOUxhLQvyATqjEdSaeUltcaeuoc1Nhsrq48+gjM9UjP
 u2dM1Ez1cgPGlRR21stAKkcUqKm+LHl7x6imPnm7WjhUbr0jVmN+zKXtr1b8LTOM3CndW8zMZ
 T1YVBU0GZnycAErxqoBGd4xfrUA4L+nVUjiD0cOxM+O4uVE3/9nMAGP4m6XcVt+3jtcRoFiEn
 Z0/BSmHIFDGXV7rAahKT2NqgULf+qj5GQGWtBJE3qdQCxp7r77x5EgKIsRC3Qx4rhxvZyXBYN
 8rRZSwILh9OdxLl8HN7BWVt5e/PhJvdn30hY2NCDEp8jV5Rbhjun5IRl/UndKc7lBehQvIWjl
 mKnlB2upCK5TDQzbS/0uBNqfYsOFRbuO3rFpriTmEt5T5uDuMKr0tH/Co7wdWsQelO7napBdg
 AdnTvltwHFbdMe7Nkz7hNHwC+p+/09i+lUTeE8xkGa9uuu0cgn+cMOUMnhrCqmHaWcJKkcw+K
 4OEcQnNsaCujOwvr4FIDLylPj+IHJvsuGft3fczmZ0fyr7Hp0v9FdobIzn7VLxTbYCLz9/2C 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280147>

Hi Philip,

On Sun, 25 Oct 2015, Philip Oakley wrote:

> From: "Johannes Schindelin" <johannes.schindelin@gmx.de>
> > @@ -13,7 +13,7 @@ unset CDPATH
> > # do not equate an unset IFS with IFS with the default, so here is
> > # an explicit SP HT LF.
> 
> Doesn't this comment also need an update, given the patch title?

Yes, you are right.

Ciao,
Dscho
