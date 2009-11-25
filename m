From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-subtree: directory mismatch
Date: Thu, 26 Nov 2009 00:17:45 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0911260013550.4985@pacific.mpi-cbg.de>
References: <20091124195353.GA16627@lonquimay.wrk.lsn.camptocamp.com> <32541b130911241348s21e21fb8n12edf374e6a3c309@mail.gmail.com> <20091125080812.6117@nanako3.lavabit.com> <32541b130911251028h6db240d5yd171fa4941ef14ba@mail.gmail.com>
 <7v7htexuxc.fsf@alter.siamese.dyndns.org> <32541b130911251148v70a5dc77k9936881d0b382ec2@mail.gmail.com> <7vpr76uzju.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Marc Fournier <marc.fournier@camptocamp.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 00:13:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDR3X-0001vz-BD
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 00:13:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbZKYXNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 18:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbZKYXNi
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 18:13:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:41650 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964979AbZKYXNh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 18:13:37 -0500
Received: (qmail invoked by alias); 25 Nov 2009 23:13:42 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp057) with SMTP; 26 Nov 2009 00:13:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/6EEovvaz6sPuTyeE5VK7A8nwnrypqQhRT7/BPJH
	fDBZp6QdkGzl0f
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vpr76uzju.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133697>

Hi,

On Wed, 25 Nov 2009, Junio C Hamano wrote:

> I do remember some people didn't like -X<option> syntax but I don't 
> think there was any solid counterproposal to achieve a similar goal to 
> satisfy the need to pass arbitrary parameters to the merge strategy 
> backends.

I took exception to the awkward way to specify the option.  A strong hint 
just how awkward -X<option> is: it is hard to implement using 
parse-options.

There is no real reason to do it properly, i.e. with an option 
--merge-option <option> or --backend-option <option> or -X <option> (even 
if "-X" is not really an expressive name, to be real honest).

BTW the same goes for -S<string>, but unfortunately, we have to keep it 
to maintain backwards compatibility.

Ciao,
Dscho
