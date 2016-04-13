From: Stephen Kelly <steveire@gmail.com>
Subject: Re: Why doesn't gitk highlight commit references from git-describe?
Date: Wed, 13 Apr 2016 23:41:14 +0200
Message-ID: <nemedq$rh4$1@ger.gmane.org>
References: <nemal5$mb$1@ger.gmane.org> <CAGZ79kZVC0FxUN45KgLh-2tEK2=j2-yyTajYOc=s-LECgx+yqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 23:41:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqSXU-0003LK-Ky
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 23:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754259AbcDMVl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 17:41:28 -0400
Received: from plane.gmane.org ([80.91.229.3]:43194 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753211AbcDMVl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 17:41:28 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aqSXN-0003Ij-5X
	for git@vger.kernel.org; Wed, 13 Apr 2016 23:41:25 +0200
Received: from x55b39f7f.dyn.telefonica.de ([85.179.159.127])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 23:41:25 +0200
Received: from steveire by x55b39f7f.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 23:41:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x55b39f7f.dyn.telefonica.de
User-Agent: KNode/4.14 pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291489>

Stefan Beller wrote:

> How would you know(/code) that v1.6.0-rc0~120^2 is a text worth linking?
> "v1.6.0-rc0" is a custom string as that is how we name tags in this
> project. It can follow any convention in other projects.
> 
> Maybe a first approximation is if there is a `~` followed by numbers
> or a ^ character, inspect the whole thing if it is a reference into the
> history?

Would it be possible to implement linking for <tagname> optionally followed 
by something like that? Just tags should be links too, right?

> (Special case for git.git: Sometimes in a discussion you want to explain
> stuff and may use HEAD^ or such to demonstrate the use case. Other
> projects would not use that as much in descriptive text I would assume. So
> we'd need to make sure
> changing refs (i.e. branches, symbolic refs such as HEAD, FETCH_HEAD) are
> not considered worth linkifying.)

What does 'HEAD^' mean? If it is 'the commit before this one', then why not 
link it?

Thanks,

Steve.
