From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] t9350: point out that refs are not updated
 correctly
Date: Wed, 24 Oct 2012 23:41:39 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1210242333550.5980@bonsai2>
References: <1320535407-4933-1-git-send-email-srabbelier@gmail.com> <1320535407-4933-2-git-send-email-srabbelier@gmail.com> <CAMP44s1hdZb_7Lv8SEe+MsfC_q-nXsnjJobABFq6eFR_er4TaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	=?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Eric Herman <eric@freesa.org>,
	Fernando Vezzosi <buccia@repnz.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 23:42:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TR8i9-0003Xu-Vq
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 23:42:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161279Ab2JXVls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 17:41:48 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:51685 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1161249Ab2JXVlp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 17:41:45 -0400
Received: (qmail invoked by alias); 24 Oct 2012 21:41:43 -0000
Received: from ip-83-99-17-77.luxfiber.pt.lu (EHLO bonsai2.local) [83.99.17.77]
  by mail.gmx.net (mp039) with SMTP; 24 Oct 2012 23:41:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18a0J00olYaaLN9ENAivYXxh+y27M+V46lo68CXWc
	HS24KlQae57FCI
X-X-Sender: gene099@bonsai2
In-Reply-To: <CAMP44s1hdZb_7Lv8SEe+MsfC_q-nXsnjJobABFq6eFR_er4TaA@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208326>

Hi,

On Wed, 24 Oct 2012, Felipe Contreras wrote:

> 2) master..master shouldn't export anything

The underlying issue -- as explained in the thread -- is when you want to
update master to a commit that another ref already points to. In that case
no commits need to exported, but the ref needs to be updated nevertheless.

We just wrote the test in the most convenient way, no need to complicate
things more than necessary.

Hth,
Johannes
