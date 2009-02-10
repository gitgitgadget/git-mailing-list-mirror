From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [PATCH v2] Support "\" in non-wildcard exclusion entries
Date: Tue, 10 Feb 2009 18:23:19 +0100
Message-ID: <20090210172318.GA11384@pvv.org>
References: <20090210121149.GA1226@pvv.org> <alpine.DEB.1.00.0902101354460.10279@pacific.mpi-cbg.de> <20090210125800.GA14800@pvv.org> <alpine.DEB.1.00.0902101402230.10279@pacific.mpi-cbg.de> <20090210142017.GA16478@pvv.org> <alpine.DEB.1.00.0902101525380.10279@pacific.mpi-cbg.de> <20090210143742.GB16478@pvv.org> <7vab8upb5v.fsf@gitster.siamese.dyndns.org> <7v7i3ynt1z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 18:24:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWwLs-0006MU-6K
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 18:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193AbZBJRXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 12:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753188AbZBJRXY
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 12:23:24 -0500
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:51498 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341AbZBJRXY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 12:23:24 -0500
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1LWwKN-0008EL-3X; Tue, 10 Feb 2009 18:23:19 +0100
Content-Disposition: inline
In-Reply-To: <7v7i3ynt1z.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109280>

On Tue, Feb 10, 2009 at 08:41:12AM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> Oh, by the way, do we really want to add a new test script?  I am
> wondering why the test is not an update to an existing test for the
> exclusion feature, such as t/t3001-ls-files-others-exclude.sh

I really did not want to add a new test script, but extending 3001
with this test seemed to make the test slightly more opaque. I can try
adding it to 3001 and see what it ends up looking like.

- Finn Arne
