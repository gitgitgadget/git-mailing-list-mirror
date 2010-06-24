From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [GSoC update extra!] git-remote-svn: Week 8
Date: Thu, 24 Jun 2010 14:32:04 -0700
Message-ID: <20100624213204.GA22756@dcvr.yhbt.net>
References: <1277386408-29943-1-git-send-email-artagnon@gmail.com> <20100624173956.GA1600@burratino> <20100624180752.GA1642@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Shahaf <d.s@daniel.shahaf.name>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 23:32:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORu1s-00081j-M8
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 23:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492Ab0FXVcI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 17:32:08 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:60048 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751483Ab0FXVcG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 17:32:06 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 790781F517;
	Thu, 24 Jun 2010 21:32:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20100624180752.GA1642@burratino>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149654>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> [1] Eric, we are discussing the remote-svn series[2] and especially
> Ram, Sverre, and David=E2=80=99s recent comments[3].  Apologies for n=
ot
> keeping you in the loop sooner; your insights have always been
> helpful in the past.

No worries Jonathan, I've been preoccupied with several other projects,
none of which require dealing with SVN :)

> As for the idea of reimplementing git-svn on top of svn-fe: yes, the
> fast-import stream would need more information to support
> --follow-parent, but that piece is not so hard to add AFAICT.  Of
> course, I am mentioning this not because it is important to keep the
> git-svn interface but because the --stdlayout feature is very useful
> and we may want to port it over some day.

Yes, I've always found --stdlayout very convenient and hope it
lives on.

--=20
Eric Wong
