From: Johan Herland <johan@herland.net>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit state
Date: Thu, 15 Jan 2009 14:54:30 +0100
Message-ID: <200901151454.30670.johan@herland.net>
References: <87ab9th0rh.fsf@cup.kalibalik.dk> <200901151101.53441.johan@herland.net> <bd6139dc0901150352t2d2fa388x3eb842bbc8c4baa6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Sverre Rabbelier" <srabbelier@gmail.com>,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Anders Melchiorsen" <mail@cup.kalibalik.dk>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 14:56:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNShf-0000W0-Cw
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 14:56:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754907AbZAONyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 08:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754730AbZAONyq
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 08:54:46 -0500
Received: from sam.opera.com ([213.236.208.81]:49527 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753376AbZAONyp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 08:54:45 -0500
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id n0FDsU90020921
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 15 Jan 2009 13:54:36 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <bd6139dc0901150352t2d2fa388x3eb842bbc8c4baa6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105807>

On Thursday 15 January 2009, Sverre Rabbelier wrote:
> On Thu, Jan 15, 2009 at 11:01, Johan Herland wrote:
> > "modify" does the "git reset --soft HEAD^" (Anders' suggestion)
> > "amend" requires a "git commit --amend" (current behaviour)
>
> Why have amend do the same as edit?

The names I chose are somewhat arbitrary, since we obviously have to 
keep on bikeshedding until we have something everybody can agree to.

However, my rationale was that IMO the word "edit" more closely matches 
Anders' suggestion, and is therefore somewhat misleading as a 
description of the current behaviour. But we obviously cannot change 
the meaning of "edit" without upsetting current users. Therefore, 
introduce "amend" to more accurately describe the current behaviour. As 
for "modify", it was simply the best synonym for "edit" I could find.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
