From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: log --graph --first-parent weirdness
Date: Wed, 4 Jun 2008 20:38:20 +0300
Message-ID: <20080604173820.GA3038@mithlond.arda.local>
References: <20080604150042.GA3038@mithlond.arda.local> <7vmym1xgy4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Simpkins <adam@adamsimpkins.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 19:40:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3wxs-00054O-Pn
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 19:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756535AbYFDRjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 13:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755541AbYFDRjH
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 13:39:07 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:58145 "EHLO
	kirsi1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754504AbYFDRjG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 13:39:06 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.rokki.sonera.fi (8.5.014)
        id 483E837C004E8BA7; Wed, 4 Jun 2008 20:38:21 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1K3wwG-0000pC-IG; Wed, 04 Jun 2008 20:38:20 +0300
Content-Disposition: inline
In-Reply-To: <7vmym1xgy4.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83799>

Junio C Hamano wrote (2008-06-04 10:12 -0700):

> Teemu Likonen <tlikonen@iki.fi> writes:
> 
> > The output of "git log --graph --first-parent" seems weird.
> 
> Heh, --first-parent means "I'll view everything as a single strand of
> pearls".  Who in the right mind would use --graph at the same time to
> begin with ;-)?

Exactly :) I have an alias "lg = log --graph" and I almost always use
that instead of the normal log. Then I accidentally noticed that my "git
lg" doesn't quite fit with --first-parent.

> We could turn --graph automatically off if --first-parent is given,
> but I tend to agree with you that the right behaviour is to show the
> same "everything prefixed with '| ', wasting two columns without good
> reason" output as you would see on a true linear history.

To me it's perfectly fine to turn off --graph when used with
--first-parent, but yes, generally users might expect to see a line of
M's, *'s and |'s there. At least it would clearly show which commits are
merges and which are not.
