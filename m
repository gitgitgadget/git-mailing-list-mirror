From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 8/8] Documentation/revert: describe passing more than one commit
Date: Wed, 2 Jun 2010 07:57:51 +0200
Message-ID: <201006020757.51575.chriscool@tuxfamily.org>
References: <20100531193359.28729.55562.chriscool@tuxfamily.org> <20100531194240.28729.15284.chriscool@tuxfamily.org> <AANLkTilu8C68FlLkNg_3wEjRRX25TaydZCve_P4r4_X7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Antriksh Pany <antriksh.pany@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 07:58:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJgxs-0006Ww-Eo
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 07:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248Ab0FBF6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 01:58:01 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:46746 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752231Ab0FBF6A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 01:58:00 -0400
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id C66C38180DA;
	Wed,  2 Jun 2010 07:57:52 +0200 (CEST)
User-Agent: KMail/1.12.2 (Linux/2.6.31-20-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <AANLkTilu8C68FlLkNg_3wEjRRX25TaydZCve_P4r4_X7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148207>

On Tuesday 01 June 2010 15:28:57 Antriksh Pany wrote:
> 
> > +git revert -n master\~5..master~2::
> 
> Is the backslash correct?

Yes, otherwise asciidoc does something strange with the text between both "~".

> > +
> > +       Revert the changes done by commits from the fiveth last commit
> 
> 'fifth' instead of 'fiveth' may be more appropriate :)

Yes!

Thanks,
Christian.
