From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v4 10/45] sequencer: trivial fix
Date: Sun, 9 Jun 2013 19:18:10 +0200
Message-ID: <20130609171810.GA10858@goldbirke>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
 <1370796057-25312-11-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:18:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UljFy-0003tL-B5
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237Ab3FIRSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 13:18:14 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:50248 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184Ab3FIRSO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:18:14 -0400
Received: from localhost6.localdomain6 (f051160074.adsl.alicedsl.de [78.51.160.74])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0MHpe9-1Un6Ip3QFR-003bP3; Sun, 09 Jun 2013 19:18:11 +0200
Content-Disposition: inline
In-Reply-To: <1370796057-25312-11-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:CO9mXJAWo4G5XwSOAAawqqo+ZXPQ7+NquPwsJPnLQuT
 nX0J1fI/eSZp3BLnAVfJwJJYrngfeTxqMAoZtuKzPyEX5sx09i
 q5PGrvIQV6t3ioxHhTkdIybyPvZA5IgHcclmSNHBxYK1CgN/4s
 HO1gs+5NwHP+BtKNIThEhqhPUVCH7Y9akMdaRqVSI1+BwrL/41
 8wtfdF8hRzLHPR3VZbnxirDGyXJ/nGqsiK1eFz/1b38Dkg6zsx
 xP155om0OMkJUtafVn0EU7rcAjKsAgCd3EeK2rbPL6vANYr+VW
 ZwNqdBuCCAv9vadIABiIX4Ody5vx+FE8fpgoKPT0xi8M5NmNam
 ueh+ig6MEK/jnEeQrrYQJ0nuQJOv38WWUs6nnQlWE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227033>

On Sun, Jun 09, 2013 at 11:40:22AM -0500, Felipe Contreras wrote:
> We should free objects before leaving.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

A shortlog-friendlier subject could be: "sequencer: free objects
before leaving".
