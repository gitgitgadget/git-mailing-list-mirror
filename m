From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] --count feature for git shortlog
Date: Tue, 30 Jun 2015 13:23:24 +0100
Message-ID: <20150630122323.GY18226@serenity.lan>
References: <1435540922-12208-1-git-send-email-lawrencesiebert@gmail.com>
 <xmqq1tgvdt9u.fsf@gitster.dls.corp.google.com>
 <CAKDoJU4HcGoOS83MKwsQBXztYrDomMd9N-2SKc6iRyNhQQM5Eg@mail.gmail.com>
 <CAKDoJU4MHGa-c=F0m17rgWUCS2xFwiSb1pmDnYztoDnzRaRKCw@mail.gmail.com>
 <19801032cd7af95bc8030f54d740bf48@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lawrence Siebert <lawrencesiebert@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 30 14:23:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9uZi-0000la-Aa
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 14:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387AbbF3MXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 08:23:36 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:58239 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380AbbF3MXf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 08:23:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 9B1D186601B;
	Tue, 30 Jun 2015 13:23:34 +0100 (BST)
X-Quarantine-ID: <vZ8g5nnAh0kY>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1.001
X-Spam-Level: 
X-Spam-Status: No, score=-1.001 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_40=-0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vZ8g5nnAh0kY; Tue, 30 Jun 2015 13:23:34 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 60B62CDA608;
	Tue, 30 Jun 2015 13:23:25 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <19801032cd7af95bc8030f54d740bf48@www.dscho.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273054>

On Tue, Jun 30, 2015 at 02:10:49PM +0200, Johannes Schindelin wrote:
> On 2015-06-29 18:46, Lawrence Siebert wrote:
> 
> > I appreciate your help. Okay, That all makes sense.
> > 
> > I would note that something like:
> >  git shortlog -s "$FILENAME:  | cut -f 1 | paste -sd+ - | bc
> > 
> > seems like it run much faster then:
> > 
> >  git log --oneline "$FILENAME" | wc -l
> 
> How does it compare to `git rev-list -- "$FILENAME" | wc -l`?

Or even `git rev-list --count HEAD -- "$FILENAME"`.
