From: Lukas Fleischer <lfleischer@lfos.de>
Subject: Re: Mark remote `gc --auto` error messages
Date: Thu, 02 Jun 2016 22:06:46 +0200
Message-ID: <146489800609.1944.4398103814754920753@typhoon.lan>
References: <146489432847.688.11121862368709034386@typhoon>
 <xmqqinxrtmgi.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 22:06:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8YtK-000781-JT
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 22:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbcFBUGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 16:06:49 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:14778 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932111AbcFBUGt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2016 16:06:49 -0400
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id fc270316
	TLS version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO;
	Thu, 2 Jun 2016 22:06:47 +0200 (CEST)
In-Reply-To: <xmqqinxrtmgi.fsf@gitster.mtv.corp.google.com>
User-Agent: alot/0.3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296233>

On Thu, 02 Jun 2016 at 21:33:33, Junio C Hamano wrote:
> Lukas Fleischer <lfleischer@lfos.de> writes:
> 
> > When running `git push`, it might occur that error messages are
> > transferred from the server to the client. While most messages (those
> > explicitly sent on sideband 2) are prefixed with "remote:", it seems
> > that error messages printed during the automatic householding performed
> > by git-gc(1) are displayed without any additional decoration. Thus, such
> > messages can easily be misinterpreted as git-gc failing locally, see [1]
> > for an actual example of where that happened.
> 
> Sounds like a sensible goal to me.

What exactly are you referring to (you only quoted the introduction)?
Do you think we should fix the git-gc issue but keep the general
behavior of printing messages unaltered? Do you think it would be
worthwhile to make server messages distinguishable in general?
