From: Kevin Daudt <me@ikke.info>
Subject: Re: [PATCH v5] rev-list: refuse --first-parent combined with --bisect
Date: Sat, 21 Mar 2015 23:01:44 +0100
Message-ID: <20150321220144.GG11832@vps892.directvps.nl>
References: <1425934575-19581-1-git-send-email-me@ikke.info>
 <1426803248-6905-1-git-send-email-me@ikke.info>
 <xmqqh9tghaky.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 23:01:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZRSo-0000a0-T6
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 23:01:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbbCUWBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2015 18:01:47 -0400
Received: from ikke.info ([178.21.113.177]:53089 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751403AbbCUWBq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 18:01:46 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id 4EBD81DCF6D; Sat, 21 Mar 2015 23:01:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqqh9tghaky.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266037>

On Thu, Mar 19, 2015 at 03:43:57PM -0700, Junio C Hamano wrote:
> Kevin Daudt <me@ikke.info> writes:
> 
> > rev-list --bisect is used by git bisect, but never together with
> > --first-parent. Because rev-list --bisect together with --first-parent
> > is not handled currently, and even leads to segfaults, refuse to use
> > both options together.
> >
> > Because this is not supported, it makes little sense to use git log
> > --bisect --first parent either, because refs/heads/bad is not limited to
> > the first parent chain.
> >
> > Helped-by: Junio C. Hamano <gitster@pobox.com>
> > Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> > Signed-off-by: Kevin Daudt <me@ikke.info>
> > ---
> 
> Thanks; will queue.

Thank you too, for your thorough explanation in this.
