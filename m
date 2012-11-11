From: Max Horn <max@quendi.de>
Subject: Re: [PATCH v5 02/15] remote-testgit: fix direction of marks
Date: Sun, 11 Nov 2012 21:39:28 +0100
Message-ID: <82C1BB44-EA99-47E4-91E3-36F4D17BAFBA@quendi.de>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com> <1352642392-28387-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 21:51:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXeVb-0002uK-21
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 21:51:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043Ab2KKUvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 15:51:39 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:35087 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753018Ab2KKUvi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Nov 2012 15:51:38 -0500
Received: from ip-178-200-227-112.unitymediagroup.de ([178.200.227.112] helo=[192.168.178.28]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1TXeJU-000796-NP; Sun, 11 Nov 2012 21:39:28 +0100
In-Reply-To: <1352642392-28387-3-git-send-email-felipe.contreras@gmail.com>
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1352667098;664bca81;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209445>


On 11.11.2012, at 14:59, Felipe Contreras wrote:

> Basically this is what we want:
> 
>  == pull ==
> 
> 	testgit			transport-helper
> 
> 	* export ->		import
> 
> 	# testgit.marks		git.marks
> 
>  == push ==
> 
> 	testgit			transport-helper
> 
> 	* import		<- export
> 
> 	# testgit.marks		git.marks
> 
> Each side should be agnostic of the other side. Because testgit.marks
> (our helper marks) could be anything, not necesarily a format parsable

Typo: necesarily => necessarily


Cheers,
Max
