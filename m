From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH QGit RFC] Fix "Save patch..." on a commit range
Date: Tue, 16 Jun 2009 01:53:27 +0200
Message-ID: <200906160153.28018.markus.heidelberg@web.de>
References: <1244849357-31166-1-git-send-email-markus.heidelberg@web.de> <e5bfff550906151445m2f38c3fw964e01251d9568b9@mail.gmail.com> <e5bfff550906151507t3f6ccf39j177f7c39d8495f5a@mail.gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 01:53:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGLzw-0003wh-16
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 01:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbZFOXxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 19:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbZFOXxX
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 19:53:23 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:54841 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbZFOXxX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 19:53:23 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id BED2E1038B3DF;
	Tue, 16 Jun 2009 01:53:25 +0200 (CEST)
Received: from [89.59.70.41] (helo=.)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MGLzR-0006Tf-00; Tue, 16 Jun 2009 01:53:25 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <e5bfff550906151507t3f6ccf39j177f7c39d8495f5a@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/xV5RWLWDNWSPRFSa0yRWxnNW3qxJxkAL6C84d
	ZfemdYIUWe5tbH0D96HsOj0JYEXsAKnZASprBS1bibRu3FJNB3
	a6f8Kp5xjziERbx8uHkA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121640>

Marco Costalba, 16.06.2009:
> On Mon, Jun 15, 2009 at 22:45, Marco Costalba<mcostalba@gmail.com> wrote:
> > On Mon, Jun 15, 2009 at 22:25, Marco Costalba<mcostalba@gmail.com> wrote:
> >>
> >> This is really strange !
> >>
> >
> 
> I have prepared a possible patch, could you please test if fixes the
> problem for you.

Yes, it works. Thanks. Would it make sense and be possible to fix it
directly in ListView::getSelectedItems()?

BTW, a nice way to see the created git-format-patch command without
modifying the sources is to use a directory with spaces, which is not
handled correctly by qgit.

Markus
