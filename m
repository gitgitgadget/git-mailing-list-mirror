From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 10/11] Introduce git_etc_gitconfig() that encapsulates access of ETC_GITCONFIG.
Date: Tue, 13 Nov 2007 22:35:13 +0100
Message-ID: <200711132235.13463.johannes.sixt@telecom.at>
References: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at> <1194984306-3181-11-git-send-email-johannes.sixt@telecom.at> <Pine.LNX.4.64.0711132121440.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 22:36:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is3Qa-0002Dp-28
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 22:36:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760644AbXKMVfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 16:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760724AbXKMVfR
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 16:35:17 -0500
Received: from smtp5.srv.eunet.at ([193.154.160.227]:55582 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760644AbXKMVfP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 16:35:15 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id D8A5613A889;
	Tue, 13 Nov 2007 22:35:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id A243959084;
	Tue, 13 Nov 2007 22:35:13 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0711132121440.4362@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64874>

On Tuesday 13 November 2007 22:22, Johannes Schindelin wrote:
> Hi,
>
> On Tue, 13 Nov 2007, Johannes Sixt wrote:
> > diff --git a/config.c b/config.c
> > index dc3148d..dd7e9ad 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -452,6 +452,11 @@ int git_config_from_file(config_fn_t fn, const char
> > *filename) return ret;
> >  }
> >
> > +const char *git_etc_gitconfig(void)
> > +{
> > +	return ETC_GITCONFIG;
> > +}
> > +
>
> Wouldn't this logically belong into environment.c?

I don't think so. environment.c is about things that concern the repository. 
This is really only about configuration.

-- Hannes
