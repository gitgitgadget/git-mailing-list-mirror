From: Frans Pop <elendil@planet.nl>
Subject: Re: Testing if a certain commit is in the current branch
Date: Wed, 27 Jan 2010 09:47:40 +0100
Message-ID: <201001270947.41480.elendil@planet.nl>
References: <201001270819.39819.elendil@planet.nl> <vpqiqaonec1.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jan 27 09:49:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na3aa-0006kg-Fd
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 09:49:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793Ab0A0Irn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 03:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752039Ab0A0Irn
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 03:47:43 -0500
Received: from Cpsmtpm-eml107.kpnxchange.com ([195.121.3.11]:59156 "EHLO
	CPSMTPM-EML107.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751395Ab0A0Irn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2010 03:47:43 -0500
Received: from aragorn.fjphome.nl ([77.166.180.99]) by CPSMTPM-EML107.kpnxchange.com with Microsoft SMTPSVC(7.0.6001.18000);
	 Wed, 27 Jan 2010 09:47:41 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <vpqiqaonec1.fsf@bauges.imag.fr>
Content-Disposition: inline
X-OriginalArrivalTime: 27 Jan 2010 08:47:41.0771 (UTC) FILETIME=[630E59B0:01CA9F2D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138117>

On Wednesday 27 January 2010, Matthieu Moy wrote:
> Frans Pop <elendil@planet.nl> writes:
> > I'm currently using the following command for this:
> >    git log --pretty=format:%H | grep -q "^<commit id>"
> >
> > Problem is that with large repos that can be quite slow.
> >
> > Is there a faster way to do the test?
>
> Not answering the question exactly, but "git branch --contains
> <commitid>" does almost this and a bit more.

Thanks. That would work as:
   git branch --contains <commitid> | grep -q "^\*"

It's a lot slower than Junio's solution though (and even slower than my 
original solution).

Cheers,
FJP
