From: Rogan Dawes <discard@dawes.za.net>
Subject: Re: [PATCH] git-completion.bash: prevent 'git help' from searching
    for git repository
Date: Fri, 04 Sep 2009 11:43:30 +0200
Message-ID: <4AA0E142.4080105@dawes.za.net>
References: <20090902095843.28914.qmail@3cd9dde586d86b.315fe32.mid.smarden.org> <fabb9a1e0909020447p212594cake8c6fe3a43b667ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Gerrit Pape <pape@smarden.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 11:47:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjVOU-00075N-0i
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 11:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933445AbZIDJoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 05:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933461AbZIDJoW
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 05:44:22 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:35510 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933445AbZIDJoT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 05:44:19 -0400
Received: from homiemail-a5.g.dreamhost.com (caiajhbdcaid.dreamhost.com [208.97.132.83])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 5302517CDA6
	for <git@vger.kernel.org>; Fri,  4 Sep 2009 02:44:20 -0700 (PDT)
Received: from artemis.local (dsl-246-53-55.telkomadsl.co.za [41.246.53.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a5.g.dreamhost.com (Postfix) with ESMTP id 7FDC0BC9A8;
	Fri,  4 Sep 2009 02:43:38 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <fabb9a1e0909020447p212594cake8c6fe3a43b667ec@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127701>

Sverre Rabbelier wrote:
> Heya,
> 
> On Wed, Sep 2, 2009 at 11:58, Gerrit Pape<pape@smarden.org> wrote:
>> +       for i in $(git --git-dir=/nonexistent help -a|egrep '^ ')
> 
> Wouldn't implementing "git --no-git-dir" be more appropriate?
> 

Or documenting which git commands do/don't require a git dir at all?

I assume that documenting those that don't would be better than
documenting those that do . . .

And by documenting, I mean in the code, so that the code can DTRT.

Otherwise, having this switch lets people shoot themselves in the foot,
I'd think.

Rogan
