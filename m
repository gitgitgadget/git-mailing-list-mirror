From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: install does not obey DESTDIR or --prefix for perl modules
Date: Tue, 22 Sep 2009 10:21:10 -0500
Message-ID: <u3kL87BpSTWlFUSold4Zu9qNO7FQG-a17sfZVC43MQqJj7qnjMBzsw@cipher.nrlssc.navy.mil>
References: <20090921160551.GD8173@gryning.com> <Ow6bpZou9Vi0tKlyAN-qfjlAAtXvMqpXEAiG54zZ3C8fLI_6_Bt3oA@cipher.nrlssc.navy.mil> <7vskeguqmb.fsf@alter.siamese.dyndns.org> <20090921191943.GE8173@gryning.com> <7vocp4ulq2.fsf@alter.siamese.dyndns.org> <20090922113151.GO8173@gryning.com> <Hfm4AdtlXpMutgmdj0vm7yb0ucfu_cijUloasBDWh6NfRCwLhP4OCA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: c@gryning.com
X-From: git-owner@vger.kernel.org Tue Sep 22 17:21:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mq7BE-0006VR-RJ
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 17:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756791AbZIVPVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 11:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756779AbZIVPVP
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 11:21:15 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:55153 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756776AbZIVPVO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 11:21:14 -0400
Received: by mail.nrlssc.navy.mil id n8MFLA6e007988; Tue, 22 Sep 2009 10:21:14 -0500
In-Reply-To: <Hfm4AdtlXpMutgmdj0vm7yb0ucfu_cijUloasBDWh6NfRCwLhP4OCA@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 22 Sep 2009 15:21:10.0594 (UTC) FILETIME=[508C9A20:01CA3B98]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128939>

Brandon Casey wrote:

> Did you try Junio's patch?  If the version of MakeMaker is the problem,
> then perhaps setting NO_PERL_MAKER=1 on the make command line along
                       ^^^^^^^^^^^^^

Should be NO_PERL_MAKEMAKER=1
