From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 12/18] Disallow demoting grave fsck errors to warnings
Date: Mon, 22 Dec 2014 22:56:02 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412222254250.21312@s15462909.onlinehome-server.info>
References: <cover.1418055173.git.johannes.schindelin@gmx.de> <fcf343ed359ca47d6154f0d1e1850738eb7768ac.1418055173.git.johannes.schindelin@gmx.de> <xmqqd27ridl0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 22:56:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3AxZ-0001AT-SK
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 22:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755573AbaLVV4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 16:56:09 -0500
Received: from mout.gmx.net ([212.227.15.19]:59393 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755346AbaLVV4I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 16:56:08 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0MCLQ1-1YCHcx3oQb-0099kz;
 Mon, 22 Dec 2014 22:56:02 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqd27ridl0.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:UMhmH4rQsKz6euHsr48Ej/mQJkYS4JZiM/+hPoQwi48rXs3S3IJ
 VFwGj/0pn6MMmrt7TEMwe7LQL0+KPK/gpghBBjcfHznFwMzrR7WIsX+RSBWcZJCV/tS8QMX
 ffOGRNgeYhjyYJr1T1uLS6dJqb3pjz8GxDu2dAkErbV5OWGf0aFbyq+JLhGy+Zp6Wn/GaY2
 3cSNVFM0Wu+Cx6C4qi8Lg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261676>

Hi Junio,

On Wed, 10 Dec 2014, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Some kinds of errors are intrinsically unrecoverable (e.g. errors while
> > uncompressing objects). It does not make sense to allow demoting them to
> > mere warnings.
> 
> Makes sense, but the patch makes it look as if this is an "oops, we
> should have done the list in patch 02/18 in this order from the
> beginning".  Can we reorder the patches?

I considered this already, but it would more be like a squash than a
reordering. And when I squashed the patches, the story did not read as
clearly to me as it does now. However, if you think this argument is too
weak, I will squash them.

Is it too weak?

Ciao,
Dscho
