From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: Re: [PATCH 03/15] manpages: fix bogus whitespace
Date: Thu, 3 Jul 2008 20:14:20 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0807032001110.24268@harper.uchicago.edu>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
 <7viqvqov01.fsf@gitster.siamese.dyndns.org> <Pine.GSO.4.62.0807022322380.16085@harper.uchicago.edu>
 <Pine.GSO.4.62.0807022354520.16085@harper.uchicago.edu>
 <7vprpuwmjj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 03:15:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEZtt-00027C-KK
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 03:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621AbYGDBOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 21:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753491AbYGDBOv
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 21:14:51 -0400
Received: from smtp02.uchicago.edu ([128.135.12.75]:43930 "EHLO
	smtp02.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189AbYGDBOu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 21:14:50 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp02.uchicago.edu (8.13.8/8.13.8) with ESMTP id m641ERsF030468;
	Thu, 3 Jul 2008 20:14:27 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m641ELVA024512;
	Thu, 3 Jul 2008 20:14:21 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <7vprpuwmjj.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87355>

Junio C Hamano wrote:

> Jonathan Nieder <jrnieder@uchicago.edu> writes:
> 
>> -	is successful.	This option disables the output shown by
>> +	is successful.  This option disables the output shown by
> 
> How did you find *this* one?  It took me a few minutes to finally notice
> that you are talking about the HT.  In other words, I had to work hard to
> get distracted by it.

I use vim with listchars=tab:>-,nbsp:~,trail:$ (I was bit too
many times by Makefiles mysteriously breaking) so the tab is
visibile.

If it feels like too much churn for no visible effect, I don't
mind if you drop the patch. I feel bad for sending so many
documentation patches that don't add to the content in any
significant way.

Jonathan
