From: Tony Finch <dot@dotat.at>
Subject: Re: [PATCH v4 2/4] gitweb: vertically centre contents of page
 footer
Date: Wed, 21 Aug 2013 10:06:37 +0100
Message-ID: <alpine.LSU.2.00.1308211003040.6019@hermes-2.csi.cam.ac.uk>
References: <cover.1377019362.git.dot@dotat.at> <5c4afd189553d0f1e83b0c2b9758643deba5a671.1377019362.git.dot@dotat.at> <xmqq1u5ow33c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Tony Finch <dot@dotat.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 11:06:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VC4NI-0008In-1B
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 11:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644Ab3HUJGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 05:06:40 -0400
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:35719 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511Ab3HUJGj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 05:06:39 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:34724)
	by ppsw-33.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:25)
	with esmtpa (EXTERNAL:fanf2) id 1VC4NB-0007S7-go (Exim 4.80_167-5a66dd3)
	(return-path <fanf2@hermes.cam.ac.uk>); Wed, 21 Aug 2013 10:06:37 +0100
Received: from fanf2 by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1VC4NB-0000e3-7W (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Wed, 21 Aug 2013 10:06:37 +0100
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
In-Reply-To: <xmqq1u5ow33c.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232695>

Junio C Hamano <gitster@pobox.com> wrote:
> Tony Finch <dot@dotat.at> writes:
>
> >  div.page_footer {
> > -	height: 17px;
> > +	height: 22px;
> >  	padding: 4px 8px;
> >  	background-color: #d9d8d1;
> >  }
> >
> >  div.page_footer_text {
> > +	line-height: 22px;
> >  	float: left;
> >  	color: #555555;
> >  	font-style: italic;
>
> Hmmm, is it a good idea to do "px" here, or are they ways to do
> relative to x-height or something to make sure the text fits?

Good question. I also don't know much about css. I basically followed the
style that was already there, and found out about vertical centering using
line-height by searching the web.

I think font-size relative scaling would require a bigger overhaul.

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
Forties, Cromarty: East, veering southeast, 4 or 5, occasionally 6 at first.
Rough, becoming slight or moderate. Showers, rain at first. Moderate or good,
occasionally poor at first.
